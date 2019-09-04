# Wallet Backend Retrospective

<p align="right">2019/09/04</p>


## What Went Well?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+4         | 0            | We have held a retro meeting. :tada:
+3         | 0            | Task breakdown and estimation seems easier to do.
+3         | 0            | The team kinda worked "autonomously" without lead for 2 weeks.
+3         | 0            | More discussion happening on the `-adr` repository, with proper time to think about design prior to start coding.
+2         | 0            | Better awareness and co-ordination of people working together on the same PR
+1         | 0            | Random AD U/S split up well and completed successfully. Although finishing the last tasks took a while.

- One person should break a U/S into tasks, then tasks are reviewed in iteration meetings (or before on GH) and estimated by the team.
- U/S should be assigned prior to the iteration planning meeting so that the owner have time to break it down to tasks and others have time to review it.
- Stories weren't not equal in scope (ideally, stories should be no longer than 2 weeks, i.e. fit in a sprint).
- Product requirements weren't detailed enough, in particular in terms of acceptance criteria.
- How do we keep track of small issues that don't really fit the definition of an "ADR" ?


## What could be improved?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+4         |  0           | CI is often red...
+4         |  0           | CI taking long time
+4         |  0           | changes/shifts/additions in requirements made during code review, could be potentially done earlier
+4         |  0           | We spent quite a bit of time thinking about how to do paging in the `list transactions` endpoint, but in the absence of concrete requirements from our users. In the end, it turned out that there really wasn't a requirement to do paging (at least not yet). Perhaps this time could have been spent on other things.
+2         |  0           | Some integration tests on had to be disabled cause they hanged CI (reason unknown); some disabled on PRs due to long running CI
+2         | -1           | Still have (too) long-running PRs (7+ days)
+1         |  0           | No release done for more than a month...
+1         |  0           | The wallet and the ways we test it feels complex and tricky to do effectively
+1         |  0           | Comments got out of sync with source code updates
+0         |  0           | It feels as though there is a lot of duplication of effort between the CLI and the API integration tests, which sometimes end up looking rather similar to one another.
+0         | -1           | Rollback U/S took a long time to plan and split into tasks ⇒ bottleneck.

- Find a way to access logs on integration tests, especially on failures.
- Give another spin to bors, and do not run integration tests for each PR.
- Problems with requirements gathering triggered the creation of the adr repository and, the U/S google doc with the product team in order to find dedicated place to discuss requirements and design decisions, prior to start working on tasks.


## Ideas

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+2         | 0            | It would be wonderful to have (maybe demand) precise requirements in story before starting it voiced in such a way that it maps in straightforward way into tasks/tests. If so, then criteria needed to finish story successfully would be better articulated. Often superfluous work could be avoided.
+2         | -1           | The 'http-bridge' package could be removed.
+1         | 0            | Maybe we can speedup & reduce our dependency on integration tests, by transforming them into unit and something State-Machine-Test-like which 1) doesn't have to run /all/ integration tests on each PR 2) can chain sequences of commands for efficiency
+0         | 0            | The DB.MVar implementation is no longer any useful and could be removed
+0         | 0            | Encourage team members to turn on cameras during meetings so we can see each other while holding meetings.
+0         | -1           | The 'shelley' package temporarily created to show a prototype of stateless network layer could be removed.
+0         | -3           | Git repo is quite large to download

- Let's wait until we need to remove the http-bridge (because of maintenance cost) and only pull the trigger if we have to.
