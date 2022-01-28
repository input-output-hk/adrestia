# Scrum Info

Your reference: [The 2020 Scrum Guide](https://scrumguides.org/scrum-guide.html).

 * [[Definition-of-Done|Our Current Definitions of Done]]
 * [[Definition-of-Ready|Our Current Definitions of Ready]]
 * [[Meetings|Sprint Ceremonies]]
 * [[Jira]] is the tool we use for the sprint board and backlog.

## Definition of "Done"

Scrum lists three artefacts to help manage work. These artefacts are:

 * The Product Backlog

 * The Sprint Backlog

 * Increment

Each of these artefacts has a commitment to ensure transparency and focus against which progress is measured:

 * For the Product Backlog, it is the Product Goal

 * For the Sprint Backlog, it is the Sprint Goal

 * For the Increment, It is the Definition of Done

According to the Scrum Guide, The Definition of Done _"for an increment is part of the standards of the organization, all Scrum Teams must follow as a minimum. If it is not an organizational standard, the Scrum Team must create a Definition of Done appropriate for the product."_

### Examples

Some example DOD are:

#### Condition: _Environments are prepared for release_

First check that no unintegrated work in progress has been left in any development or staging environment. Next, check that the continuous integration framework is verified and working, including regression tests and automated code reviews. The build engine ought to be configured to schedule a build on check-in. It may also trigger hourly or nightly builds. Also, check that all of the test data used to validate the features in the release has itself been validated.

#### Condition: _Code Complete_

Any and all “To Do” annotations must have been resolved, and the source code has been commented to the satisfaction of the Development Team.

Unit test cases must have been designed for all of the features in development, and allow requirements to be traced to the code implementation.  The unit test cases should have been executed and the increment proven to work as expected.

Peer reviews ought to be done.


## Definition of Ready

A Definition of Ready is becoming a common practice to help teams to determine
whether work is ready to be started in the first place. It helps teams think
further into if this task or user story is ready to be accepted into a sprint.

Definition of Ready mostly takes the form of a checklist of criteria to help
facilitate a team's decision.

### Examples

| **CRITERIA** | **DESCRIPTION** |
| --- | --- |
| Acceptance Criteria | Has the item got clearly defined acceptance criteria? |
| Estimated | Has the item been estimated by the team?<p> Are they all in agreement of the estimate?<p>Items can not be estimated by anyone that is not actively part of the development team. |
| Actionable | Is the item immediately actionable by the team?<p> Do the team know what they need to do, and can they do it now?<p>Is the item free from external dependencies? |
| Refined | Has the item been refined prior to sprint planning?<p> If not, then is there a common understanding of what the item is and how it will be done? |
| Value | What is the business value of this item?<p> Is this value clear to all members of the team? |
