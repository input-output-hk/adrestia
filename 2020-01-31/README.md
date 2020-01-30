
# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 05</strong>: 2020/01/27 → 2020/01/31
</p>

# Non-Technical Summary

# Overview

1/3 of the team was on holidays this week which influenced our velocity a bit. Nevertheless, we managed to make progress on several items.  
  
Beginning of the week new wallet increment 'v2020-01-27' has been released. The changes included listing stake pools by desirability and introducing saturation indicator for each stake pool. The release also introduced new endpoint allowing users to force re-sync wallet without the need to delete and restore it again, which might be useful for resolving potential syncing issues.  
  
On development side we completed implementation of network parameters endpoint allowing users to fetch blockchain parameters for particular epoch. We have also started and advanced implementation of CLI utilities for key derivation as well as more detailed reporting of the delegation to show current and future delegation targets for particular wallet.

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-01-27](https://github.com/input-output-hk/cardano-wallet/tree/v2020-01-27) | [v0.8.7](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.7)

## :heavy_check_mark: Completed

- Released new wallet increment `v2020-01-27` including:
   - listing stake pools by desirability and introducing saturation indicator for 
   particular stake pool
   - new endpoint allowing force recync of Shelley and Byron wallets
   - several bug fixes 

- Completed (WB-47) Expose blockchain parameters via new endpoint - [#51](https://github.com/input-output-hk/cardano-wallet/milestone/51)

- Finished house-keeping tasks in the integration test scenarios.

- Made progress in implementation of:
  - Command-line utils for key derivation
  - Better reporting of delays in delegation status
  - New cardano-wallet launcher


# Bug Fixes

- Fixed flaky property test - [#1305](https://github.com/input-output-hk/cardano-wallet/issues/1305)


# User Stories


### :heavy_check_mark: (WB-47) Expose blockchain parameters via new endpoint

### :hammer: (ADP-92) Launcher: New launcher (no updates)

> **User Story**  
> 1. I want to start cardano-wallet (and its node)  
> 2. I want to cardano-wallet to use a free TCP port for its server  
> 3. I want to receive events when the wallet backend is started/stopped  
> 4. I want to receive events when the node is started/stopped  
> 5. I want to receive an event when the wallet API is ready  
> 6. I want a method to get the wallet backend API base URL and connection parameters  
> 7. I want a method to cleanly and reliably stop cardano-wallet (and its node)  
> 8. I want a documented Javascript module with typed interface files  
> 9. I want the cardano-launcher to be well-tested on Windows  
> 10. I want the module to output detailed logging  

```
[==================================================>--------------------------] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-92">More Information</a>
</p>

### :hammer: (ADP-81) Wallet: Command-line utils for key derivation

> **User Story**  
> As a wallet CLI,
> I am able to do HD derivation
> so that I am able create keys from a mnemonic.

```
[=========================>----------------------------------------------------] 33% (1/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-81">More Information</a>
</p>

### :hammer: (ADP-111) Better reporting of delays in delegation status

> **User Story**  
> As a wallet client,
> I want to reliably know how my delegation changes,
> So that I can better inform users about their current and next delegation settings.

```
[=========================>----------------------------------------------------] 33% (1/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-111">More Information</a>
</p>

# Known Issues / Debts

- `persistent` clear foreign tables on automatic migration due to cascading delete [#1279](https://github.com/input-output-hk/cardano-wallet/issues/1279)
-  Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
