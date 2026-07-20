+++
author = "Oliver Bock"
title = "Agentic Workflow"
date = "2026-07-09"
description = "Agentic Workflow"
tags = [
    "Agentic"
]


+++
<!--more-->

A five-phase process for AI-assisted software development.

---

## 1. Proposal

Every change begins as a proposal. A proposal can be a feature request, an enhancement, or a bug report. I open these as issues on the repository. They represent my own ideas for how the product should evolve. At the same time, agents scan the codebase autonomously and raise issues of their own, often catching things I would miss. These two sources differ in nature. As the workflow matures, they tend to converge, but the distinction remains useful: some proposals reflect my product vision, others emerge from the code itself. Every proposal should include a clear description of what is being requested and why.

## 2. Architecture Decision Record

Once a proposal is accepted, we enter the design phase. Its purpose is to make informed decisions, weighed up, evaluating the pros and cons for each option. Not every issue has a single right answer. Some present multiple paths, each leading somewhere different. The right choice depends on context.

The ADR phase is a group effort. It begins with understanding the issue at hand. Next, the codebase is searched for everything relevant. Options are researched and then evaluated against one another. The evaluation criteria typically include feasibility, maintainability, performance, security, and alignment with the product direction.

Before committing to an implementation, I use three questions:

- What are the main issues?
- What does the perfect solution look like?
- What constraints exist — technical, organizational, or temporal?

These questions reveal the architectural framework conditions within which we operate.

The proposed decision is then challenged. Other agents — each with a different perspective — review the ADR. An SRE agent looks for reliability concerns. A security agent checks for vulnerabilities. Domain experts assess technical soundness. It is a kind of board decision, but kept simple. No deadlock, no bureaucracy. The goal is to surface blind spots, not to create them.

## 3. Technical Design and Implementation Plan

With the decision made, the technical design begins. This phase demands deep architectural understanding and a thorough command of the codebase.

The goal is to define the future state of the system and chart the path from where we are to where we need to be. Every constraint must be thought through. Every step must be outlined. The architect does not work in isolation. They stay in constant contact with technical domain experts, consulting them on each step to ensure the implementation is solid.

The design is challenged from multiple perspectives — SRE, security, and any other relevant domain. No plan survives first contact with reality unscathed, so the process is iterative. Objections are raised, the plan is adjusted, and the cycle repeats until no unresolved objections remain.

The output is a numbered implementation plan — concrete enough that an implementing agent can execute it without needing to make further architectural decisions.

## 4. Implementation

Now the plan is handed over. The code is written, strictly according to the specification. Deviation is not allowed without revisiting the design phase.

I do not like vast pull requests. Commit early and often. Small, reviewable increments keep the work manageable and the quality high.

If the plan proves incomplete or contradictory during implementation, the agent pauses and raises an issue. No pushing through ambiguity. The design is revisited, the plan is corrected, and implementation resumes.

## 5. Enablement and Hiring

This phase runs continuously, in parallel with everything else.

Agents should be treated as a team. They should be enabled, upskilled, and evolved. Their job is not static. They continuously scan their domain for new developments and compare what they find against the current project. If a skill becomes outdated, they update it. If a tool is missing, they write it. If a skill is no longer relevant, they deprecate it. They write logs about their skill usage and tool usage, and a trainer agent evaluates these logs to recommend improvements.

When the product requires expertise that the team does not have, a new expert is hired. A recruiter agent maintains continuous contact with the overall product manager to identify demand. The recruiter follows three steps: research the required capability, develop new skills or enhance existing ones, or create an entirely new persona.

The pipeline is never truly finished. It feeds back into itself. Better agents build better software. Better software demands better agents. The loop continues.