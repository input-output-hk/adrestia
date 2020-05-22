# Adrestia Weekly Report

<p align="right">
  <strong>Week 21</strong>: 2020/05/18 → 2020/05/22
</p>

# Project Overview

## ⛅ Forecast

### 2020/05/26

- (ADP-157) Manage key registration certificates w/ cardano-node
- (ADP-291) Document error conditions of API endpoints
- (ADP-319) Continue integration with Shelley node: transaction support
- (ADP-283) Reduce variability in fee estimation

### 2020/06/02

- (ADP-244) Cardano decentralization progress
- (ADP-244) Shelley activation countdown

# Past Week Overview

#### cardano-wallet | latest = [v2020-05-06](https://github.com/input-output-hk/cardano-wallet/releases/v2020-05-06)

- Improved the fee estimation by running multiple selection and providing a better answer based on statistical results. The API now returns a bracket min/max 
  which should make the fee estimation more reliable. Before that, fee could vary drastically from a transaction to another depending on which UTxO were picked
  for the estimation and which were picked for the actual transaction.

- Many refactorings and code reorganizations to allow concurrent support of Jörmungandr and cardano-node w/ Shelley. 

- Implemented support for Shelley addresses in cardano-wallet; although cardano-wallet implements the final draft for addresses whereas cardano-node is still using 
  an intermediary non-compatible format. We'll partially alter this implementation to match the current node's format and enable an early integration. 

- Worked on the transaction layer for Shelley. We hit a wall regarding addresses which only got resolved late in the week.

- Fixed a regression found on the fee estimation due to a recent modification. Nightly benchmark caught the regression right away. 

- Fixed: Unable to fetch network tip from Jörmungandr ReST API in recent versions [#1647](https://github.com/input-output-hk/cardano-wallet/issues/1647)

#### cardano-graphql | latest = [1.0.0-rc10](https://github.com/input-output-hk/cardano-graphql/releases/tag/v1.0.0-rc.10)

- ø

#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = N/A

- ø

#### cardano-coin-selection | latest = [1.0.1](https://github.com/input-output-hk/cardano-graphql/releases/1.0.1)

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- Minor fixes and adjustments caught in past reviews.

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- ø

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Command-line interface is on its way for key derivation and address creation, including Byron, Icarus and Shelley styles.

# Known Issues / Debts

 Different behavior regarding resolved inputs when listing transactions with and without query parameters [#1670](https://github.com/input-output-hk/cardano-wallet/issues/1670)
