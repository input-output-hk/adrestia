# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 22</strong>: 2019/05/27 →  2019/05/31
</p>

# Metrics

| Name            | Value                                  | Description                                                    |
| ---             | ---                                    | ---                                                            |
| Rolling Average | 8.2 (-8% :chart_with_downwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 22 (+0% :heavy_minus_sign:)            | Average number of points the team can handle each week         |

# Non-Technical Summary

More steps towards the integration with Jörmungandr this week. With a node
running in our CI environment and a network layer skeleton, we have been able
to talk to Jörmungandr in order to perform our first integration tests with the
new node. Meanwhile, we are now entering the last phase of development and
testing for the SQLite backend for we are looking into bechmarking the now
heavily tested implementation. Benchmarks also work like stress-tests to see
whether the new backend can survive an heavy workload and if any errors due to
heavy load arise. We have also achieved our support for the new address format
in Shelley, comparing our result with the Rust implementation and giving birth
to a battle-tested library for doing `bech32` encoding and decoding in Haskell.

# Overview 

## :heavy_check_mark: Completed

- Quickcheck state-machine testing for our database layer is now integrated
  with `master`. This is pretty heavy testing and it helped us caught quite a
  few subtle implementation bugs. We have finalized the implementation during
  the week, making sure to get proper shrinking and labelling of test cases to
  make sure that some particular scenarios of interest were checked. For now,
  this only test sequential scenarios where calls to the database layer happens
  one after the other. We do use a global locking system on the database-layer
  so, parallel utilizations shouldn't cause any particular problem. However,
  since there's never enough testing, we are also working on getting the
  state-machine testing work for parallel interleavings too.

- We've finalized the definition of the Servant client to speak with
  Jormungandr HTTP API and already integrated with some of the endpoints. We
  can now fetch the network tip from a running rust node and test that
  automatically in CI. This opens the gate for more testing to come. In
  particular, we do want to run our current integration scenarios onto
  Jormungandr (which should be possible without _too much_ effort since the
  integration scenarios are rather node-agnostic and just rely on the wallet
  backend API).

- We've discovered and reported new subtle "bugs" related to the `bech32`
  specification. This time, it wasn't an implementation bug, but an issue with
  the specification itself and its core design. Thanks to property-based
  testing, we were able to highlight some edge-cases that would bypass the
  checksum guarantees outlined in the specification. We have pointed the issue
  to the original authors who've acknowledged it and agreed that it should be
  documented as part of the specification document. See
  [sipa/bech32#51](https://github.com/sipa/bech32/issues/51).  As a
  consequence, we've adjusted our testing to acknowledge this quirk too which
  seem to be the only one we could identify.

- We now fully support the new address format in Shelley as described
  in [implementation-decisions 0001-address](https://github.com/input-output-hk/implementation-decisions/blob/master/text/0001-address.md)
  for Jormungandr. This support also includes support for "legacy" addresses
  that are still Base58 encoded using an underlying CBOR structure. The 
  "tour de force" here was to make our wallet core engine agnostic to the 
  address format such that, we could re-use the same core logic for any backend,
  and push the address encoding up to the actual node backend specific bits.

- More integration tests scenarios, in particular regarding address listing
  (a milestone initially planned for later that we had to tackle earlier in
  order to correctly test our transaction layer).

## :construction: Underway

- Benchmarking & stress-testing for the SQLite database layer. For now, 
  our implementation doesn't make much use of `Join`s which has some performance
  impacts. We are currently measuring this impact and, assessing whether some
  changes / optimizations will be required.

- Testing DB fault-tolerance, in particular, resilience of the database layer 
  to file corruption. This has been a recurring issue with users on Daedalus,
  so we're trying a simple but probably sufficient approach to this using
  backups and integrity checks to recover from a corrupted database.

- Remaining endpoints for the network layer integration with Jormungandr. This
  includes making our current integration scenarios able to run regardless of
  the node backend that is selected for the wallet.

# User Stories 

### :heavy_check_mark: Bugs Week 21-22

> Various bugs discovered during development, or part of the previous release.

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4365400">More Information</a>
</p>

```
[===============================================================================] 100% (9/9)
```

### :hammer: SQLite implementation for the DB Layer

:timer_clock: Estimated end date: Jun 09

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
[====================================================>..........................] 66% (16/24)
```

### :hammer: Jörmungandr High-level integration

:timer_clock: Estimated end date: Jun 09

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

:timer_clock: Estimated end date: Jun 09

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

# Known Issues / Debts

- Technical Debt Week 21 [#302](https://github.com/input-output-hk/cardano-wallet/issues/302)
