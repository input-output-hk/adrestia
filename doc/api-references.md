## Components

### APIs

+-----------------+--------------+--------------+--------------+-----------------+
|      name       | description  |    Byron     | Jörmungandr  |     Shelley     |
+=================+==============+==============+==============+=================+
| cardano-wallet  | JSON/REST    | **COMPLETE** | **COMPLETE** | **IN PROGRESS** |
|                 | API for      |              |              |                 |
|                 | managing     |              |              |                 |
|                 | UTxOs in HD  |              |              |                 |
|                 | wallets      |              |              |                 |
+-----------------+--------------+--------------+--------------+-----------------+
| cardano-rest    | JSON/HTTP    | **COMPLETE** | **X**        | **IN PROGRESS** |
|                 | API for      |              |              |                 |
|                 | browsing     |              |              |                 |
|                 | on-chain     |              |              |                 |
|                 | data         |              |              |                 |
+-----------------+--------------+--------------+--------------+-----------------+
| cardano-graphql | GraphQL/HTTP | **COMPLETE** | **X**        | **IN PROGRESS** |
|                 | API for      |              |              |                 |
|                 | browsing     |              |              |                 |
|                 | on-chain     |              |              |                 |
|                 | data         |              |              |                 |
+-----------------+--------------+--------------+--------------+-----------------+

### API Links

-   [cardano-wallet](https://github.com/input-output-hk/cardano-wallet)
-   [cardano-rest](https://github.com/input-output-hk/cardano-rest)
-   [cardano-graphql](https://github.com/input-output-hk/cardano-graphql)

### CLIs

+----------------------+------------------+--------------+--------------+-----------------+
|         name         |   description    |    Byron     | Jörmungandr  |     Shelley     |
+======================+==================+==============+==============+=================+
| bech32               | Human-friendly   | **N/A**      | **COMPLETE** | **COMPLETE**    |
|                      | Bech32 addres    |              |              |                 |
|                      | encoding         |              |              |                 |
+----------------------+------------------+--------------+--------------+-----------------+
| cardano-wallet       | Command-line for | **COMPLETE** | **COMPLETE** | **IN PROGRESS** |
|                      | interacting with |              |              |                 |
|                      | cardano-wallet   |              |              |                 |
|                      | API              |              |              |                 |
+----------------------+------------------+--------------+--------------+-----------------+
| cardano-addresses    | Addresses and    | **COMPLETE** | **COMPLETE** | **COMPLETE**    |
|                      | mnemonic         |              |              |                 |
|                      | manipulation and |              |              |                 |
|                      | derivations      |              |              |                 |
+----------------------+------------------+--------------+--------------+-----------------+
| cardano-transactions | Transaction-     |              |              |                 |
|                      | construction     | **COMPLETE** | **X**        | **IN PROGRESS** |
|                      | and signing      |              |              |                 |
+----------------------+------------------+--------------+--------------+-----------------+

### CLI Links

-   [bech32](https://github.com/input-output-hk/bech32)
-   [cardano-wallet](https://github.com/input-output-hk/cardano-wallet)
-   [cardano-addresses](https://github.com/input-output-hk/cardano-addresses)
-   [cardano-transactions](https://github.com/input-output-hk/cardano-transactions)

### Haskell SDKs

+------------------------+-------------------+--------------+--------------+-----------------+
|          name          |    description    |    Byron     | Jörmungandr  |     Shelley     |
+========================+===================+==============+==============+=================+
| bech32                 | Human-friendly    | **N/A**      | **COMPLETE** | **COMPLETE**    |
|                        | Bech32 address    |              |              |                 |
|                        | encoding          |              |              |                 |
+------------------------+-------------------+--------------+--------------+-----------------+
| cardano-coin-selection | Coin selection    | **COMPLETE** | **COMPLETE** | **COMPLETE**    |
|                        | and fee balancing |              |              |                 |
|                        | algorithms        |              |              |                 |
+------------------------+-------------------+--------------+--------------+-----------------+
| cardano-addresses      | Addresses and     | **COMPLETE** | **COMPLETE** | **COMPLETE**    |
|                        | mnemonic          |              |              |                 |
|                        | manipulation and  |              |              |                 |
|                        | derivations       |              |              |                 |
+------------------------+-------------------+--------------+--------------+-----------------+
| cardano-transactions   | Transaction       |              |              |                 |
|                        | construction      | **COMPLETE** | **X**        | **IN PROGRESS** |
|                        | and signing       |              |              |                 |
+------------------------+-------------------+--------------+--------------+-----------------+

### Haskell SDKs links

-   [bech32](https://github.com/input-output-hk/bech32)
-   [cardano-coin-selection](https://github.com/input-output-hk/cardano-coin-selection)
-   [cardano-addresses](https://github.com/input-output-hk/cardano-addresses)
-   [cardano-transactions](https://github.com/input-output-hk/cardano-transactions)

### Rust SDKs (+WebAssembly support)

+------------------------------+---------------------------+---------+-------------+-----------------+
|             name             |        description        |  Byron  | Jörmungandr |     Shelley     |
+==============================+===========================+=========+=============+=================+
| cardano-serialization-lib    | Binary serialization of   | **N/A** | **N/A**     | **IN PROGRESS** |
|                              | on-chain data types       |         |             |                 |
+------------------------------+---------------------------+---------+-------------+-----------------+
| react-native-haskell-shelley | React Native bindings for | **N/A** | **N/A**     | **IN PROGRESS** |
|                              | cardano-serialization-lib |         |             |                 |
+------------------------------+---------------------------+---------+-------------+-----------------+

### Rust SDKS Links

-   [cardano-serialization-lib](https://github.com/Emurgo/cardano-serialization-lib)
-   [react-native-haskell-shelley](https://github.com/Emurgo/react-native-haskell-shelley)

### Formal Specifications

+---------------------------+----------------------------+
|           name            |        description         |
+===========================+============================+
| utxo-wallet-specification | Formal specification for a |
|                           | UTxO wallet                |
+---------------------------+----------------------------+

### Formal Specifications Link

-   [utxo-wallet-specification](https://github.com/input-output-hk/utxo-wallet-specification)

### Internal

These tools are used internally by other tools, so they're not as well documented as the tools listed above.

+--------------------------------------------------+----------------------------+
|                       name                       |        description         |
+==================================================+============================+
| cardano-js                                       | (experimental) Cardano     |
|                                                  | primitives for ECMAScript  |
|                                                  | applications               |
+--------------------------------------------------+----------------------------+
| cardano-js-sdk                                   | React Native bindings for  |
|                                                  | cardano-serialization-lib  |
| -----------------+-----------------------------+ |                            |
| persistent                                       | Fork of the persistent     |
|                                                  | Haskell library maintained |
|                                                  | for cardano-wallet         |
+--------------------------------------------------+----------------------------+

### Contributing 

See [CONTRIBUTING.md](https://github.com/input-output-hk/adrestia/blob/master/CONTRIBUTING.md)

