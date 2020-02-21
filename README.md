# Adrestia

Adrestia is a product team working on developing tooling and client interfaces
around Cardano. Our mission is to create an easier bridge between end-users
applications and Cardano core node by pushing out higher level interfaces to
interact with the Cardano blockchain.

This repository acts as a catalog of projects that fall under the scope of
Adrestia. The [wiki](https://github.com/input-output-hk/adrestia.wiki) summarizes also
the project's development practices and workflow.

# Architecture Overview


```
                                                      Adrestia
                                              <======================>

                                                +-----------------+        Daedalus
                                                |                 | HTTP   Exchanges
+--------------+ node-to-node               +-->+  cardano-wallet +------> Atala Prism
|              |                            |   |                 |        Dashboards
| cardano-node <---+                        |   +-----------------+        ...
|              |   |                        |
+------^-------+   |                        |
       |           |                        |
       |           |                        |
       |    +------v-------+                |   +-----------------+
       +    |              | node-to-client |   |                 | HTTP   Explorer v2
      ...   | cardano-node +--------------------> cardano-graphql +------> Exchanges
       |    |              |                |   |                 |        Pool Operator Tool
       |    +------^-------+                |   +-----------------+        ...
       |           |                        |
       |           |                        |
+------v-------+   |                        |
|              |   |                        |   +-----------------+
| cardano-node <---+                        |   |                 | HTTP   Explorer v1
|              |                            +--->   cardano-rest  +------> Exchanges
+--------------+ node-to-node                   |                 |        ...
                                                +-----------------+


                                              <======================>
                                                      Adrestia
```

# APIs

name / link       | description                                    | Byron              | Jörmungandr        | Shelley
---               | ---                                            | ---                | ---                | ---
[cardano-wallet]  | JSON/REST API for managing UTxOs in HD wallets | :heavy_check_mark: | :heavy_check_mark: | :construction:
[cardano-rest]    | JSON/HTTP API for browsing on-chain data       | :heavy_check_mark: | :x:                | :x:
[cardano-graphql] | GraphQL/HTTP API for browsing on-chain data    | :heavy_check_mark: | :x:                | :construction:


# Libraries

Name / Link              | Description                                       | Haskell            | JavaScript
---                      | ---                                               | ---                | ---
[cardano-coin-selection] | Coin selection and fee balancing algorithms       | :construction:     | :construction:
[cardano-addresses]      | Addresses and mnemonic manipulation & derivations | :construction:     | :construction:
[cardano-transactions]   | Transaction construction and signing              | :construction:     | :construction:
[cardano-binary]         | Binary serialization of on-chain data types       | :construction:     | :construction:
[bech32]                 | Human-friendly Bech32 address encoding            | :heavy_check_mark: | :x:

# Internal

> :warning: Here be dragons. These tools are used internally by other tools and
> does not benefit from the same care in documentation than other tools above.

name / link        | description
---                | ---
[cardano-launcher] | Shelley cardano-node and cardano-wallet launcher for NodeJS applications
[cardano-js]       | (experimental) Cardano primitives for ECMAScript applications


[cardano-wallet]: https://github.com/input-output-hk/cardano-wallet
[cardano-rest]: https://github.com/input-output-hk/cardano-rest
[cardano-graphql]: https://github.com/input-output-hk/cardano-graphql
[cardano-coin-selection]: https://github.com/input-output-hk/cardano-coin-selection
[cardano-addresses]: https://github.com/input-output-hk/cardano-addresses
[cardano-transactions]: https://github.com/input-output-hk/cardano-transactions
[cardano-binary]: https://github.com/input-output-hk/cardano-binary
[bech32]: https://github.com/input-output-hk/bech32
[cardano-launcher]: https://github.com/input-output-hk/cardano-launcher
[cardano-js]: https://github.com/input-output-hk/cardano-js
