---
order: 1
---

# Development Process

The team's process is derived from [extreme programming][xp] and adapted for remote, distributed teams. It can be summarized as follows:

## Roadmap

- Our roadmap is a product backlog, owned by a _Product Owner_.
- Each item is described in terms of:
    - A user story (U/S) following a Role-Feature-Reason template
    - Acceptance Criteria (A/C) written in [Gherkin](http://docs.behat.org/en/v2.5/guides/1.gherkin.html)
    - Possible extra information or documents
- Items in the backlog are sorted by priority.
- U/S are estimated upfront, by the team via blind-voting and using a 4-value scale: small, medium, large or uncertain.

<details>
    <summary>example</summary>

> ### User Story
>
> **As** a stake pool operator
> **I want** the pool ordering to be fair and not favor any particular pools especially during the bootstrapping era
> **So that** every pool has the same chance to be selected by users in the early stages.
>
> ### Acceptance Criteria
>
> **Given** that stake pools can be listed via https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/listStakePools
> **And** they are ordered by "apparent performance"
> **When** I query stake pools during the first epoch (when little information about them is available)
> **Then** pools are ordered arbitrarily
> **And** the order is not necessarily the same between different wallets
> **And** the order is consistent between successive calls within the same wallet.
</details>


## Iterations

- The project is divided into weekly iterations.
- Releases happen at the beginning of every week, Monday or Tuesday.
- User stories are assigned to and owned by a single member of the team (a.k.a the pilot). Pilots are seconded by a Co-pilot as follows:

    | Mission | Role |
    | --- | --- |
    | Clarify product requirements as needed with the product owner(s) | Pilot |
    | Break U/S into tasks (small, sizeable, chunks of work) | Pilot |
    | Estimate U/S in terms of # of weeks | Pilot |
    | Implement each task of a U/S | Pilot |
    | Challenge the task division and review it | Co-Pilot |
    | Primary reviewer of the development tasks | Co-Pilot |
    | Call for assistance from peers when needed | Co-Pilot |
    | Challenge implementation decisions and technical choices | Co-Pilot |


- Tasks and Pull Requests have a dedicated GitHub template:
    - [Task Template](https://github.com/input-output-hk/adrestia/blob/master/.github/ISSUE_TEMPLATE/task.md)
    - [PR Template](https://github.com/input-output-hk/adrestia/blob/master/.github/PULL_REQUEST_TEMPLATE.md)

- Tasks move across the [following board](https://github.com/orgs/input-output-hk/projects/13) (see Task template for transitions)

```
|*************|  |*************|  |*************|  |*************|
|   Backlog   |  | In Progress |  |      QA     |  |    Closed   |
|-------------|  |-------------|  |-------------|  |-------------|
|             |  |             |  |             |  |             |
|     ...    ----->    ...    ----->    ...    ----->     ...    |
|_____________|  |_____________|  |_____________|  |_____________|
```

- Pull requests are labelled with one of the following labels:
    - `RESOLVING_ISSUE`: when changes are tackling a known issue.
    - `IMPROVING_CODE`: when changes are improving an existing functionality or, the source code itself.
    - `ADDING_FEATURES`: when changes are implementing a new feature.

  This helps generating an automated changelog for each release.


## Technical Debt

- During sprint weeks, we often accumulate technical debts (e.g. `TODO` or `FIXME`). Example of tasks falling under the "technical debt" umbrella:
    - Reviewing and extending code documentation
    - Refactoring some potentially entangled parts of the code
    - Re-organizing modules and folder achitecture
    - Fix small `TODOs` or `FIXMEs`, or, turn them into U/S
    - Identify areas of the source code which needs improvement

- To be tackled efficiently, technical debts need to be mentioned and documented in ticket, so that it can be estimated, scoped, discussed and prioritized.
- During the iteration planning meeting happening every week, the team will select the equivalent of 1-day work of technical debt to be tackled.

## Coding

- The code is collectively owned, everyone is knowledgeable about every part of the code
- The code is peer-reviewed
- Code is following an agreed [standard and style][styleguide]
- Code is integrated and tested daily to the main branch (`master`) through PR
- The main branch should be _releasable_ at any time and not contain broken features
- No unplanned optimizations, features or unneeded abstractions are implemented
- We favor simple unbloated code and use refactoring techniques to add features
- We test chunks of codes as we submit and integrate them, maintaining a high code coverage at all time


## QA

- All code should be covered by tests (either unit, integration or manual).
- We favor automated tests over manual testing.
- Issues are closed by QA, once convinced by developers that the added code works and is covered
    - Developers are expected to point relevant automated or manual test procedures to QA
    - Developers may also point to documentation or, code details that ensure reliability of the code
- When a bug is found, regression tests are created to illustrate the failure, prior to fixing it
- Tests are ran daily in a integration environment.
- Critical parts of the code have benchmarks to identify potential bottlenecks.
- Code and more importantly public interfaces are well-documented and digestible.

## Bugs

- When a potential bug is found, a [Bug ticket](https://github.com/input-output-hk/adrestia/blob/master/.github/ISSUE_TEMPLATE/bug.md) is created with a label `BUG`
- Bug is assigned `severity` by the creator according to [classification guide](https://github.com/input-output-hk/adrestia/wiki/Bug-Classification)
- In case of uncertainty the ticket is discussed on Slack with the team to confirm that it's indeed a bug.
- Bug is assigned `priority` by Team Lead or Product Manager according to [classification guide](https://github.com/input-output-hk/adrestia/wiki/Bug-Classification)
- Corresponding sections of the ticket are filled-in (context, reproduction path, expected behavior...)
- If dispelled, the bug ticket is closed without further ado.
- When resolved, the bugs moved to the "QA" section of the standard board.

## Communication

- We have daily written, asynchronous, stand-up on Slack on a separate channel
- Each Wednesday, an iteration meeting is done:
    - 1h max
    - To do a retrospective on past U/S and estimations.
    - To assign new U/S to team members
    - To discuss important matters or change in the process
- Every 3 weeks, the Wednesday meeting becomes a monthly retrospective where the team can discuss what went well, what didn't and take actions to improve things (see also https://www.retrospected.com/)
- Discussions happen on Slack in clear threads, decisions are documented on GitHub as comments on issues
- Our GitHub wiki can be extended at any time with insights and details about the software
- Reports and metrics about the project are available to anyone
- Every week, we produce a technical & non-technical report (see [weekly-reports](https://github.com/input-output-hk/adrestia/tree/weekly-reports)) containing:
    - A brief non-technical summary of the week overview
    - A list of the completed user stories and their business value
    - A list of known issues or debt accumulated during the iteration

## Resources

#### Books

- [The Pragmatic Programmer](https://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/)
- [Refactoring: Improving the Design of Existing Code](https://www.amazon.com/Refactoring-Improving-Existing-Addison-Wesley-Signature/dp/0134757599/)
- [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/)
- [Release It!](https://www.amazon.com/Release-Design-Deploy-Production-Ready-Software/dp/1680502395/)
- [Thinking With Types](https://leanpub.com/thinking-with-types/)
- [Git](https://www.amazon.com/Version-Control-Git-collaborative-development/dp/1449316387/)
- [Algebra-Driven Design](https://leanpub.com/algebra-driven-design): _A how-to field guide on building leak-free abstractions and algebraically designing real-world applications._

#### Guides

- http://www.extremeprogramming.org
- https://try.github.io/
- https://12factor.net/
- https://documentation.divio.com/

[styleguide]: https://github.com/input-output-hk/adrestia/wiki/Coding-Standards
[xp]: http://www.extremeprogramming.org
