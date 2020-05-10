# Adrestia Weekly Report

<p align="right">
  <strong>Week 19</strong>: 2020/05/04 → 2020/05/08
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

#### cardano-wallet | latest = [v2020-04-28](https://github.com/input-output-hk/cardano-wallet/releases/v2020-04-28)

- Allow importing already generated addresses (via random derivation) into cardano-wallet, so that existing exchanges integrated with cardano-sl have an easier time migrating their installation to cardano-wallet.

- Write an exemplary docker-compose.yaml for cardano-wallet + cardano-node so that technical users have an easy way to start a cardano-wallet along with other services it depends on (i.e. a cardano-node). One can now get started with cardano-wallet in only two commands. No need to build anything, no need to go over any complex system setup. As simple as:

  ```
  wget https://raw.githubusercontent.com/input-output-hk/cardano-wallet/master/docker-compose.yml
  NETWORK=mainnet docker-compose up
  ```

  From there, interacting with cardano-wallet can be done using its command-line, through docker!

  ```
  docker run --network host --rm inputoutput/cardano-wallet --help 
  ```

  or, for example:

  ```
  docker run --network host --rm inputoutput/cardano-wallet network information
  ```

- Implemented a client and a mock of _Smash_, the new metadata aggregation server which will replace the CF registry for stake pools metadata. The official implementation from IOHK is not yet completed, but the design was specified using OpenAPI which made it possible to write client code and integrate ahead of time from the specification.

- Rework a bit the wallet command-line so that key derivation would take argument from the standard input stdin. This makes it possible to pipe commands through each other. For example:

  ```
  $ cardano-wallet mnemonic generate > credentials

  $ cardano-wallet key root $(cat credentials) \
      | cardano-wallet key child --path 1852H/1815H/0H/0/0 \
      | cardano-wallet key public \
      | cardano-wallet key inspect

  extended public key: 1a7d6d568052ebc0d11ab5355546c1b750a0b91a4c48b0d42afb985cea0ea35a
  chain code:          b343437e03648622cf3bfd3c30421fbe16779ce1a1a9a9ade90a305488ffe8be
  ```

- Improve various error messages and error outputs regarding the key commands. In particular, bech32 error detection was implemented, making it possible to pinpoint the exact location of mistyped or invalid characters in a bech32 string.

- Final implementation of the local state query Ourouboros mini-protocol with additional unit tests.

- Improvements in the network layer to reduce unnecessary logs as well as unnecessary block deserialization.  

- Added support for request pipelining for a drastic speed improvement in syncing time. Wallet restoration is now down to 6 minutes on Mainnet on decent hardware. Optimizations remain to be done on the edges which are rather insignificant on small wallets but have a bigger impact for wallets carrying many UTxOs.

#### cardano-graphql | latest = N/A

- Working on getting the service production-ready. Pushed rc9 which updates to a more recent version of the Hasura engine and contains improvement on the process termination handling.

#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = N/A

- ø

#### cardano-coin-selection | latest = [1.0.0](https://github.com/input-output-hk/cardano-graphql/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- Addressed a long-time known design flaw on one of the selection strategy (largest first). 
- Prevent the "migration" strategy from "creating funds" in rare edge-cases. 

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- ø

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Finalize support for Shelley addresses as well as several documentation and top-level API improvements across all modules. 

# Known Issues / Debts

- Byron `initCursor` does not seem to cause DB to rollback #1571  
- Unable to fetch network tip from Jörmungandr ReST API in recent versions #1647 
- Integration scenarios 'BYRON_ADDRESS' tests fail intermittently #1644 
- Restoration benchmark on mainnet for 1% and 2% ownership unexpectedly slow #1650 
