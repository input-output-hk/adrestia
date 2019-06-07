# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 23</strong>: 2019/06/03 →  2019/06/07
</p>

# Metrics

| Name            | Value                                     | Description                                                    |
| ---             | ---                                       | ---                                                            |
| Rolling Average | 6.2 (-25% :chart_with_downwards_trend:)   | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 19.71 (-11% :chart_with_downwards_trend:) | Average number of points the team can handle each week         |

# Non-Technical Summary

The team worked hard over the last past week to deliver the new database layer
that will power the Shelley wallet backend. This work is now complete and comes
with a solid testing mixing several techniques (property-based tests, unit
tests, stress tests, state-machine tests). Meanwhile, the team is also pushing
to get all of the existing integration test scenarios sufficiently generic to
run on top of a Rust node in BFT mode. This will be a major milestone for both
projects and is expected to happen very soon (as-in next week!). 
We are working on the side, and getting closer, to deliver a working development
environment for Daedalus to allow the integration work to begin here too. 

# Overview 

## :heavy_check_mark: Completed

- Embed network discrimination at the type-level and parameterize the 
  core wallet engine over it. This is a first step towards re-playing 
  our integration tests on top of Jörmungandr, as well as re-using all
  the core logic in Jörmungandr with a more transparent and type-safe API.

- Benchmarks for various operations of interest in SQLite, using realistic
  dataset. The role of these benchmarks is mostly to give us a baseline for
  documentation and, to identify areas where optimization would be needed.

- Adjusted server and command-line to use a file-based SQLite database 
  instead of the initial naive in-memory implementation. We also adjusted 
  the nightly restoration benchmarks to use SQLite and deliver more realistic
  results. 

- Additional tests for SQLite regarding interaction with files, making sure
  we can gracefully shutdown the database on failures.

- More automated integration testing regarding the CLI and in particular, 
  transaction submission via the CLI. 

- Finalize Jörmungandr HTTP client; this can now be used to implement our
  network layer (which is a slightly more high-level API than the "low-level"
  HTTP client). 

- Enable local clusters of Byron nodes in the launcher; This will allow
  Daedalus to use the new launcher in their e2e tests without much effort.
  
## :construction: Underway

- Support for serializing and submitting signed transaction to Jörmungandr. 

- Network layer implementation using Jörmungandr API

- Finalize endpoint & command to list addresses to support filtering by addrese
  state.

- Enable nix-tools to have a build pipeline for Daedalus development and 
  production. 

# User Stories 

### :heavy_check_mark: SQLite implementation for the DB Layer

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
[===============================================================================] 100% (24/24)
```

### :hammer: Jörmungandr High-level integration

:timer_clock: Estimated end date: Jun 10

> We have achieved to decouple the wallet core logic from its backend target
> and only support one target at the moment: cardano-http-bridge. Time has come
> to extend this to a new target: Jörmungandr. In this milestone, we'll start
> by implementing various primitives needed to comprehend new address and block
> formats used by Jörmungandr as well as, re-implementing a new network layer
> using the REST API provided by the node.

```
[=========================================================>.....................] 73% (21/29)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4295641">More Information</a>
</p>


### :hammer: Integrate node.js IPC listener in the launcher

:timer_clock: Estimated end date: Jun 10

> Daedalus (our main client) works by spawning a corresponding node backend
> process ensuring the supervision of the node. There are a few steps Daedalus
> goes through when starting a node as detailed in the diagram below:
> 
> Among them, one is of particular interest for us at this stage: the IPC
> channel. Because it's hard to choose a default port for our application (since
> on user's machine, another service may already be listening on the port we
> chose), we need the backend to be able to do a dynamic port selection (ask the
> OS to assign it an available port) and then, to communicate that port to
> Daedalus through the IPC channel.

```
[...............................................................................] 0% (0/5)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4196951">More Information</a>
</p>

### :hammer: Jörmungandr Integration Testing

:timer_clock: Estimated end date: Jun 24

> We've designed our wallet engine in such that it could work with _any_
> backend (cardano-sl, cardano-http-bridge, Jörmungandr, Shelley Haskell
> etc...).  The key piece in this puzzle is the network layer interface we
> define at the edge of the wallet engine which needs to be implemented. Once
> done, we can start working on replaying our integration and end to end tests
> using Jörmungandr as a backend and of course, resolve issues that will arise
> from this integration.

```
[...............................................................................] 0% (0/31)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378134">More Information</a>
</p>

### :hammer: Logging

:timer_clock: Estimated end date: Jul 17

> A required step towards a production-ready software is good logging
> capability.  Not only should we agree and define what to log and not to, but
> we also have to implement a reliable and non-intrusive logging solution using
> the iohk-monitoring-framework.

```
[...............................................................................] 0% (0/23)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378133">More Information</a>
</p>


### :hammer: List Addresses

:timer_clock: Estimated end date: Jun 10

> During previous sprints, we had to partially implement the listAddresses
> endpoint earlier than planned. In order to fully close the story about list
> addresses, we need to support an extra state query parameter to filter by
> address state.

```
[====================================================>..........................] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378138">More Information</a>
</p>

# Known Issues / Debts

- N/A
