# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 15</strong>: 2020/04/06 → 2020/04/10
</p>

# Project Overview

## :rocket: Latest release

cardano-wallet                                                                    | Jörmungandr                                                                    | cardano-node
---                                                                               | ---                                                                            | ---
[v2020-04-07](https://github.com/input-output-hk/cardano-wallet/tree/v2020-04-07) | [v0.8.15](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.15) | [1.9.3](https://github.com/input-output-hk/cardano-node/releases/tag/1.9.3)

- (ADP-31) Library/SDK: Mnemonics
- (ADP-32) Transaction Builder (Payment)
- (ADP-97) Nightly syncing tests with Byron TestNet/Mainnet

## ⛅ Forecast

### 2020/04/14

- (ADP-28) Library/SDK: Address Derivation 
- (ADP-83) Local State Query Protocol integration
- (ADP-213) Coin Selection: Library Reuse
- (ADP-187) GraphQL: postman use cases/scenarios
- (ADP-184) GraphQL: postman use cases/scenarios

### 2020/04/21

- (ADP-158) Shelley address format 
- (ADP-157) Manage key registration certificates

### 2020/04/28

- ???

# Past Week Overview

## :newspaper: Non-Technical Summary

#### cardano-wallet

- Mainly bug fixes and house-keeping. Hydra is now green on tests and builds, for both cardano-wallet w/ cardano-node and cardano-wallet w/ jormungandr.
  We do also have a new set of nightly integration tests running on an actual Windows machine (whereas unit tests are still run through Wine on Hydra).

- Reworked our release process and notes to remove some redundancy and automate some parts that were still manual. We also started making rotations to 
  increase knowledge sharing on releases and test our documentation! 

- Avoided generating addresses with soft indexes. This is causing some issue on the production Daedalus and cardano-sl:wallet. This reflects an actual
  issue with the production versions; addresses with soft indexes are a thing and there are some on the Mainnet blockchain: the shouldn't make the 
  software crash. Fortunately, the new cardano-wallet handles this just fine.

- Ported our API latency benchmarks to cardano-wallet w/ jormungandr.

- Improved some error messages on the API, in particular when trying to generate an address on an Sequential wallet (which is forbidden, the address set
  is managed by the wallet according to precise rules for sequential wallets).

- Reviewed clean shutdown mechanism on Windows to use a given file handle instead of forcing stdin. We aligned the command-line interface here with 
  cardano-node for consistency across components.

#### cardano-launcher

- Housekeeping, linting and documentation improvements.

- Added support for clean shutdown on Byron cardano-nodes.

#### cardano-coin-selection

- Cleaned up some of the modules to avoid code repetition and improve the public-facing API.

#### cardano-transactions

- Created `cardano-transactions`, a Haskell library for constructing, signing and serializing transactions. So far limited to simple UTxO payments, but exposes
  a graceful albeit simple Haskell [DSL](https://input-output-hk.github.io/cardano-transactions/haddock/Data-UTxO-Transaction.html#t:MkPayment).

- Put the DSL in application by constructing a command-line with it, allowing construction of transactions from the terminal, very inspired by `jcli`.
  More details [here](https://github.com/input-output-hk/cardano-transactions)

#### cardano-addresses

- Created `cardano-addresses`, a Haskell library for key derivation and address manipulation in Cardano. Only manipulation of mnemonic sentences are 
  available yet (see [haddock](https://input-output-hk.github.io/cardano-addresses/haddock/Cardano-Mnemonic.html)) but more is coming in the upcoming weeks. 

## :bug: Bug Fixes

- Icarus wallets are created with Mainnet addresses even if the server is in 'Testnet' mode [#1535](https://github.com/input-output-hk/cardano-wallet/issues/1535)
- Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283)
- Jormungandr and cardano-node release artifacts are broken for MacOS [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283)

# Next Week Planning

## :hammer:

- Finalize work on `cardano-selection` and `cardano-addresses`; get them ready for production use. 

- Start working on integrating with the local state query protocol, even though there's no Shelley-specific feature yet, we can still get familiar with the protocol
  in Byron in preparation of the Shelley integration.

- Continue chasing the few known bugs and tackling technical debts accumulated during the intensive ITN and Byron reboot launches.

- Get `cardano-graphQL` in a state where it is ready-for-production (in terms of testing and documentation).

# Known Issues / Debts

- Cannot force resync wallet and cardano-node crash as a result #1505
- Depth shouldn't be calculated for pending transaction #1563 
- Generated an unbalanced tx! Too much left for fees #1561 
- Submit transaction on staging_shelley gives 500 #1492
