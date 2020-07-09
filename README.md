# Overview

Adrestia is a collection of products which makes it easier to integrate with Cardano. It comes in different flavours: SDK or high-level APIs. Depending on the use-cases you have and the control that you seek, you may use any of the components below.

# Getting Started


To get started, checkout the [📘 Adrestia user-guide](https://input-output-hk.github.io/adrestia/)! 


# Components

## APIs

name / link       | description                                    | Byron              | Jörmungandr        | Shelley
---               | ---                                            | ---                | ---                | ---
[cardano-wallet]  | JSON/REST API for managing UTxOs in HD wallets | :heavy_check_mark: | :heavy_check_mark: | :construction:
[cardano-rest]    | JSON/HTTP API for browsing on-chain data       | :heavy_check_mark: | :x:                | :construction:
[cardano-graphql] | GraphQL/HTTP API for browsing on-chain data    | :heavy_check_mark: | :x:                | :construction:


## SDK

### Haskell SDKs (+JS support)

Name / Link                    | Description                                                              | Haskell            | JavaScript
---                            | ---                                                                      | ---                | ---
[bech32]                       | Human-friendly Bech32 address encoding                                   | :heavy_check_mark: | [bitcoinjs/bech32](https://github.com/bitcoinjs/bech32)
[cardano-addresses]            | Addresses and mnemonic manipulation & derivations                        | :heavy_check_mark: | :construction:
[cardano-coin-selection]       | Coin selection and fee balancing algorithms                              | :heavy_check_mark: | :construction:
[cardano-transactions]         | Transaction construction and signing                                     | :heavy_check_mark: | :construction:

### Rust SDKs (+JS support)

Name / Link                    | Description                                                              | Rust               | JavaScript
---                            | ---                                                                      | ---                | ---
[cardano-serialization-lib]    | Binary serialization of on-chain data types                              | :construction:     | :construction:
[react-native-haskell-shelley] | React Native bindings for [cardano-serialization-lib]                    | :construction:     | :construction:

### Pure JS SDKs

Name / Link                    | Description
---                            | ---
[cardano-launcher]             | Shelley cardano-node and cardano-wallet launcher for NodeJS applications

## Formal Specifications 

Name / Link                 | Description                                       
---                         | ---                                               
[utxo-wallet-specification] | Formal specification for a UTxO wallet            

## Internal

> :warning: Here be dragons. These tools are used internally by other tools and
> does not benefit from the same care in documentation than other tools above.

name / link        | description
---                | ---
[cardano-js]       | (experimental) Cardano primitives for ECMAScript applications
[cardano-js-sdk]   | (experimental) Cardano SDK for ECMAScript applications
[persistent]       | Fork of the persistent Haskell library maintained for cardano-wallet


[cardano-wallet]: https://github.com/input-output-hk/cardano-wallet
[cardano-rest]: https://github.com/input-output-hk/cardano-rest
[cardano-graphql]: https://github.com/input-output-hk/cardano-graphql
[cardano-coin-selection]: https://github.com/input-output-hk/cardano-coin-selection
[cardano-addresses]: https://github.com/input-output-hk/cardano-addresses
[cardano-transactions]: https://github.com/input-output-hk/cardano-transactions
[cardano-serialization-lib]: https://github.com/Emurgo/cardano-serialization-lib 
[react-native-haskell-shelley]: https://github.com/Emurgo/react-native-haskell-shelley
[bech32]: https://github.com/input-output-hk/bech32
[utxo-wallet-specification]: https://github.com/input-output-hk/utxo-wallet-specification
[cardano-launcher]: https://github.com/input-output-hk/cardano-launcher
[cardano-js]: https://github.com/input-output-hk/cardano-js
[cardano-js-sdk]: https://github.com/input-output-hk/cardano-js-sdk
[persistent]: https://github.com/input-output-hk/persistent

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
