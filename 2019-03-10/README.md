# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 10</strong>: 2019/03/04 →  2019/03/08
</p>


# Non-Technical Summary

We started working on a brand new "minimal viable wallet" which will become, in
the long run, the new wallet backend for Cardano, with support for delegation. As 
a starter, we've setup a new repository with a full-blown revised continuous 
integration server.

We are now making our first steps with our new development process, embracing a 
new agile method known as eXtreme Programming which aims at doing short iteration
cycles with frequent releases. 

As a starter, we are now working on rebuilding the wallet primitive functionalities, 
getting rid of the legacy accumulated over the last past two years, and taking this
opportunity to make testing a first-class citizen in the our development process.


# Overview 

- [x] Completed our initial release planning meeting and selected a few user stories

- [x] We've setup a new repository and archive the previous `cardano-wallet` 
      (after renaming it to [cardano-wallet-legacy](https://github.com/input-output-hk/cardano-wallet-legacy))

- [x] Extended our [coding standards](https://github.com/input-output-hk/cardano-wallet/wiki/Coding-Standards)
      and defined a bunch of configurations for various editor tools (stylish-haskell, hlint, weeder, .editorconfig ...)

- [x] Setup our CI to this new repository, fully integrated with Github.
      - See [Travis CI](https://travis-ci.org/input-output-hk/cardano-wallet/builds/503635813), running on each PR and, after merges on `master`.
      - We do export [haddock documentation](https://input-output-hk.github.io/cardano-wallet/haddock) as a CI artifact.
      - We export code coverage report to [Coveralls](https://coveralls.io/github/input-output-hk/cardano-wallet).
      - We've setup deployment to Github releases for when our launcher is ready to be deployed.

- [x] We've defined and tested CBOR block and epoch decoders in order to unserialize binary data from the Cardano network
      protocol on Byron. This happens to be the same format used in the initial Shelley phase and, also used by the Rust [cardano-http-bridge](https://github.com/input-output-hk/cardano-http-bridge)

- [x] We have refined and completed the [final draft](https://rebilly.github.io/ReDoc/?url=https://raw.githubusercontent.com/input-output-hk/cardano-wallet/master/specifications/api/swagger.yaml) 
      for the wallet backend API V2, after several discussions and refinement with the frontend team.

- [x] We've groomed an initial CLI definition for what would become our new 'launcher', starting both a wallet server and a 'node backend' 

- [x] We have redefine the initial core primitive types from the wallet specification, making sure to leave flexible the address derivation 
      and address discovery mechanism such that, we end up with a wallet core code that is agnostic to the address scheme. 

- [x] We started to define a [capabilities Matrix](https://docs.google.com/spreadsheets/d/1fadIA_j4nCd3FbylPo5J8K9Fy6tixSC2T9V3xHKuUvU) 
      to keep track of the testing situation and features available in the wallet backend.


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


### :hammer: Support Wallet Creation

> **Summary**
>
> We want to define a full pipeline for our new wallet backend, starting just
> standard create/read operation for a wallet. We do not need to work on a
> persistence layer of any kind at this stage, and only focus on a dummy
> "db-layer". We do want to setup a servant web-server and lay down a separation
> of the various layers from our architecture.

```
[...............................................................................] 0% (0/18)
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
[...............................................................................] 0% (0/13)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099750">More information</a>
</p>


# Known Issues / Debts

We haven't completed any of the selected user stories this week, but have
mostly tackled half of them all. Hence, we are continuing on the same stories
for next week.
