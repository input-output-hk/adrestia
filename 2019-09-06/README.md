# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 36</strong>: 2019/09/02 → 2019/09/06
</p>

# Non-Technical Summary

Our database layout has been revised in order to better welcome checkpoints of
wallets. Checkpoints are essential for supporting rollback which may occur
arbitrarily often in a decentralized area. We've reviewed the database internal
structure in order to allow storing multiple checkpoints and navigating through
them efficiently. In addition, we are also wrapping up testing on the newly
added endpoint (and command on the command-line interface) regarding submission
of externally signed transactions. 

Meanwhile, as part of a new agile process, the team is going through a recovery
phase focused on improving the quality of the existing source code and its
surrounding documentation. 

# Overview

## :heavy_check_mark: Completed

- Finalized command-line for submitting externally signed transactions
- Tracked block height in the primitive wallet model (necessary step for rollbacks
  and a few metadata)
- Prepared SQLite database schema for rollbacks. This is a rather big structural
  change to the database to allow storing checkpoints in an efficient manner.
- Modified the core engine to create a new checkpoint for every block applied 
  to the wallet. This allows to effectively later rollback to any point in time.
- Reviewed CI job executions and finalized setting up bors for better management of
  pull requests and shorter CI build times. 
- Various documentation improvements and small refactorings to improve the overall
  quality of the code (as part of the recovery week).


## :construction: Underway

- Only create checkpoints for "unstable" blocks (within k blocks from the network tip).
- Add extra integration scenarios for external transaction submission
- Keeping track of unstable block headers in Jörmungandr's network layer: this to allows
  in a second time to figure out a common intersection between a wallet and a node after
  a rollback. 

# User Stories

### :heavy_check_mark: Signed Transaction Submission

> Some client applications prefer to perform key management and signing
> themselves. To support such use cases, Cardano Wallet will provide an API
> endpoint and corresponding CLI command to allow clients to submit
> already-signed transactions to the node.

```
[=========================================================================]  100% (19/19)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/26">More Information</a>
</p>

### :hammer: Support Rollbacks

> In a standard setup, it is very likely for a core node to roll-back (i.e.
> rewind the chain to a previous point in time). This means that the wallet
> backend must be able to correctly keep track of blocks, rolling backwards
> when needed and not only append blocks to an existing chain. Doing so,
> transactions that could have been inserted in recent blocks might become
> pending again, and balances may change to reflect the chain after a rollback.
> Beside, we do not want roll back to have a significant impact on the software
> usability. Hence, most features should remain available during rollbacks.
> Submitting transactions may be however forbidden during rollbacks.

```
[===================>-----------------------------------------------------]    25% (10/40)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/25">More Information</a>
</p>


# Known Issues / Debts

- N/A
