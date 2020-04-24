# Adrestia Weekly Report

<p align="right">
  <strong>Week 17</strong>: 2020/04/20 → 2020/04/24
</p>

# Project Overview

## ⛅ Forecast

### 2020/04/28

- (ADP-158) Shelley address format 
- (ADP-83) Local State Query Protocol integration
- (ADP-190) Public key derivation via the command-line
- (ADP-258) Integrate with the new stake pool metadata aggregation server 

### 2020/05/05

- (ADP-157) Manage key registration certificates
- (ADP-195) Make Bech32 an available encoding in command-lines
- (ADP-213) Re-use cardano-coin-selection in cardano-wallet

# Past Week Overview

- Compiled the [Adrestia user guide](https://input-output-hk.github.io/adrestia/). The goal isn't to be a duplication of all the documentations that already exist on the
  various Adrestia projects but instead, a hub that connects the dots and show where to find information about any of those components. It's also a good place to put some
  common definitions or FAQ.

#### cardano-wallet | latest = [v2020-04-07](https://github.com/input-output-hk/cardano-wallet/releases/v2020-04-07)

- :bug: Depth shouldn't be calculated / returned for pending transaction [#1563](https://github.com/input-output-hk/cardano-wallet/issues/1563)

- :bug: DB.rollbackTo may cause inconsistencies between checkpoints and other data [#1575](https://github.com/input-output-hk/cardano-wallet/issues/1575)

- Removed passphrase validations for legacy wallets, unfortunately, we have to be backward compatible here

- Support for public key derivation in the wallet command-line. So far, the CLI is still a bit clunky to use, but we'll soon make it possible to pipe commands
  within each other which will: a) remove some security concerns from having raw private keys part of the bash history, b) makes it much easier to chain key derivation commands.

- Run benchmark on dedicated agents, so that we get reliable results across multiple benchmark runs. We can now plots benchmark results over time
  to more clearly identify potential regressions between builds. Here's a nice example plotting the results of the nightly restoration benchmarks against
  mainnet: http://cardano-wallet-benchmarks.herokuapp.com/mainnet-restoration.

- Allow client to run blocking NTP check by providing an extra API flag, and, now use a cached result by default (instead of querying central NTP servers on each request).

- Started playing a bit with request pipelining with the Ouroboros mini-protocols. First trials suggest that we could get a 33% decrease in restoration time
  just by using a pipelined client. Someone said _moar speed_?

- Upgraded to jörmungandr 0.18.0

#### cardano-graphql | latest = ø

- Complete rewrite of the documentation, getting more aligned with other Adrestia projects. 


#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = ø

- Improved nix-shell instructions on the top-level README

#### cardano-coin-selection

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- Reviewed exposed public package API to make it more user-friendly. Reworked types, reworded documentation. 
- Moved away from Travis to github actions for the CI workflow, to be more aligned with other library repositories.
- Reworked fee balancing to actually work with the unstable fee calculation from Byron and Shelley due to variable-length encoding of CBOR data-types.

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- ø

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Enabled code linters through the automated CI workflow 

- Initial code structure and data-types for Shelley addresses and key derivation.

# Known Issues / Debts

- Cannot force resync wallet and cardano-node crash as a result [#1505](https://github.com/input-output-hk/cardano-wallet/issues/1505)
- Submit transaction on staging_shelley gives 500 [#1492](https://github.com/input-output-hk/cardano-wallet/issues/1492)
