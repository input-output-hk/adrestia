Adrestia is a collection of products which makes it easier to integrate
with Cardano. It comes in different flavours: SDK or high-level APIs.
Depending on the use-cases you have and the control that you seek, you
may use any of the components below.

Components
----------

APIs
~~~~

+-------------+-------------+-------------+-------------+-------------+
| name / link | description | Byron       | Jörmungandr | Shelley     |
+=============+=============+=============+=============+=============+
| `carda      | JSON/REST   | :heavy_     | :heavy_     | :co         |
| no-wallet`_ | API for     | check_mark: | check_mark: | nstruction: |
|             | managing    |             |             |             |
|             | UTxOs in HD |             |             |             |
|             | wallets     |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| [ca         | JSON/HTTP   | :heavy_     | :x:         | :co         |
| rdano-rest] | API for     | check_mark: |             | nstruction: |
|             | browsing    |             |             |             |
|             | on-chain    |             |             |             |
|             | data        |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| [carda      | G           | :heavy_     | :x:         | :co         |
| no-graphql] | raphQL/HTTP | check_mark: |             | nstruction: |
|             | API for     |             |             |             |
|             | browsing    |             |             |             |
|             | on-chain    |             |             |             |
|             | data        |             |             |             |
+-------------+-------------+-------------+-------------+-------------+

SDK
~~~

+-----------------+-----------------+-----------------+-----------------+
| Name / Link     | Description     | Haskell         | JavaScript      |
+=================+=================+=================+=================+
| [bech32]        | Human-friendly  | :he             | `bit            |
|                 | Bech32 address  | avy_check_mark: | coinjs/bech32`_ |
|                 | encoding        |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [car            | Addresses and   | :he             | :construction:  |
| dano-addresses] | mnemonic        | avy_check_mark: |                 |
|                 | manipulation &  |                 |                 |
|                 | derivations     |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [cardano-       | Coin selection  | :he             | :construction:  |
| coin-selection] | and fee         | avy_check_mark: |                 |
|                 | balancing       |                 |                 |
|                 | algorithms      |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [ca             | Shelley         | :x:             | :he             |
| rdano-launcher] | cardano-node    |                 | avy_check_mark: |
|                 | and             |                 |                 |
|                 | cardano-wallet  |                 |                 |
|                 | launcher for    |                 |                 |
|                 | NodeJS          |                 |                 |
|                 | applications    |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [cardano-ser    | Binary          | :construction:  | :construction:  |
| ialization-lib] | serialization   |                 |                 |
|                 | of on-chain     |                 |                 |
|                 | data types      |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [cardan         | Transaction     | :he             | :construction:  |
| o-transactions] | construction    | avy_check_mark: |                 |
|                 | and signing     |                 |                 |
+-----------------+-----------------+-----------------+-----------------+

Formal Specifications
~~~~~~~~~~~~~~~~~~~~~

=========================== ======================================
Name / Link                 Description
=========================== ======================================
[utxo-wallet-specification] Formal specification for a UTxO wallet
=========================== ======================================

Internal
~~~~~~~~

   :warning: Here be dragons. These tools are used internally by other
   tools and does not benefit from the same care in documentation than
   other tools above.

+------------------+--------------------------------------------------+
| name / link      | description                                      |
+==================+==================================================+
| [cardano-js]     | (experimental) Cardano primitives for ECMAScript |
|                  | applications                                     |
+------------------+--------------------------------------------------+
| [cardano-js-sdk] | (experimental) Cardano SDK for ECMAScript        |
|                  | applications                                     |
+------------------+--------------------------------------------------+
| [persistent]     | Fork of the persistent Haskell library           |
|                  | maintained for cardano-wallet                    |
+------------------+--------------------------------------------------+

.. _cardano-wallet: https://github.com/input
.. _bitcoinjs/bech32: https://github.com/bitcoinjs/bech32