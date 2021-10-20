# Overview

Adrestia is a collection of products which makes it easier to integrate with Cardano. It comes in different flavours: SDK or high-level APIs. Depending on the use-cases you have and the control that you seek, you may use any of the components below.

# Getting Started


To get started, checkout the [📘 Adrestia user-guide](https://input-output-hk.github.io/adrestia/)!


# Components

## APIs

name / link       | description                                    | Byron | Jörm | Shelley | Mary  | Alonzo |
---               | ---                                            | ---   | ---  | ---     | ---   | ---    |
[cardano-wallet]  | JSON/REST API for managing UTxOs in HD wallets | ✔     | ✔    | ✔       | ❌     | 🚧     |
[cardano-graphql] | GraphQL/HTTP API for browsing on-chain data    | ✔     | ❌    | ✔       | ✔     | 🚧     |
[cardano-rosetta] | Implementation of [Rosetta][] spec for Cardano |       |      | ✔       | ✔     | 🚧     |
~[cardano-rest]~  | _Deprecated_                                   | ✔     | ❌    | ✔       | ❌     | ❌     |

## CLIs

Name / Link            | Description                                          | Byron | Jörm | Shelley | Mary  | Alonzo |
---                    | ---                                                  | ---   | ---  | --      | ---   | ---    |
[bech32]               | Human-friendly Bech32 address encoding               | N/A   | ✔    | ✔       | ✔     | ✔     |
[cardano-wallet]       | Command-line for interacting with cardano-wallet API | ✔     | ✔    | ✔       | ✔     | 🚧     |
[cardano-addresses]    | Addresses and mnemonic manipulation & derivations    | ✔     | ✔    | ✔       | ✔     | 🚧     |
[cardano-transactions] | _Deprecated_                                         | ✔     | ❌   | ❌       | ❌     | ❌     |

## Haskell SDKs

Name / Link              | Description                                       | Byron | Jörm | Shelley | Mary  | Alonzo |
---                      | ---                                               | ---   | ---  | ---     | ---   | ---    |
[bech32]                 | Human-friendly Bech32 address encoding            |       | ✔    | ✔       | ✔     | ✔     |
[cardano-addresses]      | Addresses and mnemonic manipulation & derivations | ✔     | ✔    | ✔       | ✔     | 🚧     |
[cardano-coin-selection] | _Deprecated_                                      | ✔     | ✔    | ✔       | ❌     | ❌     |
[cardano-transactions]   | _Deprecated_                                      | ✔     | ❌   | ❌       | ❌     | ❌     |

## Rust SDKs (+WebAssembly support)

Name / Link                    | Description                                           | Byron | Jörmungandr | Shelley
---                            | ---                                                   | ---   | ---         | ---
[cardano-serialization-lib]    | Binary serialization of on-chain data types           | N/A   | N/A         | ✔
[react-native-haskell-shelley] | React Native bindings for [cardano-serialization-lib] | N/A   | N/A         | 🚧

## JavaScript SDKs

Name / Link         | Description                                              | Byron | Jörm | Shelley | Mary  | Alonzo |
---                 | ---                                                      | ---   | ---  | ---     | ---   | ---    |
[cardano-launcher]  | node and cardano-wallet launcher for NodeJS applications | ✔     | ✔    | ✔       | ✔     | 🚧     |
[cardano-addresses] | Address validation and inspection                        | ✔     | ✔    | ✔       | ✔     | 🚧     |

## Formal Specifications

Name / Link                 | Description
---                         | ---
[utxo-wallet-specification] | Formal specification for a UTxO wallet

## Internal

> :warning: Here be dragons. These tools are used internally by other tools and
> does not benefit from the same care in documentation than other tools above.

name / link        | description
---                | ---
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
[rosetta]: https://www.rosetta-api.org/
[cardano-launcher]: https://github.com/input-output-hk/cardano-launcher
[cardano-rosetta]: https://github.com/input-output-hk/cardano-rosetta
[persistent]: https://github.com/input-output-hk/persistent

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
