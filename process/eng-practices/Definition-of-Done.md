---
tags: [ needs/review ]
---

# Definition of "Done"

Use these checklists to determine whether the task/user story which you are
reviewing is fully complete. Fully complete means releasable, and no further
work required.

We might consider things "done" at different levels because features are
composed from many sub-units, such as _Task_ issues and PRs.

## GitHub Pull Request

A single PR often won't complete an entire feature. There may be multiple
smaller PRs necessary. We consider a PR done if the `master` branch would remain
"releaseable" after merging this PR.

### Ready for review

- Fields filled out correctly according to Pull Request template.
- PR is not in "draft" state.
- See also [[Code-Review-Guidelines]].

### Can be merged into `master`

- Reviewed by someone other than the author.
- Addresses the referenced task ticket in some way.
- Automated CI passing.
- Meets [[Coding-Standards]].
- All review comments are addressed.

Sometimes it may be expedient to merge a PR without all review comments and/or
coding standards being addressed. This should only be done if the PR author
undertakes to immediately begin correcting those issues in their next PR.

## Jira _Task_ issue (Technical task)

The implementation of a _User Story_ issue is divided into one or more _Task_
issues. The technical task issues will address a smaller part of the feature.

Once a technical task is done, the assignee checks that it meets the necessary
criteria and moves it into the "QA" column of the sprint board.

### Ready for moving to QA state

- Acceptance Criteria have been fulfilled.
- Has adequate test coverage at the appropriate level(s).
- Has documentation
  - User Manual updated (if applicable)
  - Design documentation added/updated (if applicable)
- _Task_ as a whole meets [[Coding-Standards]].

### Done

- Ticket has been checked by our [[QA-Approach|QA engineer]] for adherence to
  standards and definitions of done.


## _User Story_ issues

See [[project-mgmt]] for an example feature description.

- There are automated functional test cases covering the A/C of the _User Story_.
- The U/S works coherently as a whole in the application.
- Non-functional requirements have also been addressed, such as:
  - Performance
  - Logging
  - Other operational concerns

## TODO

- [ ] Definition of "Ready"
