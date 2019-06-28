# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 26</strong>: 2019/06/24 →  2019/06/28
</p>

# Metrics

| Name            | Value                                      | Description                                                    |
| ---             | ---                                        | ---                                                            |
| Rolling Average | 5.6 days (+14% :chart_with_upwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 14.43 (-20% :chart_with_downwards_trend:)  | Average number of points the team can handle each week         |

# Non-Technical Summary

Some major steps done towards the end of the first phase of integration with a
Rust BFT self-node. We have successfully been able to enable and pass all the
API integration test scenarios we had in place for the http-bridge, but now,
using Jörmungandr as a backend target instead. This demonstrates the
integration of the wallet core engine with Jörmungandr. In other words, we do
now effectively have the ability to support two backend targets with maximum
code re-use between both implementation. We are now looking forward to make 
this available to users via the command-line interface, allowing anyone to 
start a wallet server on top of a running Rust BFT self-node. 

# Overview 

## :heavy_check_mark: Completed

- Parameterized wallet core engine over the transaction format, allowing to use slightly 
  different format for Jörmungandr and Http-Bridge.

- Reviewed golden tests for Jörmungandr and add more tests comparing both Mainnet and Testnet
  binary formats for transaction ids and signed transactions with `jcli`.

- Better error handling during http-bridge initialization phases.

- Released version v2019.06.24 which adds support for Node.js IPC and SQLite on-disk storage.

- Wrapped up Jörmungandr network layer (now allowing posting signed transaction to a self-node).

- Enabled API integration tests using Jörmungandr as a backend. 

- Fetch initial fee policy from the network (genesis block) instead of hard-coding them 
  (might it be in code or as configuration...)

- Cleaned up command-line interface code, factoring out generic commands and options in order
  to prepare support for Jörmungandr as a backend target.

- Add more logs in the application-layer to get better insights of a running wallet server.

## :construction: Underway

- Adjust current command-line interface in order to provide two different executables:
    - one working with http-bridge
    - one working with jörmungandr

- Improve code coverage and negative testing on Jörmungandr binary encoders & decoders

- Enable CLI integration tests with Jörmungandr as a backend target

# User Stories 

### :heavy_check_mark: Jörmungandr High-level integration

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
[================================>..............................................] 42% (13/31)
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
[=====================================================================>.........] 87% (20/23)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378133">More Information</a>
</p>

# Known Issues / Debts

| Issue Number                                                 | Type  |
| ---                                                          | ---   |
| https://github.com/input-output-hk/cardano-wallet/issues/460 | debts |
| https://github.com/input-output-hk/cardano-wallet/issues/409 | bug   |
| https://github.com/input-output-hk/cardano-wallet/issues/423 | bug   |
