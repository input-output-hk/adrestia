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

+--------------------+--------------+----------+-------------+-----------------+
|    name / link     | description  |  Byron   | Jörmungandr |     Shelley     |
+====================+==============+==========+=============+=================+
| `cardano-wallet`_  | JSON/REST    | **DONE** | **DONE**    | **IN PROGRESS** |
|                    | API for      |          |             |                 |
|                    | managing     |          |             |                 |
|                    | UTxOs in HD  |          |             |                 |
|                    | wallets      |          |             |                 |
+--------------------+--------------+----------+-------------+-----------------+
| `cardano-rest`_    | JSON/HTTP    | **DONE** | **X**       | **IN PROGRESS** |
|                    | API for      |          |             |                 |
|                    | browsing     |          |             |                 |
|                    | on-chain     |          |             |                 |
|                    | data         |          |             |                 |
+--------------------+--------------+----------+-------------+-----------------+
| `cardano-graphql`_ |              | **DONE** | **X**       | **IN PROGRESS** |
|                    | GraphQL/HTTP |          |             |                 |
|                    | API for      |          |             |                 |
|                    | browsing     |          |             |                 |
|                    | on-chain     |          |             |                 |
|                    | data         |          |             |                 |
+--------------------+--------------+----------+-------------+-----------------+

SDK
---

+------------------------------+----------------+-----------------+---------------------+
|         Name / Link          |  Description   |     Haskell     |     JavaScript      |
+==============================+================+=================+=====================+
| `bech32`_                    | Human-friendly | **DONE**        | `bitcoinjs bech32`_ |
|                              | Bech32 address |                 |                     |
|                              | encoding       |                 |                     |
+------------------------------+----------------+-----------------+---------------------+
| `cardano-addresses`_         | Addresses and  | **DONE**        | **IN PROGRESS**     |
|                              | mnemonic       |                 |                     |
|                              | manipulation & |                 |                     |
|                              | derivations    |                 |                     |
+------------------------------+----------------+-----------------+---------------------+
| `cardano-coin-selection`_    | Coin selection | **DONE**        | **IN PROGRESS**     |
|                              | and fee        |                 |                     |
|                              | balancing      |                 |                     |
|                              | algorithms     |                 |                     |
+------------------------------+----------------+-----------------+---------------------+
| `cardano-launcher`_          | Shelley        | **X**           | **DONE**            |
|                              | cardano-node   |                 |                     |
|                              | and            |                 |                     |
|                              | cardano-wallet |                 |                     |
|                              | launcher for   |                 |                     |
|                              | NodeJS         |                 |                     |
|                              | applications   |                 |                     |
+------------------------------+----------------+-----------------+---------------------+
| `cardano-serialization-lib`_ | Binary         | **IN PROGRESS** | **IN PROGRESS**     |
|                              | serialization  |                 |                     |
|                              | of on-chain    |                 |                     |
|                              | data types     |                 |                     |
+------------------------------+----------------+-----------------+---------------------+
| `cardano-transactions`_      | Transaction    | **DONE**        | **IN PROGRESS**     |
|                              | construction   |                 |                     |
|                              | and signing    |                 |                     |
+------------------------------+----------------+-----------------+---------------------+

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

Building the Documentation
--------------------------

This documentation may be built with Sphinx:

```bash
python -m pip install --upgrade --no-cache-dir pip
python -m pip install --upgrade --no-cache-dir Pygments==2.3.1 setuptools==41.0.1 docutils==0.14 mock==1.0.1 pillow==5.4.1 alabaster>=0.7,<0.8,!=0.7.5 commonmark==0.8.1 recommonmark==0.5.0 sphinx<2 sphinx-rtd-theme<0.5 readthedocs-sphinx-ext<1.1
python -m pip install --exists-action=w --no-cache-dir -r doc/.sphinx/requirements.txt
sphinx-build -T -E -b readthedocs -d _build/doctrees-readthedocs -D language=en . _build/html 
```

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
