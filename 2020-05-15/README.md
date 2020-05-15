# Adrestia Weekly Report

<p align="right">
  <strong>Week 20</strong>: 2020/05/11 → 2020/05/15
</p>

# Project Overview

## ⛅ Forecast

### 2020/05/19

- (ADP-289) Initial server integration with cardano-node / Shelley
- (ADP-283) Reduce variability in fee estimation
- (ADP-257) API endpoint: 'sendAll' funds to a list of addresses

### 2020/05/26

- (ADP-157) Manage key registration certificates w/ cardano-node
- (ADP-291) Document error conditions of API endpoints

### 2020/06/02

- (ADP-244) Cardano decentralization progress
- (ADP-244) Shelley activation countdown

# Past Week Overview

#### cardano-wallet | latest = [v2020-05-06](https://github.com/input-output-hk/cardano-wallet/releases/v2020-05-06)

- Initial integration with cardano-node in Shelley mode. This includes a partial wiring of the underlying engine to the API, 
  adjustment to the networking layer to deserialize Shelley-specific data-types and the test bench for running a self-node 
  with faucets for running integration scenarios. Transaction support is not yet included as the binary formats and concrete
  crypto implementation are still being finalized on the node. We are working on this ahead of the release in order to win 
  some time. 

- Re-used some of cardano-addresses within cardano-wallet to reduce code duplication. It is unfortunately not possible to re-use it
  entirely since we've simplified several things in cardano-addresses (for a greater good).

- Good progress on the fee estimation rework, the API now returns a lower and upper bounds for fees, backed by an actual statistical 
  approach to get more reliable results, especially on bigger UTxOs. 

- Significantly reduced (up to 5x) both the time and the space needed to store sequential addresses, and reduced the space needed to store random 
  addresses without much consequence on the time. This started as an investigation for resolving #1650 which turned out to be a wrong 
  path, but still had a positive effect on overall performances. This shouldn't be much noticed by normal wallets, but have a significant impact
  on large wallets.

- Reworked the migration endpoint to work from a list of target addresses instead of a wallet id. This makes it more flexible and enables
  client to build cool features on top (like the ability to easily empty a wallet).

- Fixed `:latest` docker tag referencing latest master instead of the latest "stable" release
- Fixed #1650: Restoration benchmark on mainnet for 1% and 2% ownership unexpectedly slow 
- Fixed #1644: Integration scenarios 'BYRON_ADDRESS' tests fail intermittently 
- Discarded #1571: Byron `initCursor` does not seem to cause DB to rollback 


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

- ø

# Known Issues / Debts

- Unable to fetch network tip from Jörmungandr ReST API in recent versions #1647 
