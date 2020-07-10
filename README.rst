.. raw:: html

   <p align="center">
       <a href='https://cardano.readthedocs.io/projects/adrestia/en/latest/?badge=latest'><img src='https://readthedocs.org/projects/cardano-adrestia/badge/?version=latest' alt='Documentation Status' /></a>
   </p>

Adrestia is a collection of products which makes it easier to integrate
with Cardano. It comes in different flavours: SDK or high-level APIs.
Depending on the use-cases you have and the control that you seek, you
may use any of the components below.

Components
==========

APIs
----

+--------------------+--------------+--------------+--------------+----------------+
|    name / link     | description  |    Byron     | Jörmungandr  |    Shelley     |
+====================+==============+==============+==============+================+
| `cardano-wallet`_  | JSON/REST    | **COMPLETE** | **COMPLETE** | **IN PROGESS** |
|                    | API for      |              |              |                |
|                    | managing     |              |              |                |
|                    | UTxOs in HD  |              |              |                |
|                    | wallets      |              |              |                |
+--------------------+--------------+--------------+--------------+----------------+
| `cardano-rest`_    | JSON/HTTP    | **COMPLETE** | **X**        | **IN PROGESS** |
|                    | API for      |              |              |                |
|                    | browsing     |              |              |                |
|                    | on-chain     |              |              |                |
|                    | data         |              |              |                |
+--------------------+--------------+--------------+--------------+----------------+
| `cardano-graphql`_ |              | **COMPLETE** | **X**        | **IN PROGESS** |
|                    | GraphQL/HTTP |              |              |                |
|                    | API for      |              |              |                |
|                    | browsing     |              |              |                |
|                    | on-chain     |              |              |                |
|                    | data         |              |              |                |
+--------------------+--------------+--------------+--------------+----------------+

SDK
---

+------------------------------+----------------+----------------+---------------------+
|         Name / Link          |  Description   |    Haskell     |     JavaScript      |
+==============================+================+================+=====================+
| `bech32`_                    | Human-friendly | **COMPLETE**   | `bitcoinjs bech32`_ |
|                              | Bech32 address |                |                     |
|                              | encoding       |                |                     |
+------------------------------+----------------+----------------+---------------------+
| `cardano-addresses`_         | Addresses and  | **COMPLETE**   | **IN PROGESS**      |
|                              | mnemonic       |                |                     |
|                              | manipulation & |                |                     |
|                              | derivations    |                |                     |
+------------------------------+----------------+----------------+---------------------+
| `cardano-coin-selection`_    | Coin selection | **COMPLETE**   | **IN PROGESS**      |
|                              | and fee        |                |                     |
|                              | balancing      |                |                     |
|                              | algorithms     |                |                     |
+------------------------------+----------------+----------------+---------------------+
| `cardano-launcher`_          | Shelley        | **X**          | **COMPLETE**        |
|                              | cardano-node   |                |                     |
|                              | and            |                |                     |
|                              | cardano-wallet |                |                     |
|                              | launcher for   |                |                     |
|                              | NodeJS         |                |                     |
|                              | applications   |                |                     |
+------------------------------+----------------+----------------+---------------------+
| `cardano-serialization-lib`_ | Binary         | **IN PROGESS** | **IN PROGESS**      |
|                              | serialization  |                |                     |
|                              | of on-chain    |                |                     |
|                              | data types     |                |                     |
+------------------------------+----------------+----------------+---------------------+
| `cardano-transactions`_      | Transaction    | **COMPLETE**   | **IN PROGESS**      |
|                              | construction   |                |                     |
|                              | and signing    |                |                     |
+------------------------------+----------------+----------------+---------------------+

Formal Specifications
---------------------

+------------------------------+-------------------------------------------------+
|         Name / Link          |                   Description                   |
+==============================+=================================================+
| `utxo-wallet-specification`_ | Formal specification for a UTxO wallet encoding |
+------------------------------+-------------------------------------------------+

Internal
--------

.. warning::
    Here be dragons. These tools are used internally by other tools and does not benefit from the same care in documentation thanother tools above.


+-------------------+--------------------------------------------------+
|    name / link    |                   description                    |
+===================+==================================================+
| `cardano-js`_     | (experimental) Cardano primitives for ECMAScript |
|                   | applications                                     |
+-------------------+--------------------------------------------------+
| `cardano-js-sdk`_ | (experimental) Cardano SDK for ECMAScript        |
|                   | applications                                     |
+-------------------+--------------------------------------------------+
| `persistent`_     | Fork of the persistent Haskell library           |
|                   | maintained for cardano-wallet                    |
+-------------------+--------------------------------------------------+

.. _cardano-wallet: https://github.com/input-output-hk/cardano-wallet
.. _cardano-rest: https://github.com/input-output-hk/cardano-rest
.. _cardano-graphql: https://github.com/input-output-hk/cardano-graphql
.. _bech32: https://github.com/input-output-hk/bech32
.. _bitcoinjs bech32: https://github.com/bitcoinjs/bech32
.. _cardano-addresses: https://github.com/input-output-hk/cardano-addresses
.. _cardano-coin-selection: https://github.com/input-output-hk/cardano-coin-selection
.. _cardano-launcher: https://github.com/input-output-hk/cardano-launcher
.. _cardano-serialization-lib: https://github.com/input-output-hk/cardano-serialization-lib
.. _cardano-transactions: https://github.com/input-output-hk/cardano-transactions
.. _utxo-wallet-specification: https://github.com/input-output-hk/utxo-wallet-specification
.. _cardano-js: https://github.com/input-output-hk/cardano-js
.. _cardano-js-sdk: https://github.com/input-output-hk/cardano-js-sdk
.. _persistent: https://github.com/input-output-hk/persistent
