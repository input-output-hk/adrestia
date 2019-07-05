# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 27</strong>: 2019/07/01 →  2019/07/05
</p>

# Metrics

| Name            | Value                                       | Description                                                    |
| ---             | ---                                         | ---                                                            |
| Rolling Average | 10.6 days (+89% :chart_with_upwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 15.43 (+7% :chart_with_upwards_trend:)      | Average number of points the team can handle each week         |

# Non-Technical Summary

The team has finally achieved to integrate the new wallet backend with a BFT
Jörmungandr node.  Jörmungandr is therefore now offered as a target option in a
command-line interface to power the wallet backend. We are now taking a small
breath before working on the integration with the new Haskell nodes: we will
polish some implementation details, add testing in areas which lacks of it and,
implement some low-priority small features to make the API a bit more complete.
This will also leave time to correctly plan ahead the work to be done on the
Haskell integration, and maybe work on a small prototype to highlight early
potential integration issues.

# Overview 

## :heavy_check_mark: Completed

- Switched CLI engine / library from `docopt` to `optparse-applicative`. This allows for
  better code re-use and a more idiomatic approach to command-line declaration in Haskell.
  `optparse-applicative` has also some niceties like the ability to have multiple level of
  help, better error messages and, no more restrictions regardin the order of arguments.

- Implement command-line interface and server start-up for Jörmungandr. This (alongside 
  the integration and end-to-end tests) achieves the integration of the wallet backend 
  with Jörmungandr BFT nodes. As initially planned, we now have two executables with 
  slightly different interfaces to interact with either:
    - `cardano-wallet` + `cardano-http-bridge`
    - `cardano-wallet` + `jormungandr`

- Enabled remaining integration tests for Jörmungandr: automated tests for the command-line 
  interface. We've also reviewed our automated release script to now bundle both executables
  upon release. Next release would include support for Jörmungandr and be available soon.

- Added extra tests and invariants to Jörmungandr binary implementation to catch earlier possible
  binary encoding violations.

- Deferred _improvement_ step in the coin-selection, in the light of a recent bug found on
  cardano-sl which would cause the random-algorithm to deplete all available inputs in order
  to satisfy only the first outputs of a transactions. We do now make sure to first randomly
  cover all outputs of a transaction before trying to improve our selection. 

- Used more structured logging for SQLite. 

- Added endpoint for estimating transaction fee.

## :construction: Underway

- OSX & Windows cross-compilation

- Endpoint & CLI command for listing known transactions

- Replace hard-coded max number of inputs with an estimated number computed from the number of requested outputs.

# User Stories 

### :heavy_check_mark: Jörmungandr Integration Testing
### :heavy_check_mark: Logging

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
[================================================>..............................] 62% (8/13)
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
[...............................................................................] 0% (0/11)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4446162">More Information</a>
</p>

# Known Issues / Debts

- Jörmungandr doesn't allow transactions to legacy addresses. This is a blocker
  if we intend to fully support legacy wallets with Jörmungandr. 
