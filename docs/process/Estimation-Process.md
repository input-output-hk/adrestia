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

## Capturing uncertainty in our estimates

One common way to express an estimate for a given task is to give a single
number: the number of remaining days of effort the task owner believes that he
or she will require to finish that task.

However, a single number alone is unable to capture the degree of confidence or
uncertainty the author of an estimate has. To allow estimate authors to record
their confidence or uncertainty, we need a bit more information.

Therefore, we attach to each task a **pair** of estimates:

- **Most-probable estimate (days)**: the number of remaining days of effort the
  task owner believes he or she will most likely need to finish that task.

- **Most-pessimistic estimate (days)**: the number of remaining days of effort
  the task owner believes he or she will need to be 90% of confident of
  finishing that task, given a pessimistic appraisal of the situation, and
  taking into account all of the potential things that could go wrong.

Note that it's impossible (in general) to predict all the things that could go
wrong with a task. This is why estimates are estimates, and not commitments.
Pilots and co-pilots should feel free to give estimates based on their personal
experience. They may use their accumulated knowledge of how long similar tasks
have taken in the past to develop new estimates.

The **deviation** between the most-probable estimate and most-pessimistic
estimate allows the authors of each estimate to express their degree of
uncertainty in the estimate, and it allows people viewing the estimates to gain
insight into that uncertainty.

A very large deviation between the most-probable and most-pessimistic estimate
tells us that the author is very uncertain in their estimate. We might use
this information to take action, for example, by breaking up a task into
smaller, more well-defined pieces.

It's important to realize that:

- These estimates pertain to the number of days of remaining effort required to
  perform that task **in isolation**. If two or more tasks are performed in
  parallel, with context switching, then we need to keep the additional cost of
  that context switching in mind.

- These estimates refer to a number of days **remaining**, and as such they
  should be regularly updated as circumstances change, rather that set in stone
  and left unchanged.

## Guidelines for creating estimates

- Estimates should only be created and updated by the pilot and co-pilot
  responsible for a given task.

- Estimates should be created only after a _Task_ ticket has entered the
  "READY" state. This means that a task should not be estimated if either the
  pilot or the co-pilot are unclear on what must be done.

This implies that:

- The _Task_ ticket should have a complete set of acceptance criteria.

- The _Task_ ticket should have a clear design that the pilot and co-pilot are
  capable of estimating. Justification: there are many possible designs for a
  given set of acceptance criteria. The time to deliver a task will depend very
  strongly on the design that is chosen.

- The _Task_ ticket should be linked to a _User Story_ ticket, **if** it
  pertains to a user story. (It's important to note that not all tasks must
  have a corresponding user story. In the case of technical debt tasks or pure
  refactoring tasks, it might not be practical to even identify a user story.)

- The _Task_ ticket is sufficiently small to estimate.

- Task dependencies are defined with Jira issue links.

## Process for updating estimates

One of the main benefits of estimation is that both project management and other
team members can gain visibility on how much time might be required to bring
certain tasks to completion.

Since we have one project planning meeting per week, it makes sense to update
our estimates at around the same frequency.

Before each project planning meeting (currently on Wednesday), each team member
should:

- Identify the tasks he or she is currently working on, in JIRA.

- Make sure that each task has an updated pair of estimates that best reflect
  their current understanding of how much remaining time would be required to
  bring these tasks to completion.

## Interpreting estimates

Estimates do not represent commitments on behalf of those who create them.

The actual time required to finish tasks, when compared to initial estimates,
can vary wildly, with some tasks taking many times longer than initially
predicted.

This factor: the actual time divided by the estimated time, is often known as
the "blowup factor".

There is some research to indicate that the "blowup factor" (actual time
divided by estimated time) can be reasonably modelled using a log-normal
distribution. See https://erikbern.com/2019/04/15/why-software-projects-take-longer-than-you-think-a-statistical-model.html

TODO:

- [ ] When we have a task with a chain of dependent tasks, devise an automated
  method of calculating a most-probable estimate and a most-pessimistic
  estimate for the entire chain of tasks. This method might use the log-normal
  distribution model suggested above in order to capture the possible blowup
  factor for the entire chain.

- [ ] When we have a release that contains large numbers of tasks with
  dependencies between them, devise an automated method of determining the most
  likely critical paths required to deliver the release, and a method of
  calculating a most-probable estimate and a most-pessimistic estimate for
  delivering the entire release.

In some situations, there will be one obvious critical path, but in more
complex situations, there may be multiple contenders for the critical path, and
the critical path may change as we make progress through a release.

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

# Other methods of estimation

## Story points estimates

This method uses unitless "story points" for estimation of each
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

## Team Estimation

Story point estimations are done by the development team together in
the [[Meetings|sprint planning meeting]].

This method can use the [Pointing Poker](https://www.pointingpoker.com/) tool
to facilitate estimation sessions.

The team should agree on a single number. If they don't then someone
is missing some information about the task.

This practice lets us share knowledge about tasks.

## Updating estimations

By rights, the estimation of a ticket should not change once the
sprint has started.

If the ticket actually took twice as long as the points estimate
suggested, then the team velocity will decrease. The idea is that in
theory the velocity figure records under-estimation tendencies of the
team, so that future sprints may be better planned.

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


## TODO: Put remaining time on ticket

- [ ] Write process for updating tickets with "remaining time" value.
