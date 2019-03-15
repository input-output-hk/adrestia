# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 11</strong>: 2019/03/11 →  2019/03/15
</p>


# Non-Technical Summary

Last week was mostly about setting up our new repository and getting started with our new 
development approach. This week, we've ported and reviewed a lot of the primitive building
blocks needed to implement various aspect of the wallet backend. This includes: manipulation
of mnemonic sentences, sequential address derivation and address discovery. Meanwhile, we've
finalized our first instance of a network layer which allows the wallet backend to connect
to another chain producer process. It relies, for now, on the cardano-http-bridge and we'll
soon implement other targets like the Shelley nodes (Rust and/or Haskell).


# Overview 

- [x] Reviewed and finalize the draft specification of the wallet backend API V2

- [x] Finalized the minimal viable wallet layer (basic model from the specs + rollbacks + prefiltering)

- [x] Added ticking function & initial basic network layer to periodically fetch blocks from 
      a chain producer and feed them into the wallet layer (this last part is yet to be done).
      The network layer is still very basic and makes a few assumption about the chain producer
      (not sending duplicates, not rolling back).

- [x] Implemente a first instance of our network layer talking to the cardano-http-bridge
      to retrieve blocks 

- [x] Port and review primitives about sequential address derivation

- [x] Port and review primitives about sequential address discovery 

- [x] Port and review primitives about mnemonic manipulation

- [x] Add preliminary structure for a DB layer



# User Stories 

### :hammer: Setup new cardano-wallet repostiory & CI

> **Summary**
>
> We have a new fresh repository with a working CI that allow us to implement
> our development process and iterate quickly on our various development task.


```
[=======================================================>.......................] 70% (7/10)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099748">More information</a>
</p>


### :hammer: Basic Launcher 

> **Summary**
>
> We want to have a basic launcher tool that help us spawn and start both the
> http bridge and the cardano wallet server, and make sure they are both
> up-and-running. If one of them crashes, the launcher crashes the other.

```
[================================================>..............................] 63% (5/8)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099756">More information</a>
</p>


### :heavy_check_mark: Support Wallet Creation

> **Summary**
>
> We want to define a full pipeline for our new wallet backend, starting just
> standard create/read operation for a wallet. We do not need to work on a
> persistence layer of any kind at this stage, and only focus on a dummy
> "db-layer". We do want to setup a servant web-server and lay down a separation
> of the various layers from our architecture.

```
[===============================================================================] 100% (13/13)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099765">More information</a>
</p>


### :hammer: Receive & Process Blocks (from 'cardano-http-bridge')

> **Summary**
> 
> We are wired to the cardano-http-bridge and are able to receive next blocks
> from the network and be in sync with a given network (mainnet or testnet).
> The bridge is still in the Byron Era and therefore, this is only a temporary
> solution to get something working.

```
[================================================================>..............] 81% (13/16)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099750">More information</a>
</p>

### :hammer: Wallet Layer Integration

> We have created various layers and primitives during the last past weeks, so
> it's now time to connect the pieces together and come up with a "deliverable"
> that can actually do something. For this first iteration, we are aiming for
> something simple and want a basic wallet that fetches blocks from the
> network, apply them, and outputs its current state.

```
[...............................................................................] 0% (0/39)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4141219">More Information</a>
</p>


# Known Issues / Debts

- We do not handle rollbacks yet on the network layer
- We forgot about maintaining a CHANGELOG
- The security parameter `k=2160` is currently hard-coded in the code. In practice, 
  it may change through protocol updates and should be tracked with blocks
- We do not have any benchmarking (speed or memory consumption) of the current code
