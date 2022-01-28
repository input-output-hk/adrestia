---
tags:
  - needs/review
  - needs/expansion
---

# Estimation Process

Software estimates are used to inform project management and product
decisions so that business targets can be met.

Based on estimates, we decide which features to implement and how, and
the assignment of tasks to sprints.

## Estimates come with assumptions and uncertainty

Estimates are inaccurate by definition.

Estimates get more accurate as more information about the project
becomes known. For example, an estimation at the initial concept stage
will be less accurate than an estimation after all requirements are
known, which will be less accurate than an estimation after design is
complete, etc.

To clarify this inaccuracy, we can list the assumptions of an estimate
below the estimate. These assumptions translate to risks - because if
they turn out to be incorrect, then they will add more time to the
task.

It's also possible to provide confidence intervals around an
estimation to quantify the uncertainty. For example, a development
task could be estimated to take 30 hours expected, +20 hours worst
case, -5 hours best case. However even then, how often do we expect
that actual time will come in longer than "worst case?"

## Story points estimates

We accept that accurate estimation is hard, for multiple reasons, so
instead adopt the "just in time" planning technique from XP.

This uses unitless "story points" for estimation of each
ticket. Possible story point values are on the Fibonacci sequence:
1, 2, 3, 5, 8, 13.

The idea is that these point values represent task size in an abstract
way. An estimate in time for a task can be calculated from the
estimate in story points divided by the project velocity, adjusted
according to staff availability, other factors, etc.

The decision on whether a task is included in the next sprint is
based on its points estimate and the project velocity.

This approach is clearly a **gross simplification of reality**, and so
we need to be very careful not to produce garbage estimates.

### Points

| Points | Size                                            |
| -----: | ----------------------------------------------- |
|      1 |                                                 |
|      2 |                                                 |
|      3 |                                                 |
|      5 |                                                 |
|      8 |                                                 |
|     13 |                                                 |
|   > 13 | This ticket needs to be split up further.       |

### Each _Task_ ticket has an estimate

We assign an estimation to every single task ticket. If there's no
estimate, then it can't be added to the sprint.

### Ticket must be ready to estimate before estimation

If there is not enough information about a task ticket, then the
estimation will be rubbish. So before estimation starts we need:

1. The _Task_ ticket is linked to a _User Story_ ticket.
2. The ticket description contains adequate information about what is
   expected to be done.
3. The ticket includes acceptance criteria.
4. The ticket is sufficiently small to estimate.
5. Task dependencies are defined with jira issue links.

## Team Estimation

Story point estimations are done by the development team together in
the [[Meetings|sprint planning meeting]].

We use the [Pointing Poker](https://www.pointingpoker.com/) tool to
facilitate estimation sessions.

The team should agree on a single number. If they don't then someone
is missing some information about the task.

This practice lets us share knowledge about tasks.

## Implicit acceptance criteria

Every development task is subject to the [[Definition-of-Done]].

So development tasks such as testing, documentation, review, etc, must
be included as part of the estimate.

These tasks are implied, and needn't be listed under the A/C of every
single task ticket. However, if for example testing alone is going to
be a large amount of work, then that task can be split out from the
main task and linked.

## Task dependencies recorded with issue links

| Link type  | Meaning of A _links_ B                                 |
| :--------: | ------------------------------------------------------ |
| blocks     | Issue A must be done issue B can start.                |
| requires   | Issue B must be done before issue A can be done.       |
| implements | Task A implements User Story B.                        |
| duplicates | Issue A is the same as issue B, and should be closed.  |

### Non-essential informational relations

| Link type  | Meaning of A _links_ B                                 |
| :--------: | ------------------------------------------------------ |
| relates to | A non-specific linking of issues.                      |
| causes     | Implementation of task A resulted in Bug B.            |
| mitigates  | Implementation of task A will reduce effects of Bug B. |

### Subtask relations

We have found that Jira _subtasks_ aren't especially useful. They just
make things confusing, so avoid using them.

## Updating estimations

By rights, the estimation of a ticket should not change once the
sprint has started.

If the ticket actually took twice as long as the points estimate
suggested, then the team velocity will decrease. The idea is that in
theory the velocity figure records under-estimation tendencies of the
team, so that future sprints may be better planned.

## TODO: Put remaining time on ticket

- [ ] Write process for updating tickets with "remaining time" value.
