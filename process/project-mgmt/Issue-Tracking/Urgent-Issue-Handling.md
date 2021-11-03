---
tags: [process]
---

# Urgent issue handling process

We are now more tightly project managing our work load, but still need
to maintain responsiveness to unplanned issues as they arise.

The goal of this document is to define a simple process specific to
our team and projects, where important new issues are identified
quickly, and can have time allocated to them without delay.

By documenting this process in a short doc, we can ensure that no team
member will be uncertain about what to do when a new issue arrives,
and who is responsible.

We want to avoid:
1. Urgent issues sitting unattended without anyone working on them.
2. Developers getting bothered by non-sprint work.
3. Multiple team members "piling on" to the same issue, when one or
   two would be enough.
4. Unnecessary expansion of sprint scope.
5. Unnecessary overtime work.
6. The tech lead being a bottleneck and a single point of failure in
   the process.
7. Developers assigned to an urgent issue but blocked.
8. Stakeholders not knowing what's going on.
9. Unreasonable expectations from stakeholders
10. Failing to use multiple time zones to our advantage.

### Types of new work

- Bug reports (of varying severity and impact)
- Support requests
- Feature requests
- Collaboration opportunities

### Sources of new work

- Product Team (BA)
- Internal testing by developers and QA
- Daedalus team
- Technical Services Desk (IOHK support for end-users)
  - TSD field many support requests and provide workarounds for bugs.
  - Most often, support tickets come from Daedalus users.
- Exchanges
- Stake pool operators
- Application developers
- Company executives
- GitHub Issues

### How do I recognise an urgent issue?

Examples of urgent issues. These type of things are the subject of this document.

- Any problems reported by exchanges that could result in disabling Ada withdrawals, or delisting of Ada (e.g. severe performance degradation).
- Key functions of the wallet don't work for a significant number of users (e.g. can't make a payment).
- Key functions of the wallet produce an incorrect result (e.g. incorrect balance).
- Issues identified as important by company executives
- An issue which genuinely prevents other development teams who use our software from completing their work.


### How do I recognise a non-urgent issue

Examples of things which aren't urgent, and for which the normal process applies for including them in a sprint.

- There is a useable workaround for the affected user(s).
- It's about something we never intend to support.
- It's a normal feature request.

### Resolution process

1. Triage
   1. Identify the problem that the user is having.
   2. Look for indications that this is an urgent issue.
   3. If definitely urgent, commence Work. If unsure, escalate to slack channel.
2. Work
   1. Ensure that there is an ADP jira ticket, in the current sprint, and it's assigned. Notify the PM.
   2. Identify the steps required to reproduce the issue, blah, blah, the normal thing.
   3. When solving an urgent issue, the goal is not necessarily to make a perfect solution, or even to make any code fix at all. The goal is to make the user happy enough that the issue is no longer urgent.
   4. Don't get stuck.
   5. Be very cautious when requesting or handling commercially sensitive information.
   6. Update your tickets more often than you would normally.
3. Resolution
   - If there is a useable workaround, the issue becomes non-urgent and can be handled as normal.
   - If there is a bug fix, make a new release when possible.
   - A development build could be provided to affected users, but this
     is a bad habit to get into.

### Who is responsible

1. Triage phase - Probably a "bug sherrif" rotation system as used by
   Daedalus team would be suitable for us.
2. Work - The important thing is that urgent issues are assigned to
   someone not no-one. The PM or tech lead can assign the work. If
   nobody steps up, then the bug sherrif will need to assign
   themselves.
3. Resolution - tech lead.
