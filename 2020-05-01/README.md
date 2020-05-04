# Adrestia Weekly Report

<p align="right">
  <strong>Week 18</strong>: 2020/04/27 → 2020/05/01
</p>

# Project Overview

## ⛅ Forecast

### 2020/05/05

- (ADP-158) Shelley address format 
- (ADP-83) Local State Query Protocol integration
- (ADP-258) Integrate with the new stake pool metadata aggregation server 

### 2020/05/12

- (ADP-257) API endpoint: 'sendAll' funds to a list of addresses
- (ADP-270) Improve wallet sync time

### 2020/05/19

- (ADP-289) Initial server integration with cardano-node / Shelley
- (ADP-283) Reduce variability in fee estimation

# Past Week Overview

#### cardano-wallet | latest = [v2020-04-28](https://github.com/input-output-hk/cardano-wallet/releases/v2020-04-28)

- Removed 'force-resync' from the available endpoint. This was originally introduced as a possible way to recover from an invalid but ended up causing more troubles than good.

- Fixed some caching and reproducibility issue with the CI on the latency and restoration benchmarks.

- Re-use newly created `cardano-addresses` for mnemonic manipulation to reduce code duplication. 

- Now supports `bech32` as a possible input and output encoding (in addition to `base16`) for keys commands (e.g. `key child`, `key public` ...) in the command-line. 

- Relocated Jörmungandr-specific code relating to stake pools metadata and performance inside a dedicated package. This makes room for the upcoming integration with the new metadata aggregation server.

- Initial implementation and mock server for the new metadata aggregation server. Remains caching and optimizations. 

- Tweaked some default compilation flags to make compilation during development faster / more developer-friendly.

- Integrate with one other Ouroboros mini-protocols: local state query. This allows for querying part of the ledger state from a node. So far, integrated on top of our
  Byron-reboot integration but the protocol isn't Byron-specific so most of this is re-usable and directly applies for Shelley.
  
- Bump cardano-node to 1.11.0

#### cardano-graphql | latest = N/A

- Integrated Prometheus to export metrics into Grafana and gets proper monitoring of cardano-graphql.
- Improved the "getting started" experience by providing appropriate docker tags and example configuration.   
- Setup automatic deployment of graphql-voyager for visualizing cardano-graphql schema and queries (see [here](https://input-output-hk.github.io/cardano-graphql/)).

#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = N/A

- ø

#### cardano-coin-selection | latest = [1.0.0](https://github.com/input-output-hk/cardano-graphql/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- :bug: Fixed documentation and code coverage reports exports broken after introducing a new compilation flag.
- Polished documentation in preparation of the 1.0.0 release.

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- :bug: Fixed documentation and code coverage reports exports broken after introducing a new compilation flag.

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- :bug: Fixed documentation and code coverage reports exports broken after introducing a new compilation flag.
- Added [initial implementation / support for Shelley addresses](https://input-output-hk.github.io/cardano-addresses/haddock/cardano-addresses-1.0.0/Cardano-Address-Style-Shelley.html) (payment addresses and delegation addresses). 

# Known Issues / Debts

- Byron `initCursor` does not seem to cause DB to rollback #1571  
