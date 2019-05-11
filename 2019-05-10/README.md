# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 19</strong>: 2019/05/06 →  2019/05/10
</p>

# Non-Technical Summary

This week, we've finalized our command-line interface for the wallet with
support for wallet management commands, with support for BIP-44-ish address
scheme (same as Icarus / Yoroi). Consequently, the wallet backend API for the
corresponding commands has also been fully finalized. This was a great
milestone to release a second version of the wallet backend (API & CLI) backed
into a single executable for linux.

Meanwhile, we've also started working on two major fronts:

- Working on a more production-ready database layer using SQLite
- Integrating with Jörmungandr, starting with the implementation of the various
  new binary formats and network protocol.

# Overview 

## :heavy_check_mark: Completed

- Second release of the wallet backend with extensive release notes and documentation.
  See [releases](https://github.com/input-output-hk/cardano-wallet/releases) on Github.
  Also, presented and discussed our release and development process with other leads, ops
  and release manager. Recording and chat transcript available [here](https://input-output.atlassian.net/wiki/spaces/REL/pages/721879179/Cardano+Wallet+team+s+development+and+release+process)

- Implement creation of transactions via the command-line interface. Still experimental
  as we need to enable transaction support in our integration environment.

- Improve high-level testing of the API and some type representations & various
  documentation improvement, polishing for the second release.

- Scaffold folder structure for incoming Jörmungandr backend implementation

- Implement remaining endpoints for wallet management (passphrase update, metadata updates)
  enabling QA for more integration tests.

## :construction: Underway

- Review and port reference implementation for [bech32](https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki) encoding
  (new encoding format used by Shelley addresses).

- SQL schema design for database-layer with SQLite.

- Setup database connections, tables and migrations for the SQLite backend.

- Block header & block binary decoders & encoders for Jörmungandr


# User Stories 

> :rocket: Average Velocity: 18.14 

### :hammer: SQLite implementation for the DB Layer

> We do have an abstract db layer which is used by various pieces of the wallet
> backend. It is currently implemented through mutable shared variables (MVar)
> which lives in-memory and don't get persisted. Working towards a
> minimal-viable-solution, we need data to actually get serialized, persisted
> and deserialized such that they can survive a restart. We are going for a
> simple SQLite implementation in this first iteration which will likely be
> sufficient for quite a long time in the future as well, even for big players
> like exchanges.

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4196956">More Information</a>
</p>

```
[...............................................................................] 0% (0/24)
```

### :hammer: Jörmungandr High-level integration

> We have achieved to decouple the wallet core logic from its backend target
> and only support one target at the moment: cardano-http-bridge. Time has come
> to extend this to a new target: Jörmungandr. In this milestone, we'll start
> by implementing various primitives needed to comprehend new address and block
> formats used by Jörmungandr as well as, re-implementing a new network layer
> using the REST API provided by the node.

```
[...............................................................................] 0% (0/29)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4295641">More Information</a>
</p>


### :hammer: Technical Debts 

> Technical debts from previous iterations, which includes in particular, missing
> integration tests and, enabling transactions in an integration environment.

```
[=====================================================================>.........] 88% (7/8)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/issues/220">More Information</a>
</p>


# Known Issues / Debts

- We might face some unforeseen discrepancy in the core model of the wallet
  between the Rust and Haskell backend  that we might not be able to resolve
  promptly.

- Still very pressured by time for implementing features and building-up the
  various part of the software that we haven't spent much time on measuring the
  robustness and overall performances of the software. It'd be unwise to
  release without a strong logging and clear metrics about the runtime
  behavior.

- It's still unclear how Daedalus will be able to start integrating with the
  new backend and what role they, we and devops will play into this. We still
  haven't started the integration between the wallet backend and Daedalus which
  is worrying.
