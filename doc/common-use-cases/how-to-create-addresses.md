How to "create" addresses
=========================

> **Difficulty:**:  beginner

**Requires:**
- 📦 cardano-wallet >= `v2020-04-01`

You can manage your funds once you have a wallet. To receive a transaction, provide the sender with an address associated with your wallet.

## Random wallets (Legacy Byron)

Address creation is only allowed for wallets using random derivation. These are the legacy wallets from _cardano-sl_.

For `random` wallets, you need to invoke the following wallet endpoint to create new addresses:

[`POST /byron-wallets/{walletId}/addresses`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/createAddress)

Another endpoint can be used to list existing addresses.

[`GET /byron-wallets/{walletId}/addresses`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/listByronAddresses)


> **INFO**:
Alternatively, these endpoints can also be reached from the command-line:

```
$ cardano-wallet address create WALLET_ID
$ cardano-wallet address list WALLET_ID
```

## Sequential wallets (Icarus & Shelley)

Since Icarus, wallets use sequential derivation, which must satisfy very specific rules: a wallet is not allowed to use addresses beyond a certain limit before previously generated addresses have been used, for example. This means that, at a given point in a time, a wallet has both a minimum and a maximum number of possible unused addresses. By default, the maximum number of consecutive unused addresses is set to `20`.

Address management is entirely done by the server, and users are not allowed to interfere with them. The list of available addresses can be fetched from the server at any time via:

[`GET /byron-wallets/{walletId}/addresses`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/listByronAddresses)

This list automatically expands when new addresses become available, so there's always `address_pool_gap` consecutive unused addresses available (where `address_pool_gap` can be configured when a wallet is first restored / created).

> **HINT**:  Alternatively, this endpoint can also be reached from the command-line:

```
$ cardano-wallet address list WALLET_ID
```
