# Adrestia Weekly Report

<p align="right">
  <strong>Week 25</strong>: 2020/06/15 → 2020/06/19
</p>

# Project Overview

## ⛅ Forecast

### 2020/06/23

- (ADP-291) Document error conditions of API endpoints
- (ADP-311) Make stakepool metrics available through the API
- (ADP-302) Make reward account balance available through the API

### 2020/06/30

- (ADP-284) Redeem ITN rewards to mainnet wallet
- (ADP-287) Reward account as possible input for coin selection
- (ADP-333) Hardfork detection 

# Past Week Overview

#### cardano-wallet | latest = [v2020-06-05](https://github.com/input-output-hk/cardano-wallet/releases/v2020-06-05)

- Reviewed Docker image to make it minimal & self-contained (using static binaries produced by CI). 

- Some database clean-up and housekeeping after introduction of the dynamic protocol parameters.

- Revised API specifications regarding listing stake pools. We tried our best to preserve an identical API between the ITN and the HTN, but differences between Jörmungandr and cardano-node are too significant with regards to stake pools to not change the API. We had to change at least one endpoint, the one listing stake pools (see https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/listStakePools). Key changes are:
  1. Stake pools no longer return an `apparent_performance` metric.
  2. Stake pools are no longer ordered by `desirability` but are instead ordered by
    `non_myopic_member_rewards`.
  3. As a consequence of 2., the endpoint requires an explicit stake amount to be passed as a query parameter to indicate the _intended_ stake to delegate.
  4. Metadata no longer contain a `pledge_address` but do now contain an explicit `pledge` in lovelace.

- Get reward account balance from the local state query protocol. Turns out that this simple request is causing a lot of issue. The request is relatively _slow_ on the node's end, and, it fails when switching from an epoch to another. We are therefore working on installing some caching on our end, to get a more consistent behavior.

- Continued working on debugging our integration test cluster. We installed extra loggers and observable to better pinpoint issues when they occur. We have therefore re-enabled stake pools in the integration cluster which is necessary in order to observe specific things like rewards growing.

- Fixed an oversight in the endpoint supposed to returned protocol parameters. The endpoint was returning parameters from genesis only, instead of refreshing them regularly using the local state query protocol.

- Monitor the chain to discover, parse and extract stake pool registrations and the various details contained in registration certificates. 

- Finalized listing of stake pools using the local state query protocol. Pools can be listed and ordered based on a given indented stake amount. Still remain however, wiring together metadata, pools data from the local state query and pools data discovered from the chain (cost, margin, etc..). 

- Automatically and asynchronously fetch metadata associated with stake-pools from remote servers. This ought to be an intermediate solution until SMASH (the stake pools metadata aggregation server) is up-and-running and able to discover and serve metadata itself. Fetching is done one-by-one, with a rather strict timeout and defensive client to prevent bad actors from denying cardano-wallet. 

- Enable submission of already signed and serialized Shelley and Byron transactions through cardano-wallet. 

#### cardano-graphql | latest = [1.0.0-rc10](https://github.com/input-output-hk/cardano-graphql/releases/tag/v1.0.0-rc.10)

- ø

#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = N/A

- ø

#### cardano-coin-selection | latest = [1.0.1](https://github.com/input-output-hk/cardano-graphql/releases/1.0.1)

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- ø

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- ø

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Revised the output of the `inspect` commands for keys and addresses to return a structured JSON instead of unstructured ASCII text. 
  This makes it to include `cardano-address` as a tool to support features in client softwares like Daedalus.

# Known Issues / Debts

- [#1759](input-output-hk/cardano-wallet#1759) List/create shelley wallet while cardano-node is syncing takes a long time

- [#1740](input-output-hk/cardano-wallet#1740) Tx fee estimation is off when tx amount approaches wallet's balance

- [#1708](input-output-hk/cardano-wallet#1708) Cardano-wallet-shelley workers crash 

- [#1749](input-output-hk/cardano-wallet#1749) Sync percentage seems to be off on Shelley testnet 
