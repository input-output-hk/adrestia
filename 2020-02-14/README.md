# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 07</strong>: 2020/02/10 → 💞 2020/02/14 💘
</p>

# Non-Technical Summary

Controlling bug fixes from the previous week worked as expected in order to 
aim for a very stable release on the beginning of the following week. We've 
also continued the work on the new Haskell node integration, closing the gap
on the missing API endpoints from the integrated wallet. It is now a matter 
of performing deep integration tests and analysis to ensure that the integration
is indeed a full success.

# Overview

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-01-27](https://github.com/input-output-hk/cardano-wallet/tree/v2020-01-27) | [v0.8.7](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.7)

## :heavy_check_mark: Completed

- Improve the reporting of pending delegation certificates
  to better for wallet going through frequent delegation changes.
  The current version only reported the most recent pending 
  delegation certificates, whereas, there can be at most two 
  pending certificates by design, which are now correctly reported.

- Provide a real implementation for the LocalTxSubmission protocol
  on the byron's node integration. This enables us to start doing 
  some deeper integration testing, with as a first goal, the replication
  of all the existing integration integration test scenarios currently
  running on Jörmungandr. 

- Deep re-organization of JIRA product backlog trying to better
  align workflows between the Adrestia's team and Cardano's.

- Started writing engineering specifications about address derivation
  and mnemonic manipulation and root key generation from mnemonic 
  sentences. 

# Bug Fixes

-Ø

# User Stories

### :heavy_check_mark: (ADP-111) Better reporting of delays in delegation status

### :hammer: (ADP-81) Wallet: Command-line utils for key derivation

> **User Story**  
> As a wallet CLI,
> I am able to do HD derivation
> so that I am able create keys from a mnemonic.

```
[==============================================================================] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-81">More Information</a>
</p>


### :hammer: (ADP-159) Local Tx Submission Integration

> We've integrated with the chain-sync mini-protocol on a Byron rewritten node
> but are still using a placeholder for transaction submission. Transaction
> submission needs to be allowed through the API for the Byron-rewritten
> integration.

```
[=======================================>--------------------------------------] 50% (0/1)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-159">More Information</a>
</p>

### :hammer: (ADP-37) Library/SDK: Coin Selection & Fee Balancing

> As a Cardano developer,  
> I am able to use pre-defined coin selection and fee balancing algorithms,  
> So that I can leverage existing work easily.   

```
[------------------------------------------------------------------------------] 0% (0/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-37">More Information</a>
</p>


# Known Issues / Debts

-  Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
