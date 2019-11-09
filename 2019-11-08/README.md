# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 45</strong>: 2019/11/04 → 2019/11/08
</p>

# Non-Technical Summary

Still actively working on delegation support in the wallet while, juggling in the same
time with release candidates from Jörmungandr on the other side. The team is trying to 
stay close to Jörmungandr latest to avoid having to resolve too many integration issues
at the very last stage and also, to enable internal consumers of the wallet backend to
play with it on staging environments. 

# Overview

## :heavy_check_mark: Completed

- Fixed several issues with Windows. We still have test failures in our test suite, 
  mostly related to the file-system and/or TCP sockets management. We keep on pulling
  the thread here until all issues on Windows are resolved.

- Added more integration tests for migration of Byron wallets. In particular, testing
  with big wallets with a substantial UTxO set. The migration works but the request
  takes an oddly long time (~20 to 30s) which needs to be investigated.

- Polished some unfriendly error messages from the API noticed by Daedalus's team.

- Revised a few golden tests to also use `jcli` to construct transaction witnesses and
  fully compare whatever we produce with `jcli`.

- Cleaned up now obsolete abstractions in prevision of the upcoming Haskell node integration.

- Extended internal types to now support an extra path in the HD derivation to derive
  chimeric accounts from a root mnemonic.

- Upgraded to Jörmungandr@0.7.0-rc4. 

- Upgraded to Jörmungandr@0.7.0-rc5. This release contains a few breaking changes which 
  required special care on our side (removal of an existing REST endpoint, revision of 
  the binary format regarding transaction, initial configuration and certificates...). 
  We took the opportunity to improve a bit our internal error messages and testing around
  this. 

- Upgraded to Jörmungandr@0.7.0-rc7; we've completely skipped rc6. 

- New incremental pre-release [v2019-11-07](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2019-11-07)

## :construction: Underway

# User Stories

### :heavy_check_mark: Byron Wallet Support

> This milestone will add support for legacy Byron wallets. Users will be able
> to: restore a legacy wallet; view the balance of a legacy wallet; calculate the
> cost of migrating to a new wallet; and migrate funds from a legacy wallet to a
> new wallet. 

```
[==============================================================================] 100% (15/15)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/29">More Information</a>
</p>


### :hammer: Create Delegation Certificates

> As an API client, I want to be able to engage into the delegation protocol, so that wallet users can delegate funds.
> 
> Given that wallet users own a root private key derived from mnemonic
> And only one staking key is allowed per wallet 
> And wallet users have access to a list of available stake pools
> When they request to join an available stake pool
> Then a staking key is derived from their root private key
> And a delegation certificate is created using that stake key and a selected pool identifier
> And the delegation certificate is submitted to the network
> And a resulting transaction captures the state of that registration


```
[========================================================>---------------------] 71% (10/14)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/32">More Information</a>
</p>

### :hammer: Monitor Delegated Addresses


> As an API client,
> I am able to obtain a view how many rewards I am earning by taking part to Cardano
> delegation. I am also able to see the amount of actively delegated stake from my 
> wallet and I have access to addresses matching my delegation settings.
> 
> Given that wallet users may have delegation certificates published on the network
> When a delegation certificate is found during restoration
> Then the wallet settings correctly reflect the delegation settings of the last active certificate
> And users are able to monitor their reward balance earned from delegation
> And addresses reflect their delegation settings when listed from the API
> And available and total balance correctly reflects the wallet's activity.

```
[=======================================================>----------------------] 70% (14/20)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/32">More Information</a>
</p>

# Known Issues / Debts

- :warning: WINDOWS EXECUTABLES :warning:

  Windows builds and testing is still an issue. We are able to produce
  executable for Windows but we're still working on getting them to work. 
  We are now resolving the last issues with tests on Windows and making 
  progress. A list of remaining tasks is details in #888 below:

  See also: [#888](https://github.com/input-output-hk/cardano-wallet/pull/888)

- :warning: Previous Stake Distribution :warning:

  There's currently no way for a node client to have access to stake
  distributions of previous epochs. We have somewhat worked around it by trying
  to accomodate the lack of data by computing a performance indicator from a
  more distant past, yet it is unreliable and unsatisfactory.

  See also: https://github.com/input-output-hk/jormungandr/issues/852

- Missing `libcrypto.so.1.0.0` on some linux distributions

  see also [#923](https://github.com/input-output-hk/cardano-wallet/issues/923)
