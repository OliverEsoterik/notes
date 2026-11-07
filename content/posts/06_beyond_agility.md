+++
author = "Oliver Bock"
title = "Beyond Agility"
date = "2026-11-07"
description = "Why agile adoption fails for operations teams"
+++

*Why agile adoption fails for operations teams, and how to automate your way out*

---

## The Setting

You cannot become agile by adopting a tool. You become scalable by measuring operational demand, and then automating it out of existence, one engineer-owned increment at a time.

Most organisations attempt to do the opposite: they introduce a delivery method, install the software that accompanies it, and expect the operational workload underneath to adopt. It does not. Operational demand arrives whether or not a sprint cadence exists to receive it, and the teams that absorb that demand are judged against a plan that cannot represent their actual work.

This is not a proposal to abolish ITIL, replacing a ticketing platform, or fund additional headcount. It's a proposal to look at the way operational demand enters the organisation and how to deal with it. ITIL's own single-point-of-contact principle supplies the discipline to do that, and DevOps supplies the automation loop that converts the resulting data into reduced demand. These two principles complement each other.

The organisation is already paying for its operational workload. It is simply not receiving an invoice for it.

According to Brown and Hellerstein (2005), the operations share of IT budgets is often 50–80%. A figure that has held steady for decades. This is not a temporary condition awaiting a fix. It is the steady state of an organisation that needs to operate what it builds.

This situation introduces a critical risk that threatens every single organization. When operational knowledge and permissions are concentrated rather than distributed, stability becomes fragile. Survival of entire platforms often hinges on a single point of failure: the few people who hold the access rights, understand the undocumented procedures, and remember how the system is actually run.

An organisation spending half its technology budget on operations, operating critical systems resting on single persons, is not experiencing a delivery problem. It is carrying an unhedged liability that appears in no risk register.

---

## Why the Method Was Never the Problem

ITIL did not fail. ITIL 4 adopted the terminology of competing frameworks. Its guiding principles "reflect the core guidance and objectives of multiple frameworks, including ITSM, Agile, Lean, and DevOps" (PeopleCert, 2025). But what actually fails is more specific: an operating model in which a method is adopted, but the handling of demand and the allocation of capacity remain untouched.

The pattern is visible in transformation data. Ninety-four per cent of companies have moved towards agile initiatives and two thirds claim success, yet "only about half of the companies that claim high agile maturity have actually achieved their transformation goals and can point to real business impact" (BCG, 2024). The failure is not in the framework. It is in what the transformation left unchanged.

What the transformation leaves unchanged is visible in the operating reality. Teams are carrying an operational load that leadership cannot address by hiring, and should not: operational work does not scale with people, and adding engineers to a demand stream that recurs at the same rate buys one increment of relief and then repeats the problem at a larger salary base. So the organisation reaches for the lever available to it. Agile working is introduced, and the introduction takes the form of a tool rollout. Work with Jira, work in sprints, and the problems will resolve.

For teams with little operational work, this is broadly true. For operations teams in IT, the same rollout produces confusion before it produces anything else. Questions arrive immediately, and they are not foolish at all:

> *Should we now transfer all our operational work into Jira? How can we plan operational tasks we do not have yet, because they occur unplanned? How can we plan the capacity of our team?*

The list goes on. And every operations leader has probably heard them. They are hard to answer within a framework that provoked them, because the framework assumes arriving work is plannable. But it is not.

The reconciliation is straightforward, and it shapes everything that follows. ITIL contributes the ingress discipline: a single point of contact through which demand is captured, classified and measured. DevOps contributes the loop that turns that measurement into automation and feedback. An organisation that runs the first without the second accumulates data it never uses and does not reduce the operational work. One that runs the second without the first automates a demand stream it cannot see.

### The Invisible Demand Problem

In a majority of organisations, the same pattern appears: engineers obtain access, rule changes and minor configuration adjustments by messaging a colleague. These are small things. They are also, in aggregate, the operational workload.

The concentration is the problem, not the informality. A small number of people hold the permissions, know the procedure, and are willing to help. They become the team's de facto service desk, working without a queue, a record, or a limit. Their capacity is consumed gradually, in increments too small to notice individually and too large to absorb collectively. When one of them leaves, the organisation does not measure a loss; it observes a delay, then a search, then someone else absorbing the same load under the same conditions.

There is direct measurement of this, and it comes from an organisation with unusually strong operational discipline. Google's reliability organisation reports that "SREs report that their top source of toil is interrupts (that is, non-urgent service-related messages and emails)" — ranked above on-call response and above releases (Beyer et al., 2016). The largest single component of operational waste, in one of the most automated environments in the industry, is exactly the informal request channel described above. This is not a symptom of immaturity. It is what an unchannelled demand stream does to any team.

### High Utilisation Is Not Efficiency

The truth that most leadership teams miss: at high utilisation, small reductions in capacity produce large increases in queue wait time. And this is the dominant force in team performance.

This demand is real, expensive, and invisible. It does not appear in the plan, so it cannot be resourced. It does not appear in a queue, so it cannot be prioritised. It does not appear in a report, so it cannot be defended. And because it is invisible, the organisation concludes the team has a performance problem rather than a demand problem.

---

## First Principles and the Alternative Model

An IT team will always carry operational accountability for the systems it owns. If something breaks, the team fixes it. That obligation does not vary with the delivery method in use. You build it, you run it.

Agile working will not resolve this, and the paradigm itself has to change. The change required is not in how the team works. It is in three things the team currently does not control: what enters its queue, whether that queue is measured, and whether any capacity exists to reduce the queue's future contents.

Operational demand in IT organisations compounds faster than headcount can follow. Escaping the trap does not require adopting a better methodology; it is about installing a strict ingress boundary that converts previously invisible demand into a measurable backlog, then converting the highest-frequency items in that backlog into engineer-owned automation and, and, where multiple demands share a pattern, introducing solutions that eliminates the recurring effort. Agility is applied to the work of building the automation, not to the work of absorbing the demand.

The reconciliation between ITIL and DevOps is the operating model that makes this work. The service desk practice produces the measurement; automation consumes it. But the model begins before either of those: it begins with channelling every request through a single ingress point. Not to gatekeep. To make the work visible. An organisation cannot resource what it cannot see, prioritise what it cannot queue, or defend what it cannot report. Visibility is the precondition for everything else.

Once the demand is visible, classified and measured, the organisation can identify what recurs, rank it by frequency and lifetime, and automate it in small, engineer-owned increments. The automation retires demand at its source, and the ticket that would have been raised never arrives.

1. **Ingress Boundary** — a single measurable entry point for operational demand.
2. **Demand Ledger** — volume, type, and effort by request class.
3. **Pattern Analysis** — frequency × expected lifetime × automation cost.
4. **Automation Pipeline** — one ticket per increment.
5. **Ownership and Capability** — engineer-owned assets the team can maintain.
6. **Self-Service Destination** — demand retired at source, so the ticket is never raised again.

The components are ordered by dependency. The ledger cannot classify what the boundary did not capture; pattern analysis cannot rank what the ledger did not classify; the pipeline cannot build what the analysis did not rank. Organisations that begin at component 4 automate their assumptions about their workload rather than the workload itself.

### The Ingress Discipline

Establishing a single measurable entry point closes the informal channels that bypass it. This is ITIL's single-point-of-contact principle applied.

Blocking channels is easily misinterpreted as a refusal to help, but that misconception destroys adoption before we even launch. Blocking protects the people currently absorbing unrecorded load, and it converts their invisible work into a record the organisation can act on. The work is not additional; the engineers would perform the work either way. What changes is that it is now recorded, in one place, and that the engineer is no longer interrupted by ongoing direct messages throughout the day.

The boundary must be cheaper to use than the alternative. Any formal path imposing more friction than the informal one will be ignored, and routing-around is a rational behaviour rather than resistance. A slow portal does not create compliance. It creates a shadow channel and a resentful team.

### Pattern Analysis and the Automation Pipeline

The purpose of establishing the ingress is not to process requests faster. It's purpose is to identify which requests should not arrive at all. And if it needs to be done twice, think about automating it.

This is where agility applies. The pipeline takes the top of the ranked list and builds it. One increment. One sprint. One ticket. At the end, the asset is measured, then either promoted, retired, or carried into another increment. The loop repeats. Nothing about this requires a large programme office, a transformation budget, or any framework purchase.

The team is not being asked to run sprints on its ticket volume. It is being asked to run short increments on the work of reducing that operational volume, which is plannable, measurable, and completable.

---

## How to run in Practice

An understaffed team is the normal case, and it is worse than it sounds: even a team whose staffing is balanced would probably consume its entire capacity on daily operational work, leaving nothing for anything else. There is no version of this model that begins with available capacity, and any proposal that assumes it, is not credible.

Take development work as a small percentage of the operations time. Start small, and scale from there. The team will not notice a single hour here or there; it will notice what happens when the first automation it owns retires a request entirely. Google's reliability organisation targets keeping toil below 50% of engineering time. It's not the starting point, but the destination. Slowly get there by working on it step-by-step. One protected increment at a time, grown from proven returns rather than granted in advance.

### One Session, One List

Start with a working session with the team. Not a workshop series, not some facilitated offsite. One session, one list. Simple as that.

The list is produced by the team, ranked by what bothers them most: the work that is time-consuming and repeating. The first increment's purpose is to establish that the loop works and that engineers are willing to use it, and that purpose is better served by a task the team resents than by a task with a marginally better economic case. Candidates are then filtered by criteria like frequency, expected lifetime and automation cost. Make up a limit to keep the first cycle short enough to complete inside the operational load that actually exists.

The goal should be simplicity, and it should be stated explicitly to the team because it may contradict their professional instincts. A simple script that duplicates an existing manual step is an acceptable first increment. It is not best practice, and it is not the destination. But it is a stage on the way. Do not let the team begin with the most complex candidate — the candidate requiring several dependencies, or an unfamiliar framework the engineers do not yet use fluently. That sequence produces an abandoned project and a team that concludes automation is not for them.

### The Engineers Own What They Build

Automation built centrally and delivered to an operations team will probably fail. A team will feel no ownership over a solution it did not design, does not understand, and cannot maintain. The solution becomes a new source of operational work rather than a reduction. An automated workflow that nobody on the team can modify will be bypassed the first time it meets an exception, because bypassing it is faster than learning it.

This applies to solutions, not to platform capabilities. Self-service APIs, and automation building blocks that multiple teams can adopt and extend on their own terms follow a different logic. A platform team that builds these well is not delivering finished automation to a consumer team. So these two patterns are not opposites. They are sequential. The platform returns capabilities that make the next team-owned resolution even faster.

Engineers want workflows they own. A solution chosen by the people who perform the work is maintained by them; a solution imposed on them is maintained by whoever imposed it. Engineers do not want an external team to throw a solution over the fence and create more operational hurdles for them than before. They want to provide the solution, they want to solve the problems, and they want to own the workflows they use every day. Ownership is the mechanism by which automation quality is maintained without a central bottleneck — the team that owns the asset can fix it, extend it, and retire it.

Engineers should choose the solution. They do not choose the problem, and they cannot force skills they do not have. Cognitive load is a real limit, and expecting a team to adopt an unfamiliar framework on top of a full operational load produces abandonment rather than capability. Capability is built where people already are, in the tools they already use, and it grows as their confidence does.

### Every Asset Gets a Lifecycle

Every automation asset needs a review trigger.

This is what distinguishes a bootstrapping strategy from script sprawl. Starting with a simple script is correct when a team has no capacity and no platform, because the alternative is starting with nothing. A first script is a standard for the present, and the review trigger is what stops it becoming the standard forever. Without that mechanism, the organisation accumulates automation debt: assets built in isolation, optimised for one domain or objective, without enough consideration for how they will interact with other automated processes later.

### What to Build, How to Build It

The governance model has one distinguishing feature: it separates the decision about worth from the decision about method. The team decides whether an initiative is worth doing now — based on the economic case, timing, and alignment with service commitments. The engineer who will build it decides how it is solved — based on technical judgement, existing skill, and maintainability. The person who prioritises does not select the tool or the approach, and the person who builds it does not unilaterally commit team capacity.

This separation is what allows an operations team to run an improvement programme under load without either stalling on consensus or accumulating unmaintainable assets. The 2021 equivalent of this model would have been a change board deciding both, which is precisely why that governance layer became a bottleneck.

### Two Boards, Two Purposes

Operational work and improvement work are different in kind, and they belong in different places. Operational work is time-critical and urgent; it is resolved as it arrives. Improvement work needs time and proper planning. I track both, but deliberately: one board is where the operational tickets are resolved, the other board is where the work of retiring the first board happens. Keeping them separate preserves both. A product-development task that shares a queue with an incident will always lose — not because it is less important, but because urgency always wins over importance in a shared queue.

---

## What the Model Returns

Three things to start with: a single ingress point for demand, a way to measure it, and a protected slice of engineering time. One sprint, one ticket per increment. You grow from there.

The first quarter will tell you more about your own operational reality than any benchmark would do. You will know your top request types by volume and effort and probably have retired at least one of them, or at least reduced operational time. The person who used to be the only one who could handle that request will no longer be the bottleneck.

Your team will spend less time on work that repeats and more time on work that matters.

### The Platform Horizon

Everything mentioned above starts at the team level. Make demand visible, pattern-match across it, automate the repeats. But the same logic scales upward. When multiple teams run this loop, the analysis might reveal demand that recurs across teams — the same request types appearing in multiple ledgers. Those cross-team patterns are the platform backlog.

A platform organisation builds shared primitives for those patterns. A self-service to request permissions, an automated environment provisioning flow, a shared solution to reduce time spend on investigations. It retires demand at a higher order. Every team that adopts these platform capabilities never raises that ticket again. The team-owned automation loop and the platform strategy are not alternatives. The loop generates the data that drives the platform backlog, and the platform returns capabilities that make the next loop faster.

The sequence matters. Teams should not wait for a platform before starting their own automation loop, because without this we cannot produce the pattern data the platform needs. The platform emerges from the patterns, not the other way around.

### A Final Word

Operational demand in IT organisations does not disappear because a delivery method changes. It disappears because someone measures it, ranks it, and automation retires it at the source. There is no scenario in which adding more people, more tooling, or more process does what that loop does — because none of them touch the demand itself.

This is the model that holds ITIL and DevOps together rather than letting them compete. It treats operational demand as a measurable input rather than an unexamined condition, and it gives the engineers who absorb that demand the mechanism, the ownership, and the protected time to reduce it.

Automate your way out of operations. It is tough. But it is worth it.