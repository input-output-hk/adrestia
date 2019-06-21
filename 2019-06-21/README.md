# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 25</strong>: 2019/06/17 →  2019/06/21
</p>

# Metrics

| Name            | Value                                        | Description                                                    |
| ---             | ---                                          | ---                                                            |
| Rolling Average | 4.9 days (-19% :chart_with_downwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 19 (-11% :chart_with_downwards_trend:)       | Average number of points the team can handle each week         |

# Non-Technical Summary

The wallet backend server is becoming more and more expressive and transparent
thanks to logging. Rich from the experience of the previous wallet backend, we
have made an attempt at making logging right this time. This new version should
offer a much greater experience to users of the wallet backend, including the
technical support desk often dealing with logs when trying to help end-users.
We are also facing our first big challenge regarding Jörmungandr integration
which requires some non-trivial fiddling in our internal architecture. However,
we have already successfully constructed and signed a few transactions using
the new formats compatible with Jörmungandr and, verified that our
implementation did indeed match what we could also obtain via `jcli` (the
command-line tool from Jörmungandr)! We are looking forward for the next big
step in this integration: end-to-end testing putting all the different layers
at work together.

# Overview 

## :heavy_check_mark: Completed

- Early in the week, we had an unexpected problem with our CI server (Travis).
  Somehow, something changed in the way the platform manages build caches and
  our pipeline was made totally unresponsive because of this. We resolved the
  issue within a day but not without any impact on our productivity. 

- Implemented a way to control logging severity when starting the application
  (via dedicated CLI flags: `--quiet`, `--verbose`). We also implemented the
  changes in the `cardano-http-bridge` rust codebase and submitted the changes
  upstream (since it wasn't possible to control the logging level for the
  bridge until now).

- Worked our way into setting up faucet wallets for Jörmungandr to be used in
  the integration tests. We've opted for an approach similar to what was done 
  with the http-bridge in order to maximise code-reuse and compatibility between
  the two approaches: a genesis UTxO is defined in the genesis configuration 
  using addresses generated from pre-generated mnemonic. This allows for a very
  easy restoration of funded wallets using a pre-generated mnemonic sentence.

- Implemented a low-level API request & response middleware, with fields 
  sanitization to prevent sensitive details from being logged (e.g. passphrases,
  mnemonic sentences etc ...). Every request is timestamped and assigned with
  a unique id (which makes identifying a (request, response) pair easier). 

- Drafted an initial transation layer for Jörmungandr, building and signing 
  transactions according to Jörmungandr's format. This also includes computing
  new transactions ids compatible with Jörmungandr. Testing is currently only
  covered via some golden tests, using transactions generated from `jcli` 
  (command-line interface coming along Jörmungandr).

- Fixed an edge-case bug where transaction with a null amount will result in a 
  500 Internal Errorbeing thrown when submitted through cardano-http-bridge.
  Byron nodes don't actually support null transactions.

- Wrote some extensive [logging guidelines](https://github.com/input-output-hk/cardano-wallet/wiki/Logging-Guidelines)
  to specify and disambiguate the semantic for log severity levels and logging
  materials. The goal of this document is to act as a contract between the
  wallet backend team and users of the software (i.e. the Technical Support
  Desk, Exchanges or developers integrating with the cardano wallet). Likely,
  the document will evolve as new needs and requirements regarding logging
  arise.

## :construction: Underway

- Application-level logging, including low-level logs from the database engine
  or the network layer, as well as additional logs in the business logic and
  the application layer itself.

- Integration tests for Jörmungandr. While working on the binary format for
  transactions, we encountered a challenging discrepency between the format used
  in Byron and the one used in Jörmungandr: Jörmungandr provides (and requires)
  inputs to carry their resolved amount. This little difference makes it rather 
  complex to actually support both the http-bridge and jörmungandr with the same
  codebase since this changes the structure of transactions themselves (and 
  everything that comes from it, like transaction ids). As a consequence, we had
  to parameterize the wallet engine over the transaction data-type,.

- Still working on running the integration tests for Jörmungandr. We're getting 
  closer to this now as the transaction layer is being finalized.

# User Stories 

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378138">More Information</a>
</p>

### :heavy_check_mark: Bugs Sprint 23-24

```
[===============================================================================] 100% (12/12)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378130">More Information</a>
</p>


### :hammer: Jörmungandr High-level integration

:timer_clock: Estimated end date: Jun 26

> We have achieved to decouple the wallet core logic from its backend target
> and only support one target at the moment: cardano-http-bridge. Time has come
> to extend this to a new target: Jörmungandr. In this milestone, we'll start
> by implementing various primitives needed to comprehend new address and block
> formats used by Jörmungandr as well as, re-implementing a new network layer
> using the REST API provided by the node.

```
[=======================================================================>.......] 90% (26/29)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4295641">More Information</a>
</p>


### :hammer: Jörmungandr Integration Testing

:timer_clock: Estimated end date: July 05

> We've designed our wallet engine in such that it could work with _any_
> backend (cardano-sl, cardano-http-bridge, Jörmungandr, Shelley Haskell
> etc...).  The key piece in this puzzle is the network layer interface we
> define at the edge of the wallet engine which needs to be implemented. Once
> done, we can start working on replaying our integration and end to end tests
> using Jörmungandr as a backend and of course, resolve issues that will arise
> from this integration.

```
[============>..................................................................] 13% (5/31)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378134">More Information</a>
</p>

### :hammer: Logging

:timer_clock: Estimated end date: Jun 28

> A required step towards a production-ready software is good logging
> capability.  Not only should we agree and define what to log and not to, but
> we also have to implement a reliable and non-intrusive logging solution using
> the iohk-monitoring-framework.

```
[===================================================>...........................] 65% (15/23)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378133">More Information</a>
</p>

# Known Issues / Debts

- Travis is getting more and more annoying regarding delays and issues. The last 
  two weeks have been very painful and we are considering more and more switching
  to Buildkite. Reworking the pipeline to work on Buildkite would however required
  a non negligible amount of work which we can't afford now. So this is a slightly
  frustrating situation to be in. 
