# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 21</strong>: 2019/05/20 →  2019/05/24
</p>

# Metrics

| Name            | Value                                    | Description                                                    |
| ---             | ---                                      | ---                                                            |
| Rolling Average | 8.9 (-7.3% :chart_with_downwards_trend:) | Average time for a ticket to go from 'In Progress' to 'Closed' |
| Velocity        | 22 (+21% :chart_with_upwards_trend:)     | Average number of points the team can handle each week         |

# Non-Technical Summary

We made huge progresses regarding testing and reliability this week. Doing so,
we've also improved our workflow and setup to get better and faster feedback
from our continus integration services.

We are approaching a stable implementation for our new SQLite persistence
backend and are now looking into some deep testing techniques to strengthen our
confidence regarding this new implementation. This includes state-machine
testing, time and space benchmarking and fault-tolerance testing.  

Meanwhile, we've extended our available packages with a deeply tested Haskell
implementation for Bech32 encoding which will power the new encoding format for
addresses in Shelley.  This is a nice contribution to the Haskell eco-system
with some very interesting features for users to prevent typing error when
entering an address by hand.

Beside, we're also polishing our documentations and error feedback from both
the [API](https://input-output-hk.github.io/cardano-wallet/api/edge/) and the
[command-line interface](https://github.com/input-output-hk/cardano-wallet/wiki/Wallet-command-line-interface).

# Overview 

## :heavy_check_mark: Completed

- Setup 'bors' to improve our PR management and avoid spending too much
  re-basing and keeping PRs up-to-date. Bors allows for automating PR merges
  into the main trunk, batching where suitable and re-trying on failures.

- Finally wrote end-to-end automated transaction integration tests on a local
  cluster of nodes using our new wallet backend implementation! We now have a
  proper and reliable framework for testing this and have already written a few
  test scenarios to increase our level of confidence regarding transaction
  submission. Doing so, we discovered an undesirable discrepency between our 
  implementation and the original wallet specification.

- Finalized most of the SQLite implementation details and made current set of
  property tests for our database layer work for both implementations (SQLite
  and MVar). This caught several bugs in the SQLite first implementation drafts
  that we eventually resolved. The overall interface now approaches stability
  although we're carrying on more testing in the area of state-machine testing.
  Later, we'll also look into benchmarking and, fault-tolerance testing before
  calling it done.

- We now build Jörmungandr in our CI and have an executable ready to play with
  in integration tests. While working on getting this done in our CI server, we
  also took the opportunity to rework a bit how the CI was organized to
  considerably reduce our build-time and put them back under a reasonable
  threshold (now ~12minutes per PR, vs ~40minutes before) without cutting on
  any testing or quality check.

- The API documentation now shows, for each endpoint, a feature availability /
  stability indicator. This makes it clear for people external to the team what
  is available and what isn't.

- API (and command-line) errors are now much more descriptives and include
  valuable information in a message payload. Before, the API used to return raw
  response with an appropriate HTTP error code but no content. 

- We discovered a subtle bug in the Haskell reference implementation of bech32
  encoding. We confirmed the presence of the bug with testing, and by
  comparison with other reference implementation in other languages (Python,
  JavaScript). This has been fixed in our implementation and we've alerted
  maintainers of the original reference implementation of it.  In addition,
  we'll create a pull request in the upcoming days with a fix, or offer our new
  implementation as a reference since we offer a nicer / safer module API (with
  more extensive errors) and features not present in the reference Haskell
  implementation (like error location detection, as supported by some other
  implementation in more mainstream languages like JavaScript)

## :construction: Underway

- Address format in shelley era (single and grouped addresses); We're parameterizing the wallet
  layer over the address encoding to allow keeping Base58 as an option (especially for regression
  testing and continuing support with Byron until Shelley's out), while allowing bech32 or any 
  other format. 

- Jörmungandr REST API integration and new network layer using it to power our wallet layer.

- QuickCheck state-machine testing for SQLite backend getting close to ready. We already found
  a subtle bug in the fresh new implementation thanks to this. Currently working on getting 
  better shrinker for failing cases and better labelling to make sure we cover as much interleaved
  scenarios as possible.

# User Stories 

### :heavy_check_mark: Bugs Sprint 19-20 

> Various bugs discovered during development, or part of the previous release.

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4338002">More Information</a>
</p>

```
[===============================================================================] 100% (20/20)
```

### :hammer: SQLite implementation for the DB Layer

:timer_clock: Estimated end date: Jun 09

> We do have an abstract db layer which is used by various pieces of the wallet
> backend. It is currently implemented through mutable shared variables (MVar)
> which lives in-memory and don't get persisted. Working towards a
> minimal-viable-solution, we need data to actually get serialized, persisted
> and deserialized such that they can survive a restart. We are going for a
> simple SQLite implementation in this first iteration which will likely be
> sufficient for quite a long time in the future as well, even for big players
> like exchanges.

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4196956">More Information</a>
</p>

```
[====================================================>..........................] 66% (16/24)
```

### :hammer: Jörmungandr High-level integration

:timer_clock: Estimated end date: Jun 09

> We have achieved to decouple the wallet core logic from its backend target
> and only support one target at the moment: cardano-http-bridge. Time has come
> to extend this to a new target: Jörmungandr. In this milestone, we'll start
> by implementing various primitives needed to comprehend new address and block
> formats used by Jörmungandr as well as, re-implementing a new network layer
> using the REST API provided by the node.

```
[===================================>...........................................] 36% (13/29)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4295641">More Information</a>
</p>


### :hammer: Integrate node.js IPC listener in the launcher

:timer_clock: Estimated end date: Jun 09

> Daedalus (our main client) works by spawning a corresponding node backend
> process ensuring the supervision of the node. There are a few steps Daedalus
> goes through when starting a node as detailed in the diagram below:
> 
> Among them, one is of particular interest for us at this stage: the IPC
> channel. Because it's hard to choose a default port for our application (since
> on user's machine, another service may already be listening on the port we
> chose), we need the backend to be able to do a dynamic port selection (ask the
> OS to assign it an available port) and then, to communicate that port to
> Daedalus through the IPC channel.

```
[...............................................................................] 0% (0/5)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4196951">More Information</a>
</p>

# Known Issues / Debts

- GET v2/wallets does not list wallets from oldest to newest (see [#250](https://github.com/input-output-hk/cardano-wallet/issues/250))
- Technical Debt Week 21 [#302](https://github.com/input-output-hk/cardano-wallet/issues/302)
