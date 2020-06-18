####################
Cardano Architecture
####################

******************
High-Level Diagram
******************

Components
==========

`cardano-node`_
---------------

The core component which supports Ouroboros Praos.

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Windows (64-bits), Docker

`cardano-db-sync`_
------------------

A necessary middleware to power both [cardano-rest][cardano-rest] and [cardano-graphql][cardano-graphql]. This middleware stores blockchain data fetched from [cardano-node][cardano-node] in an intermediate database to enable higher-level interfaces for blockchain exploration.

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Docker

`cardano-wallet`_
-----------------

An HTTP REST API is recommended for 3rd party wallets and small exchanges who do not want to manage UTxOs for transactions themselves. Use it to send and receive payments from hierarchical deterministic wallets on the Cardano blockchain via HTTP REST or a command-line interface.

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Windows (64-bits), Docker

`cardano-rest`_
---------------

Consists of two HTTP APIs that are used to retrieve transactions, addresses, and time periods (epochs and slots) from the [cardano-db-sync][cardano-db-sync] component and submit an already serialized transaction to the network using [cardano-explorer-api][cardano-rest] & [cardano-submit-api][cardano-rest] respectively. The [cardano-submit-api][cardano-rest] uses the same API as the [cardano-sl:explorer][cardano-sl-explorer] to ease migration from already integrated clients. New integration should however look into [cardano-graphql][cardano-graphql].

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Docker

`cardano-graphql`_
------------------

HTTP GraphQL API for Cardano. A more flexible alternative for blockchain exploration than [cardano-rest][cardano-rest].

.. note:: Supported environments: Linux (64-bits), MacOS (64-bits), Docker 

Choosing the right component
============================

.. _cardano-node: https://github.com/input-output-hk/cardano-node
.. _cardano-db-sync: https://github.com/input-output-hk/cardano-db-sync
.. _cardano-wallet: https://github.com/input-output-hk/cardano-wallet
.. _cardano-rest: https://github.com/input-output-hk/cardano-rest
.. _cardano-graphql: https://github.com/input-output-hk/cardano-graphql