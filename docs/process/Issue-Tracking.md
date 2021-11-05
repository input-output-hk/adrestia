---
tags: [quality, process]
---

# Issue Tracking

We primarily use [[Jira]] for issue tracking.

:::{.highlight-block .max-w-xs}
**Sorry!** 😺
:::

This is so that:

- We can link our tickets with tickets in other projects.
- Project managers are more easily able to understand project status by looking at Jira.
- We can link our development task tickets with user story tickets.

## Bug tracking

- When a potential bug is found, a jira ticket with type "Bug" is created.
- The bug is assigned a _Severity / Probability Score_ by the creator according to [[Bug-Classification]]
- Bug is assigned _Priority_ by Team Lead or Product Manager according to [[Bug-Classification]].
- In case of uncertainty, the ticket is discussed with the team to confirm that it is indeed a bug, and how severe it is.
- Corresponding sections of the ticket are filled in (context, reproduction path, expected behavior...)
- If the bug turns out to be invalid, the ticket is closed with a note giving the reason.
- When resolved, the bug is moved to the "QA" column of the sprint board.

## Bug reports from non-IOHK GitHub users

If the bug report is valid, create a corresponding Jira ticket and
link it on the GitHub issue description, so that it can be planned for
a development sprint.

In the [cardano-wallet](https://github.com/input-output-hk/cardano-wallet/issues/new/choose) repo, there is a special GitHub template for [bug reports](https://github.com/input-output-hk/cardano-wallet/blob/master/.github/ISSUE_TEMPLATE/bug_report.yml).

## CI Failures

As a special exception, [CI failures](https://github.com/input-output-hk/cardano-wallet/blob/master/.github/ISSUE_TEMPLATE/failing_test.yml) **are** always tracked in GitHub,
because it is easier to link them from GitHub PR comments.

## TODO

- [ ] Finalise and paste in new [[Urgent-Issue-Handling]] document.
