High-Level Diagram
==================

.. mermaid::
   erDiagram
     CARDANO-NODE ||--o{ CARDANO-WALLET : sends-blocks-and-receives-txs
     CARDANO-NODE ||--o{ CARDANO-DB-SYNC : sends-blocks
     CARDANO-NODE ||--o{ CARDANO-SUBMIT-API : receives-txs

     CARDANO-DB-SYNC ||--|| POSTGRESQL : dumps-into

     POSTGRESQL ||--|| CARDANO-GRAPHQL : is-queried
     POSTGRESQL ||--|| CARDANO-EXPLORER-API : is-queried

Components
----------

[cardano-node][cardano-node]

The core [cardano-node][cardano-node], which will support Ouroboros Praos.

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Windows (64-bits), Docker

[cardano-db-sync][cardano-db-sync]

A necessary middleware to power both [cardano-rest][cardano-rest] and [cardano-graphql][cardano-graphql]. This middleware stores blockchain data fetched from [cardano-node][cardano-node] in an intermediate database to enable higher-level interfaces for blockchain exploration.

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Docker

[cardano-wallet][cardano-wallet]

[cardano-wallet][cardano-wallet] An HTTP REST API is recommended for 3rd party wallets and small exchanges who do not want to manage UTxOs for transactions themselves. Use it to send and receive payments from hierarchical deterministic wallets on the Cardano blockchain via HTTP REST or a command-line interface.

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Windows (64-bits), Docker

[cardano-rest][cardano-rest]

[cardano-rest][cardano-rest] is made of two HTTP APIs that are used to retrieve transactions, addresses, and time periods (epochs and slots) from the [cardano-db-sync][cardano-db-sync] component and submit an already serialized transaction to the network using [cardano-explorer-api][cardano-rest] & [cardano-submit-api][cardano-rest] respectively. The [cardano-submit-api][cardano-rest] uses the same API as the [cardano-sl:explorer][cardano-sl-explorer] to ease migration from already integrated clients. New integration should however look into [cardano-graphql][cardano-graphql].

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Docker

[cardano-graphql][cardano-graphql]

HTTP GraphQL API for Cardano. A more flexible alternative for blockchain exploration than [cardano-rest][cardano-rest].

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Docker 

Choosing the right component
----------------------------
.. mermaid::
   graph TD
   QMakeTx{Do you need to <br/> make transactions?} 
   QManageUTxO{Do you want to <br/>implement your own wallet?}
   QAlreadyIntegrated{Do you already have<br/>an integration with<br/>cardano-sl?}

   GraphQL{cardano-graphql}
   Rest{cardano-rest}
   SDK{SDK}
   Wallet{cardano-wallet}

   QMakeTx-->|yes| QManageUTxO
   QMakeTx-->|no| QAlreadyIntegrated
   QAlreadyIntegrated-->|yes| Rest
   QAlreadyIntegrated-->|no| GraphQL
   QManageUTxO-->|yes| SDK
   QManageUTxO-->|no| Wallet