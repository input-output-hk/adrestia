# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 28</strong>: 2019/07/08 →  2019/07/12
</p>

# Metrics

| Name            | Value                                   | Description                                                    |
| ---             | ---                                     | ---                                                            |
| Rolling Average | 24.5 days (+230% :boom:)                | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 19.37 (+25% :chart_with_upwards_trend:) | Average number of points the team can handle each week         |

# Non-Technical Summary

The team is actively looking into getting a more complete software which can be
cross-compiled into several platforms with Linux, OSX and Windows as primary
targets. A lot of work also done in the direction of feature completeness. We
initially left aside a few features that were judged of lower priority and time
has come to finally implement them in order to make the new wallet backend a
true plausible replacement for the existing software currently deployed and
distributed to the community.

# Overview 

## :heavy_check_mark: Completed

- Windows cross-compilation source builds using the nix-tools. This is first
  step towards distributing the software on Windows. We are now trying to get
  our e2e test suite running on windows too, which would give us more confidence
  about the stability of the windows executables.

- Correctly estimated the maximum number of inputs allowed for a transaction. So far,
  we've been dealing with a hard-coded number although, this number could in practice
  be computed from the maximum transaction size allowed by the underlying network, and
  the number of outputs requested by the sender. This is now done.

- Extended the wallet layer and database layer to support listing transactions, 
  sorted by date of insertion. This is first step towards exposing this features into
  the API and command-line. 

- Better error handling in the CLI for edge cases (when providing unexisting or wrong
  filepaths as options, or when a target service, either bridge or jormungandr isn't 
  available).

- Allowed updating a wallet's master passphrase via the CLI. This was already present
  in the API for a while, but we somewhat forgot to implement its sister command in 
  the CLI :woman_shrugging:

- Extended test suites in various area with a few more negative test paths, especially
  in Jörmungandr's compatibility and network module.

- Slightly reworked blockchain polling duration to depends on the actual slot length
  (instead of a hard-coded delay).

- Enabled SQLite database stress benchmarks as nightly tests in buildkite (see [buildkite/Nightly/Database benchmark](https://buildkite.com/input-output-hk/cardano-wallet-nightly/builds/135#3977b58b-ff53-43d9-a861-c4aa497f11fe)
  , note that credentials and access to IOHK's buildkite infrastructure are required to access this link) 
  which generate a rather informative report as artifact. This can be use as a baseline 
  for comparison after new features are implemented.

- Fixed a subtle bug discovered in the coin selection algorithm where inputs wouldn't 
  be depleted as expected, resulting in too big transactions to be created, far beyond
  the acceptable limit of allowed inputs.

## :construction: Underway

- Golden tests / specification overview for CLI usage: since we switched to `optparse-applicative`
  as a command-line engine, it becomes more difficult to get a good overview of what our CLI
  actually looks like. So we have turned some comments as executable specifications.

- Introduce support for parsing basic and extended forms of ISO-8601 date strings. This will come
  into play to introduce filtering on the transaction history endpoint being implemented. We'll
  provide users the ability to filter and sort transactions from date ranges.

- Continue extending e2e tests with more scenarios, especially regarding fee estimation that
  was recently added. 

- Explore micro-benchmarks for the database layer using the IOHK monitoring framework. As the first
  users of the library, we're having some issues with it and are working in pair with the 
  performance team to solve them promptly. 

- Execution of e2e tests in a Windows environment (either through wine or an actual windows
  machine from cross-compiled code).

- Transaction history endpoint and CLI command, with proper support for filtering and sorting.

# User Stories 

### :hammer: Review Coin Selection

:timer_clock: Estimated end date: Jul 19

> The CS currently does this random + improvement procedure for all outputs, one
> output after the other. Instead, we could perform the random selection only for
> all outputs, and then, try to improve each output one after the other. This
> way, we can use our available inputs to cover requested outputs. And, once
> done, with the remaining available inputs, we try to improve each output one
> after the other. This should be much more resilient to multi-output transaction
> while still allowing a best-effort for cleaning up the UTxO as we make
> transactions.

```
[=========================================================================>.....] 92% (12/13)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4446161">More Information</a>
</p>


### :hammer: Finalize Transaction Endpoints

:timer_clock: Estimated end date: Jul 19

> The current / new API exposed by the wallet backend isn't yet fully implemented. 
> As Daedalus is now starting to integrate with this new API, we ought to complete
> the remaining endpoints with a lower priority that were left out the initial releases.

```
[====================>..........................................................] 26% (5/19)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4446162">More Information</a>
</p>

### :hammer: Bugs & Debts - Sprint 25-26

:timer_clock: Estimated end date: Jul 19

> Over the past months, we have implemented quite a lot of things and moved the wallet code
> in many direction (SQLite, Jörmungandr...). So, we are allocating a little bit of time
> to polish the implementation, and tackle a few debts that we have identified. The goal
> is to make the code more maintainable and increase the testing coverage in some areas.

```
[===========================================================>...................] 75% (12/16)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4446162">More Information</a>
</p>

# Known Issues / Debts

- Jörmungandr doesn't allow transactions to legacy addresses. This is a blocker
  if we intend to fully support legacy wallets with Jörmungandr. 

- We are having issues with our CI service recently which slows down a bit our
  development. It is unclear why the CI server is sometimes hanging "for no
  reason".
