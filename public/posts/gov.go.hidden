package main

import (
	"errors"
	"fmt"
	"time"
)

// User represents a system user
type User struct {
	ID       int
	Username string
	Email    string
}

// Issue represents a problem that needs a solution
type Issue struct {
	ID          int
	Title       string
	Description string
	CreatedBy   User
	CreatedAt   time.Time
	Status      string // "Open", "In Progress", "Resolved", "Closed"
	Solutions   []int  // Store solution IDs
}

// Solution represents a proposed fix for an issue
type Solution struct {
	ID          int
	IssueID     int
	Title       string
	Description string
	ProjectPlan string
	ProposedBy  User
	ProposedAt  time.Time
	Votes       []Vote
	Bets        []Bet
}

// Vote represents a user's vote for a solution
type Vote struct {
	UserID     int
	SolutionID int
	CreatedAt  time.Time
}

// Bet represents a user's bet on a solution
type Bet struct {
	ID         int
	UserID     int
	SolutionID int
	Amount     float64
	CreatedAt  time.Time
}

// IssueTracker manages the issues, solutions, votes, and bets
type IssueTracker struct {
	Users     map[int]User
	Issues    map[int]Issue
	Solutions map[int]Solution
	Votes     []Vote
	Bets      map[int]Bet
	NextIDs   map[string]int
}

// NewIssueTracker creates a new instance of IssueTracker
func NewIssueTracker() *IssueTracker {
	return &IssueTracker{
		Users:     make(map[int]User),
		Issues:    make(map[int]Issue),
		Solutions: make(map[int]Solution),
		Votes:     []Vote{},
		Bets:      make(map[int]Bet),
		NextIDs: map[string]int{
			"user":     1,
			"issue":    1,
			"solution": 1,
			"bet":      1,
		},
	}
}

// CreateUser adds a new user to the system
func (it *IssueTracker) CreateUser(username, email string) User {
	id := it.NextIDs["user"]
	it.NextIDs["user"]++
	
	user := User{
		ID:       id,
		Username: username,
		Email:    email,
	}
	
	it.Users[id] = user
	return user
}

// CreateIssue adds a new issue to the system
func (it *IssueTracker) CreateIssue(title, description string, createdBy User) (Issue, error) {
	if _, exists := it.Users[createdBy.ID]; !exists {
		return Issue{}, errors.New("user does not exist")
	}
	
	id := it.NextIDs["issue"]
	it.NextIDs["issue"]++
	
	issue := Issue{
		ID:          id,
		Title:       title,
		Description: description,
		CreatedBy:   createdBy,
		CreatedAt:   time.Now(),
		Status:      "Open",
		Solutions:   []int{},
	}
	
	it.Issues[id] = issue
	return issue, nil
}

// ProposeSolution adds a solution to an issue
func (it *IssueTracker) ProposeSolution(issueID int, title, description, projectPlan string, proposedBy User) (Solution, error) {
	issue, exists := it.Issues[issueID]
	if !exists {
		return Solution{}, errors.New("issue does not exist")
	}
	
	if _, exists := it.Users[proposedBy.ID]; !exists {
		return Solution{}, errors.New("user does not exist")
	}
	
	id := it.NextIDs["solution"]
	it.NextIDs["solution"]++
	
	solution := Solution{
		ID:          id,
		IssueID:     issueID,
		Title:       title,
		Description: description,
		ProjectPlan: projectPlan,
		ProposedBy:  proposedBy,
		ProposedAt:  time.Now(),
		Votes:       []Vote{},
		Bets:        []Bet{},
	}
	
	it.Solutions[id] = solution
	
	// Add solution ID to the issue
	issue.Solutions = append(issue.Solutions, id)
	it.Issues[issueID] = issue
	
	return solution, nil
}

// VoteForSolution allows a user to vote for a solution
func (it *IssueTracker) VoteForSolution(userID, solutionID int) error {
	if _, exists := it.Users[userID]; !exists {
		return errors.New("user does not exist")
	}
	
	solution, exists := it.Solutions[solutionID]
	if !exists {
		return errors.New("solution does not exist")
	}
	
	// Check if user already voted for this solution
	for _, vote := range it.Votes {
		if vote.UserID == userID && vote.SolutionID == solutionID {
			return errors.New("user already voted for this solution")
		}
	}
	
	vote := Vote{
		UserID:     userID,
		SolutionID: solutionID,
		CreatedAt:  time.Now(),
	}
	
	it.Votes = append(it.Votes, vote)
	
	// Add vote to the solution
	solution.Votes = append(solution.Votes, vote)
	it.Solutions[solutionID] = solution
	
	return nil
}

// PlaceBet allows a user to bet on a solution
func (it *IssueTracker) PlaceBet(userID, solutionID int, amount float64) (Bet, error) {
	if _, exists := it.Users[userID]; !exists {
		return Bet{}, errors.New("user does not exist")
	}
	
	if _, exists := it.Solutions[solutionID]; !exists {
		return Bet{}, errors.New("solution does not exist")
	}
	
	if amount <= 0 {
		return Bet{}, errors.New("bet amount must be positive")
	}
	
	id := it.NextIDs["bet"]
	it.NextIDs["bet"]++
	
	bet := Bet{
		ID:         id,
		UserID:     userID,
		SolutionID: solutionID,
		Amount:     amount,
		CreatedAt:  time.Now(),
	}
	
	it.Bets[id] = bet
	
	// Add bet to the solution
	solution := it.Solutions[solutionID]
	solution.Bets = append(solution.Bets, bet)
	it.Solutions[solutionID] = solution
	
	return bet, nil
}

// GetWinningSolution returns the solution with the most votes for an issue
func (it *IssueTracker) GetWinningSolution(issueID int) (Solution, error) {
	issue, exists := it.Issues[issueID]
	if !exists {
		return Solution{}, errors.New("issue does not exist")
	}
	
	if len(issue.Solutions) == 0 {
		return Solution{}, errors.New("no solutions proposed for this issue")
	}
	
	var winningSolution Solution
	maxVotes := -1
	
	for _, solutionID := range issue.Solutions {
		solution := it.Solutions[solutionID]
		if len(solution.Votes) > maxVotes {
			maxVotes = len(solution.Votes)
			winningSolution = solution
		}
	}
	
	return winningSolution, nil
}

// GetTotalBetsForSolution calculates the total amount bet on a solution
func (it *IssueTracker) GetTotalBetsForSolution(solutionID int) (float64, error) {
	solution, exists := it.Solutions[solutionID]
	if !exists {
		return 0, errors.New("solution does not exist")
	}
	
	var total float64
	for _, bet := range solution.Bets {
		total += bet.Amount
	}
	
	return total, nil
}

// Demo function to show how the system works
func main() {
	tracker := NewIssueTracker()
	
	// Create users
	alice := tracker.CreateUser("alice", "alice@example.com")
	bob := tracker.CreateUser("bob", "bob@example.com")
	charlie := tracker.CreateUser("charlie", "charlie@example.com")
	
	// Create an issue
	issue, _ := tracker.CreateIssue(
		"Improve API performance", 
		"Our API is too slow, we need to optimize it", 
		alice,
	)
	
	// Propose solutions
	solution1, _ := tracker.ProposeSolution(
		issue.ID,
		"Cache implementation",
		"Implement Redis caching for frequently accessed data",
		"1. Set up Redis\n2. Identify hot spots\n3. Implement caching layer\n4. Test performance",
		bob,
	)
	
	solution2, _ := tracker.ProposeSolution(
		issue.ID,
		"Database optimization",
		"Optimize database queries and add indexes",
		"1. Analyze slow queries\n2. Add appropriate indexes\n3. Optimize query patterns\n4. Test performance",
		charlie,
	)
	
	// Vote for solutions
	tracker.VoteForSolution(alice.ID, solution1.ID)
	tracker.VoteForSolution(bob.ID, solution1.ID)
	tracker.VoteForSolution(charlie.ID, solution2.ID)
	
	// Place bets
	tracker.PlaceBet(alice.ID, solution1.ID, 100.0)
	tracker.PlaceBet(bob.ID, solution1.ID, 50.0)
	tracker.PlaceBet(charlie.ID, solution2.ID, 200.0)
	
	// Find the winning solution
	winner, _ := tracker.GetWinningSolution(issue.ID)
	fmt.Printf("The winning solution is: %s with %d votes\n", winner.Title, len(winner.Votes))
	
	// Get total bets on each solution
	total1, _ := tracker.GetTotalBetsForSolution(solution1.ID)
	total2, _ := tracker.GetTotalBetsForSolution(solution2.ID)
	
	fmt.Printf("Total bets on solution 1: $%.2f\n", total1)
	fmt.Printf("Total bets on solution 2: $%.2f\n", total2)
}