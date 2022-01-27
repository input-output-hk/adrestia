---
order: -8
---

# Process

How do we arrive at our code?

The team's process is derived from [extreme programming][xp] and [scrum][scrum], adapted for use by a distributed teams. It can be summarized as follows:

## Feature Roadmap

- Our feature roadmap is a product backlog, owned by a _Product Owner_.
- Each item is described in terms of:
    - A user story (U/S) following the Role-Feature-Reason template.
    - Acceptance Criteria (A/C). Use specific language in the style of 
      - [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119.html) "MAY/SHOULD/MUST", or
      - [Gherkin Syntax](https://docs.behat.org/en/v2.5/guides/1.gherkin.html).
    - Possible extra information or documents.
- Items in the backlog are sorted by priority.
- U/S are [[Estimation-Process|estimated]] by the team, before the development proceeds.


:::{.highlight-block}

### Example Feature Description

#### U/S

**As** a stake pool operator  
**I want** the pool ordering to be fair and not favor any particular pools especially during the bootstrapping era  
**So that** every pool has the same chance to be selected by users in the early stages.

### A/C

**Given** that stake pools can be listed via https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/listStakePools  
**And** they are ordered by "apparent performance"  
**When** I query stake pools during the first epoch (when little information about them is available)  
**Then** pools are ordered arbitrarily  
**And** the order is not necessarily the same between different wallets  
**And** the order is consistent between successive calls within the same wallet.

:::

## Iterations

- The project runs in fortnightly "sprint" iterations.

- One release per sprint would be ideal.

- User stories are assigned to and owned by a single member of the team (a.k.a the Pilot).
  Pilots are seconded by a [[Co-Pilot]].

- Tasks and Pull Requests have a dedicated GitHub template:
    - [Issue Templates](https://github.com/input-output-hk/cardano-wallet/blob/master/.github/ISSUE_TEMPLATE/)
    - [PR Template](https://github.com/input-output-hk/cardano-wallet/blob/master/.github/PULL_REQUEST_TEMPLATE.md)

- Tasks move across the [following board](https://input-output.atlassian.net/jira/software/c/projects/ADP/boards/231).

```
|*************|  |*************|  |*************|  |*************|
|    To Do    |  | In Progress |  |      QA     |  |    Done     |
|-------------|  |-------------|  |-------------|  |-------------|
|             |  |             |  |             |  |             |
|     ...    ----->    ...    ----->    ...    ----->     ...    |
|_____________|  |_____________|  |_____________|  |_____________|
```


## Technical Debt

- During sprint weeks, we often accumulate technical debts (e.g. `TODO` or `FIXME`). Example of tasks falling under the "technical debt" umbrella:
    - Reviewing and extending code documentation
    - Refactoring some potentially entangled parts of the code
    - Re-organizing modules and folder achitecture
    - Fix small `TODOs` or `FIXMEs`, or, turn them into U/S
    - Identify areas of the source code which needs improvement

- To be tackled efficiently, technical debts need to be mentioned and documented in ticket, so that it can be estimated, scoped, discussed and prioritized.
- During the iteration planning meeting happening every week, the team will select the equivalent of 1-day work of technical debt to be tackled.


## Communication

See:
  - [[Communication-Conventions]]
  - [[Meetings]]
  - [[Documentation]]

[xp]: http://www.extremeprogramming.org
[scrum]: https://scrumguides.org/scrum-guide.html#scrum-definition
