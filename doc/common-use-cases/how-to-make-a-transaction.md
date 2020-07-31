How to make a transaction
=========================

> **Difficulty:**: beginner

**Requires:**
- 📦 cardano-wallet >= `v2020-04-01`

Assuming you have already created a wallet, you can send a transaction by using the following endpoint:

[`POST /v2/byron-wallets/{walletId}/transactions`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/postByronTransaction)

The wallet engine will select the necessary inputs from the wallet, generate a change address within the wallet, and sign and submit the transaction. A transaction can have multiple outputs, which might be to the same address. In Byron, addresses are necessarily base58-encoded as an enforced convention.

Once submitted through the wallet, a transaction can be tracked via:

[`GET /v2/byron-wallets/{walletId}/transactions`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/listByronTransactions)

This returns a list of all transactions for this particular wallet. Optional range filters can be provided. A transaction will go through a succession of states, starting as “Pending”. If a transaction stays pending for too long (because rejected by a mempool, or because lost in translation due to multiple chain switches, for example), users can decide to forget it using:

[`DELETE /v2/byron-wallets/{walletId}/transactions/{transactionId}`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/deleteByronTransaction)

For more information about a transaction's lifecycle, see this [wiki page](https://github.com/input-output-hk/cardano-wallet/wiki/About-Transactions-Lifecycle)

> **Difficulty:** advanced

**Requires:**
- 📦 cardano-transactions >= `1.0.0`
- 📦 cardano-submit-api >= `2.0.0` OR cardano-wallet >= `v2020-04-01`

Alternatively, `cardano-wallet` and `cardano-submit-api` allow clients to submit already signed and serialized transactions as a raw bytes blob. This can be done by submitting such serialized data as an `application/octet-stream` to either:

- cardano-wallet: [`POST   /v2/proxy/transactions`](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/postExternalTransaction)
- cardano-submit-api: [`POST    /api/submit/tx`](https://input-output-hk.github.io/cardano-rest/submit-api/#operation/postTransaction)

In this scenario, the server engine will verify that the transaction is structurally well-formed and forward it to its associated node. If the transaction belongs to a known wallet, it will eventually show up in the wallet your wallet.

Such transactions can be constructed from raw data using either [cardano-transactions library or command-line interface](https://github.com/input-output-hk/cardano-transactions). Examples and documentation excerpts are available on the corresponding Github repository.