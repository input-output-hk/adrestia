# Wallet Backend Retrospective

<p align="right">2020/02/13</p>

## :tada: What Went Well?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+3         | 0            | Our team managed to carry on and co-ordinate effectively while multiple members were away at the same time.
+3         | 0            | Slack's threaded conversation feature is still working relatively well for us.
+2         | 0            | CI feels much more stable than it used to. Buildkite and Hydra issues are less frequent.
+2         | 0            | Pilot/Co-Pilot ownership for stories is nice


## :construction_worker: What could be improved?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+3         | 0            | Get HR to allow more flexibility with postponing paid time off (PTO). We had a major release at the end of last year, but many people were forced into taking their PTO at the same time in order to avoid losing it!
+3         | 0            | CI: Hercules "derivations" and "evaluation" are always RED, which makes all our PRs look like they are failing to build.
+1         | 0            | The default JIRA dashboard "assigned to me" section doesn't filter out tasks that are already finished.
+1         | 0            | Automated tests on Windows... still failing
+0         | 0            | Jörmungandr not supplying historical performance data made it hard for us to offer useful performance metrics through our API.
+0         | 0            | When CI is failing, it's still — more or less — tricky to tell why.
+0         | 0            | On some occasions when team members were away, people in other teams weren't really sure who the "designated contact" was in our team. Though we did always manage to respond anyway.

## :bulb: Ideas

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+1         | 0            | Database migration tests are great, though they could be improved even further to check that important pieces of data survive migration.
+1         | 0            | Take turn for making the release.

## :ballot_box_with_check: Actions

- [ ] Support creation of a HR slack channel to raise such issues.
- [ ] Let's temporarily disable HerculesCI and turn it on later when relevant.
- [ ] Rework integration tests to give more context on failures + make sure tests are "debuggable" when they fail.
- [ ] Bring Windows failure on Hydra to the devops-crossteam-ci's attention
