# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 02</strong>: 2020/01/06 → 2020/01/10
</p>

# Non-Technical Summary

Getting back to a normal work pace, the team has spent some time wrapping up
existing work while finalizing requirements and analysis for the next steps in
order to integrate the wallet backend with the Haskell nodes. We've now fixed
most of the outstanding issues that have been discovered as part of the ITN
launch and have worked on better ways to catch bugs earlier in the process as
well as better ways to diagnose issues with the software. 

# Overview

## :heavy_check_mark: Completed

- Removed the `--logging-config` option from the command-line as it turned out 
  to be hard (and out of scope) to document and has been judged non-functional. 
  We have reported parsing and configuration issues to the iohk-monitoring team. 

- Finalize logging refactoring to allow switching on and off individual tracers via
  the command-line. When needed, logging severity can be adjusted per component of 
  the backend.

  ```
  $ cardano-wallet serve --help-tracing
  Additional tracing options:

    --log-level SEVERITY     Global minimum severity for a message to be logged.
                             Defaults to "INFO".

    --trace-NAME=off         Disable logging on the given tracer.

    --trace-NAME=SEVERITY    Set the minimum logging severity for the given tracer.
                             Defaults to "INFO".

  The possible log levels (lowest to highest) are:
    DEBUG INFO NOTICE WARNING ERROR CRITICAL ALERT EMERGENCY

  The possible tracers are:
    application         About start-up logic and the server's surroundings.
    api-server          About the HTTP API requests and responses.
    wallet-engine       About background wallet workers events and core wallet engine.
    wallet-db           About database operations of each wallet.
    network             About networking communications with the node.
    stake-pool-monitor  About the background worker monitoring stake pools.
    stake-pool-layer    About operations on stake pools.
    stake-pool-db       About database operations of the stake pools database.
    daedalus-ipc        About inter-process communications with Daedalus.
  ```

- Refactored how integration tests referenced API endpoints to remove duplications and
  introduce more homogeneity in the endpoint manipulation. As a nice effect, we'll soon 
  be able to greatly simplify our integration scenarios to makes scenarios easier and 
  faster to maintain. 

- Finally got Windows tests executed under Wine in Hydra :tada:! This includes both 
  unit and integration tests. Not all of them are green yet, but it's now much easier
  to assess how the software is doing on Windows in a continuous integration fashion!

- Released [v2020-01-07](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2020-01-07)


# Bug Fixes

- Nightly benchmarks were failing after a recent update in the Haskell.nix framework. Fixed in [#1252](https://github.com/input-output-hk/cardano-wallet/issues/1252)

- Fixed a non handled (benign) database error arising after deleting a wallet. [#1242](https://github.com/input-output-hk/cardano-wallet/issues/1242)

- Revised rollback logic in an attempt to solve the 0-balance issue experienced by some users. [#1146](https://github.com/input-output-hk/cardano-wallet/issues/1146)


# User Stories

### :heavy_check_mark: (WB-31) Allow logs to be filtered by components

### :hammer: (WB-48) Order stake pool by "desirability"

> **User Story**  
> As a wallet user,  
> I can delegate to top ranked stake pools,  
> so that I can easily stake with confidence.

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/44">More Information</a>
</p>

### :hammer: (WB-53) Integrate cardano-wallet with Haskell Byron-rewrite

> **User Story**    
> As a cardano-wallet developer,  
> I want to be able to start a version of the cardano-wallet against a running Haskell Byron node.


```
[------------------------------------------------------------------------------] 0% (0/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/49">More Information</a>
</p>

### :hammer: (WB-14) Review API best practices about security

> **User Story**    
> As an API server,  
> I can serve requests according to secure coding practices,   
> so that I can be sure endpoints are less vulnerable.

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/48">More Information</a>
</p>

### :hammer: (WB-??) Clean up integration tests

> **User Story**    
> As a cardano-wallet developer,  
> I want a clean, maintainable and non error-prone integration environment  
> so that I can write test scenarios faster and with confidence.

```
[==========================>---------------------------------------------------] 33% (1/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/45">More Information</a>
</p>



# Known Issues / Debts

- Ø
