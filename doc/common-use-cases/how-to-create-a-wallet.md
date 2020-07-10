How to create a wallet
======================

> **Difficulty**:  beginner

**Requires:**
- 📦 cardano-wallet >= `v2020-03-11`


The easiest and most common way of managing your funds on the Cardano blockchain is through a [hierarchical-deterministic-wallets](../key-concepts/hierarchical-deterministic-wallets.md). One can create a wallet using the following endpoint of [cardano-wallet](https://github.com/input-output-hk/cardano-wallet):

[`POST /byron-wallets`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/postByronWallet)

There are several wallet types available:
 - random
 - icarus
 - trezor
 - ledger

The basic difference between them is that for a `random` wallet user needs to [create new address](how-to-create-addresses.md) manually, whereas for sequential wallets like `icarus`, `trezor` and `ledger` addresses are [generated automatically](how-to-create-addresses.md#listing-addresses-in-sequential-wallets) by the wallet.

> **DANGER**:  Please note that `random` wallets are considered **deprecated** and should not be used by new applications.

Note also that you can have many wallets being operated by a single `cardano-wallet` server.

See more on [HD wallets](../key-concepts/hierarchical-deterministic-wallets.md) and [addresses](../key-concepts/addresses-byron.md).