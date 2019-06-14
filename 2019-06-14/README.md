# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 24</strong>: 2019/06/10 →  2019/06/14
</p>

# Metrics

| Name            | Value                                  | Description                                                    |
| ---             | ---                                    | ---                                                            |
| Rolling Average | 6.3 days (+0% :heavy_minus_sign:)      | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 21.43 (+9% :chart_with_upwards_trend:) | Average number of points the team can handle each week         |

# Non-Technical Summary

The team has done some effort in getting the new wallet backend server usable
for Daedalus. This is an important milestone as we want to have Daedalus
starting their integration as soon as possible now that the `http-bridge`
backend is ready and stable. In the meantime, the team makes progress with the
Jörmungandr integration and is extending the testing in this area too. We are
now able to spin up a Jörmungandr node and interact with it to retrieve BFT
blocks. The next major step in this area is the ability to submit signed
transactions and is landing very soon on the new wallet backend!

# Overview 

## :heavy_check_mark: Completed

- Merged `cardano-wallet-launcher` into `cardano-wallet`. We use to have 
  two different binaries which duplicated the maintenance and testing 
  effort on common things. Keeping both always in sync was always sometimes
  challenging; Instead we now provide a `launch` command from the wallet 
  cli which turns out to also be much more intuitive from a user perspective.

- Resolved some apparent semantic errors in our API specification (OpenAPI / Swagger)
  such that the file can be parsed and used to automatically derive API clients 
  in any language. This was noticed by team working on the JavaScript SDK as they
  tried to use our API specifications. We've also added an automated CI check
  to make sure that the file remains valid in the future.

- Enabled random port selection on the wallet server. Allowing it to connect to 
  any available port on demand. It is still possible to give / force a particular
  port if necessary.

- Relocated integration tests scenarios outside of the `http-bridge` implementation.
  This in order to run them on top of the Jormungandr implementation later on.

- Adjusted the network layer to work from block headers instead of slots. This allows
  for supporting Jormungandr more easily. Also finalized the network implementation
  regarding fetching the network tip and a next "batch" of blocks (note that
  Jormungandr doesn't support batching at the moment so we emulate it by making 
  A LOT of requests which is terribly innefficient). 

- Added initial support for serializing signed transaction and submitting them to 
  Jormungandr for transaction using the legacy address format. However, testing
  is still missing in this area.

- Allowed filtering by address state when fetching addresses of a wallet
  (from both the API and the CLI).

- Enabled SQLite backend for all integration test scenarios. This has yield a few 
  "last minute" bugs regarding pending transaction and how they were stored in the
  database. 

- Setup an initial logging infrastructure using the `iohk-monitoring-framework`. This
  comes has a nice replacement for ugly prints to console that used to be done in the 
  wallet layer.

- Re-implemented the node.js IPC protocol and server to support connectivity with Daedalus.
  We weren't able to re-use the code present in `cardano-shell` and will give feedback
  about _why_ (or make a PR directly to adjust the implementation there). 
  
## :construction: Underway

- Allow the log severity level to be tweaked when starting a wallet server.

- Finalize testing and implementation for submitting transactions to Jormungandr using
  new shelley addresses (or actually any sort of address).

- Setup faucet wallets on Jormungandr and run the integration scenarios using Jormungandr 
  as a backend target.

- Hook up integration tests 

- Implement API-level logging & extend logging done within the core wallet business
  logic to help debugging and understand what's going on within the application at
  all time.

# User Stories 

### :heavy_check_mark: Integrate node.js IPC listener in the launcher

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
[===============================================================================] 100% (5/5)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4196951">More Information</a>
</p>

### :heavy_check_mark: List Addresses

> During previous sprints, we had to partially implement the listAddresses
> endpoint earlier than planned. In order to fully close the story about list
> addresses, we need to support an extra state query parameter to filter by
> address state.

```
[===============================================================================] 100% (3/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378138">More Information</a>
</p>

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
[============>..................................................................] 13% (5/31)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378134">More Information</a>
</p>

### :hammer: Logging

:timer_clock: Estimated end date: Jul 14

> A required step towards a production-ready software is good logging
> capability.  Not only should we agree and define what to log and not to, but
> we also have to implement a reliable and non-intrusive logging solution using
> the iohk-monitoring-framework.

```
[================>..............................................................] 22% (5/23)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4378133">More Information</a>
</p>

# Known Issues / Debts

- We are facing some delays with the Jormungandr network layer integration, so 
  now putting more focus on this story as it becomes blocking for the integration
  tests to follow.
  Delays are mostly due to last-minute API changes, unexpected bug from other part
  of the code and lack of expertise & focus regarding the story.
