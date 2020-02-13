# Wallet Backend Retrospective

<p align="right">2019/12/18</p>

## :tada: What Went Well?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+2         | 0            | Pairing on user stories seem to work well. We have been able to work (and make progress!) on several parallel topics which feels very productive.
+2         | 0            | Jörmungandr grammar ( https://github.com/input-output-hk/chain-libs/blob/master/chain-impl-mockchain/doc/format.abnf ) was helpful, especially when combined with our binary test roundtrip. We've been able to upgrade quite quickly to many different node releases.
+2         | 0            | Slack conversations tend to be more structured. The team has gained discipline about organizing discussions around topics.
+1         | 0            | The team has been able to make good progress over the past month or so.
+1         | 0            | Our integration test suite has gained a lot in reliability since we dropped code coverage calculation in CI. Although we are still often facing failures due to <insert random nix failure>, the overall sentiment is quite positive.
+1         | 0            | cardano-wallet is cross-compiled for a variety of targets. For example, fully static binary, a docker image, windows exe. More build targets are possible...
+1         | 0            | Users are getting their questions answered via GitHub issues.


## :construction_worker: What could be improved?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+1         | 0            | More predictability behind Jormungandr releases, especially those containing breaking changes. I really (Pawel) do not know what they work on and what is going to be solved next by them
+1         | 0            | We still do very little 1-o-1 short vocal chats and heavily rely on Slack / DM for conversations.
+0         | 0            | We do not track code coverage anymore.
+0         | 0            | JIRA U/S templates and workflow are not satisfactory and messy. Ideally, we would like it to reflect our process (pilot, co-pilot, 1-week sprints etc ..)
+0         | 0            | More deterministic CI. It is not so rare that CI is red and then green (and this after no real code change). Some checks are very often red and the PR is merged which is not very good principle to me (Pawel).
+0         | 0            | There were a couple defects in the stake pool database layer, mostly due to assumptions about the input data. Perhaps QSM tests are the easiest way to test the corner cases.
+0         | 0            | Jira doesn't support markdown and it's difficult to log in.
+0         | 0            | Finding the actual failure in the long CI logs can sometimes be tricky. Could optimally be more obvious to tell at a glance.

## :bulb: Ideas

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+1         | 0            | Ask Alexander Diemand or anyone from his team to do monitoring training during zurihac or later (they are going to also have week together after zurihack) - 2-day hands-on training how to use iohk-monitoring-framework. Start with something extremely simple like https://blog.jle.im/entry/simple-tcpip-services-servant.html#.XUh_fBq3GUE.twitter and enable step-by-step all fancy monitoring. Understand all options available
+1         | 0            | Slack notifications for Buildkite nightly/master branch builds.

## :ballot_box_with_check: Actions

- [ ] Encourage pilot/co-pilot to share their plan with the rest of the team *before* they actually start working.
- [ ] Turning slack off for a period also help gaining focus.
- [ ] Often hard to identify upfront that a vocal conversation is needed. Yet, a lot of conversations happening in DM could instead happen in thread on the main channel for the benefits of other team members.
- [ ] Reach out to Jeremy / Jonathan about getting more permissions to set up JIRA templates and workflow correctly. 
- [ ] HerculesCI is not required and can be ignored (we are still experimenting). Also, Hydra could be ignore on PR and only triggered on master builds.
- [ ] Find a way to get more insights from the logs upon test failures and report it directly on GH. In particular, the last request/response we did and more informative assertion failures. Also, we could make use of GH checks API to report directly in GH some CI failures like hlint or stylish-haskell.
- [ ] Prepare a clear set of questions and see with the iohk monitoring team whether they could help us tackle these.
