{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeApplications      #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE TypeOperators         #-}

module DAOGovernance where

import           Control.Monad          (void)
import qualified Data.Map               as Map
import           Data.Text              (Text)
import           Data.Aeson             (FromJSON, ToJSON)
import           GHC.Generics           (Generic)
import           Ledger
import qualified Ledger.Typed.Scripts   as Scripts
import           Ledger.Value           as Value
import qualified PlutusTx
import           PlutusTx.Prelude       hiding (Semigroup(..), unless)
import qualified PlutusTx.Prelude       as Plutus
import           Plutus.Contract
import qualified Plutus.V1.Ledger.Ada   as Ada
import qualified Plutus.V1.Ledger.Time  as Time
import           Schema                 (ToSchema)
import           Wallet.Emulator.Wallet

-- | Define the types for our DAO governance
data Topic = Topic
    { topicId          :: Integer
    , topicName        :: BuiltinByteString
    , topicDescription :: BuiltinByteString
    , isCore           :: Bool
    } deriving (Show, Generic, FromJSON, ToJSON, ToSchema)

PlutusTx.makeIsDataIndexed ''Topic [('Topic, 0)]
PlutusTx.makeLift ''Topic

data Proposal = Proposal
    { proposalId          :: Integer
    , proposalTitle       :: BuiltinByteString
    , proposalDescription :: BuiltinByteString
    , proposalBudget      :: Integer -- amount in lovelace
    , proposalDeadline    :: POSIXTime
    , proposalTopicId     :: Integer
    , proposalCreator     :: PubKeyHash
    , proposalType        :: ProposalType
    } deriving (Show, Generic, FromJSON, ToJSON, ToSchema)

data ProposalType = PolicyProposal | IssueSolutionProposal
    deriving (Show, Generic, FromJSON, ToJSON, ToSchema)

PlutusTx.makeIsDataIndexed ''ProposalType [('PolicyProposal, 0), ('IssueSolutionProposal, 1)]
PlutusTx.makeLift ''ProposalType

PlutusTx.makeIsDataIndexed ''Proposal [('Proposal, 0)]
PlutusTx.makeLift ''Proposal

data Vote = Vote
    { voteProposalId :: Integer
    , voteValue      :: VoteValue
    , voter          :: PubKeyHash
    } deriving (Show, Generic, FromJSON, ToJSON, ToSchema)

data VoteValue = For | Against
    deriving (Show, Generic, FromJSON, ToJSON, ToSchema)

PlutusTx.makeIsDataIndexed ''VoteValue [('For, 0), ('Against, 1)]
PlutusTx.makeLift ''VoteValue

PlutusTx.makeIsDataIndexed ''Vote [('Vote, 0)]
PlutusTx.makeLift ''Vote

data DAOParams = DAOParams
    { daoTokenSymbol        :: CurrencySymbol
    , minVotingPeriod       :: POSIXTime
    , policyLayerElectionInterval :: POSIXTime -- election interval (e.g., 2 years)
    , lastPolicyElection    :: POSIXTime
    , quorumPercentage      :: Integer  -- percentage of total tokens that need to vote
    } deriving (Show, Generic, FromJSON, ToJSON, ToSchema)

PlutusTx.makeIsDataIndexed ''DAOParams [('DAOParams, 0)]
PlutusTx.makeLift ''DAOParams

data DAODatum = DAODatum
    { daoTopics             :: [Topic]
    , daoProposals          :: [Proposal]
    , daoVotes              :: [(Integer, [Vote])]  -- Map proposal ID to votes
    , daoPolicyMembers      :: [PubKeyHash]         -- elected members
    , candidateStrategies   :: [(PubKeyHash, [Integer])] -- candidate -> topics they have strategy for
    } deriving (Show, Generic, FromJSON, ToJSON)

PlutusTx.makeIsDataIndexed ''DAODatum [('DAODatum, 0)]
PlutusTx.makeLift ''DAODatum

data DAOAction = 
      AddTopic Topic
    | UpdateTopic Topic
    | AddProposal Proposal
    | VoteOnProposal Vote
    | ExecuteProposal Integer
    | StartPolicyElection
    | RegisterCandidate PubKeyHash [Integer] -- pubkeyhash and topics they have strategy for
    | CastElectionVote PubKeyHash PubKeyHash -- voter and candidate
    | FinalizeElection
    deriving (Show, Generic, FromJSON, ToJSON, ToSchema)

PlutusTx.makeIsDataIndexed ''DAOAction [
    ('AddTopic, 0),
    ('UpdateTopic, 1),
    ('AddProposal, 2),
    ('VoteOnProposal, 3),
    ('ExecuteProposal, 4),
    ('StartPolicyElection, 5),
    ('RegisterCandidate, 6),
    ('CastElectionVote, 7),
    ('FinalizeElection, 8)
    ]
PlutusTx.makeLift ''DAOAction

-- Calculate voting power for an address
{-# INLINABLE votingPower #-}
votingPower :: DAOParams -> Value -> Integer
votingPower params val = valueOf val (daoTokenSymbol params) "DAO_TOKEN"

-- Check if a user has voting rights
{-# INLINABLE hasVotingRights #-}
hasVotingRights :: DAOParams -> Value -> Bool
hasVotingRights params val = votingPower params val > 0

-- Get votes for a proposal
{-# INLINABLE getVotesForProposal #-}
getVotesForProposal :: [(Integer, [Vote])] -> Integer -> [Vote]
getVotesForProposal votes proposalId = case find (\(pid, _) -> pid == proposalId) votes of
    Just (_, vts) -> vts
    Nothing       -> []

-- Count votes for a proposal
{-# INLINABLE countVotes #-}
countVotes :: [Vote] -> (Integer, Integer)
countVotes votes = foldr count (0, 0) votes
  where
    count v (f, a) = case voteValue v of
        For     -> (f + 1, a)
        Against -> (f, a + 1)

-- Check if a proposal has passed
{-# INLINABLE hasProposalPassed #-}
hasProposalPassed :: DAOParams -> DAODatum -> Proposal -> Bool
hasProposalPassed params datum proposal = 
    let votes = getVotesForProposal (daoVotes datum) (proposalId proposal)
        (forVotes, againstVotes) = countVotes votes
        totalVotes = forVotes + againstVotes
        totalTokens = 10000 -- In a real implementation, you'd calculate total tokens in circulation
        quorumReached = totalVotes * 100 >= quorumPercentage params * totalTokens
    in quorumReached && forVotes > againstVotes

-- Validate DAO operations
{-# INLINABLE validateDAO #-}
validateDAO :: DAOParams -> DAODatum -> DAOAction -> ScriptContext -> Bool
validateDAO params datum action ctx = 
    case action of
        AddTopic topic -> 
            policyMembersOnly && 
            not (any (\t -> topicId t == topicId topic) (daoTopics datum))
            
        UpdateTopic topic ->
            policyMembersOnly && 
            any (\t -> topicId t == topicId topic) (daoTopics datum)
            
        AddProposal proposal ->
            hasVotingRights params (valueSpent info) && 
            proposalDeadline proposal > now && 
            proposalDeadline proposal > now + minVotingPeriod params &&
            (proposalType proposal == IssueSolutionProposal || 
             elem (proposalCreator proposal) (daoPolicyMembers datum))
            
        VoteOnProposal vote ->
            hasVotingRights params (valueSpent info) && 
            any (\p -> proposalId p == voteProposalId vote && proposalDeadline p > now) (daoProposals datum) &&
            not (any (\v -> voter v == voter vote) (getVotesForProposal (daoVotes datum) (voteProposalId vote)))
            
        ExecuteProposal pid ->
            case find (\p -> proposalId p == pid) (daoProposals datum) of
                Just proposal -> now > proposalDeadline proposal && 
                                 hasProposalPassed params datum proposal
                Nothing       -> False
                
        StartPolicyElection ->
            policyMembersOnly && 
            now > lastPolicyElection params + policyLayerElectionInterval params
            
        RegisterCandidate pkh topics ->
            hasVotingRights params (valueSpent info) &&
            all (\tid -> any (\t -> topicId t == tid) (daoTopics datum)) topics
            
        CastElectionVote voter candidate ->
            hasVotingRights params (valueSpent info) &&
            any (\(c, _) -> c == candidate) (candidateStrategies datum)
            
        FinalizeElection ->
            policyMembersOnly &&
            now > lastPolicyElection params + policyLayerElectionInterval params + minVotingPeriod params
  where
    info :: TxInfo
    info = scriptContextTxInfo ctx
    
    now :: POSIXTime
    now = txInfoValidRange info UpperBound
    
    policyMembersOnly :: Bool
    policyMembersOnly = any (\pkh -> txSignedBy info pkh) (daoPolicyMembers datum)

-- Define the validator
{-# INLINABLE mkValidator #-}
mkValidator :: DAOParams -> DAODatum -> DAOAction -> ScriptContext -> Bool
mkValidator = validateDAO

-- Compile the validator
validator :: DAOParams -> Scripts.TypedValidator DAOValidator
validator params = Scripts.mkTypedValidator @DAOValidator
    ($$(PlutusTx.compile [|| mkValidator ||]) `PlutusTx.applyCode` PlutusTx.liftCode params)
    $$(PlutusTx.compile [|| wrap ||])
  where
    wrap = Scripts.wrapValidator @DAODatum @DAOAction

-- Define the validator types
type DAOValidator = Scripts.ValidatorType DAODatum DAOAction

-- Create the validator script
daoValidatorScript :: DAOParams -> Validator
daoValidatorScript = Scripts.validatorScript . validator