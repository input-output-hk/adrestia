# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 20</strong>: 2019/05/13 →  2019/05/17
</p>

# Metrics

| Name            | Value    | Description                                                    |
| ---             | ---      | ---                                                            |
| Rolling Average | 9.6 days | Average time for a ticket to go from 'In Progress' to 'Closed' |
| Velocity        | 18.14    | Average number of points the team can handle each week         |

# Non-Technical Summary

Quite some work done on the integration side this week. We've been
strengthening our integration test suite in various way, automating some
still-manual bits of testing (like interacting with the command-line
interface). We have also started testing transactions over a local
cluster of Byron nodes which give us good confidence about the status
of our wallet layer. 

We've also started working on parsing the new binary format that Jörmungandr
use to represent blocks on the chain. We are now able to decode most
"legacy" pieces of information present in a genesis block (bits related to
the Shelley era have been left aside for now). 

Finally, another front is working on a new engine to support SQLite as
a database option. We've finalized database schemas and low-level
primitives to interact with it and are looking forward to implementing
a new version of our database interface using SQLite.

# Overview 

## :heavy_check_mark: Completed

- Designed necessary SQL schemas and database layout for implementing 
  our current database interface using an SQLite backend.

- Implemented (partial) block and block header binary deserializer for
  Jörmungandr new block format. We have focused on being able to decode 
  a genesis block, containing various blockchain configuration parameters
  and initial data. We do also recognize addresses using the current "Byron"
  format and are able to decode transactions that have address outputs 
  (delegation transaction and transactions that have accounts outputs are 
  currently ignored).

- Ported, verified and adapted a reference Haskell implementation for bech32 
  encoding (new user-facing encoding for Shelley addresses, less error-prone
  than the current base58 encoding). 

- Added extra integration tests to verify "secondary" wallet management 
  features (encryption passphrase update, metadata update ...) 

- Worked on making integration more reliable (using polling instead of 
  hard-coded delays, better log outputs, better service management...)

- Implemented initial set of SQLite queries and type serialization / 
  deserialization to be able to implement database layer using SQLite.
  This includes managing connection to an SQLite database.

- Automated CLI end-to-end testing, now run as part of the integration
  test-suite. This includes reviwing how code-coverage is computed to
  also include coverage reached from making CLI calls. 

## :construction: Underway

- Compiling, setting up and running Jörmungandr in our CI so that 
  integration tests can be performed against Jörmungandr's API.

- First end-to-end transaction integration tests with cardano-http-bridge.
  We finally finalized the necessary bits in our integration environment
  to now be able to send and watch transactions across wallets. This uses
  cardano-sl and cardano-http-bridge but achieve to finally test the integration
  of the various coin selection, fee calculation and transaction submission
  primitives! 

- SQLite implementation of the current database layer, the database layer is
  now partially implemented. SQL schemas have been designed and mostly every
  primitives and queries that are going to be needed for implementing the full
  db layer.

- Quickcheck state-machine testing for the new SQLite implementation, helping
  us testing a multitude of calls and possible interleaves. 

# User Stories 

### :heavy_check_mark: Technical Debts 

### :hammer: SQLite implementation for the DB Layer

:timer_clock: Estimated end date: Jun 07

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
[==========================>....................................................] 33% (8/24)
```

### :hammer: Jörmungandr High-level integration

:timer_clock: Estimated end date: Jun 07

> We have achieved to decouple the wallet core logic from its backend target
> and only support one target at the moment: cardano-http-bridge. Time has come
> to extend this to a new target: Jörmungandr. In this milestone, we'll start
> by implementing various primitives needed to comprehend new address and block
> formats used by Jörmungandr as well as, re-implementing a new network layer
> using the REST API provided by the node.

```
[===========================>...................................................] 35% (10/29)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4295641">More Information</a>
</p>


# Known Issues / Debts

- N/A (see [week 19](https://github.com/input-output-hk/cardano-wallet/tree/weekly-reports/2019-05-10#known-issues--debts))
