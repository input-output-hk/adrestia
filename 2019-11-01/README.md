# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 44</strong>: 2019/10/28 → 2019/11/01
</p>

# Non-Technical Summary

Finally seriously diving into delegation! Better late than never. The wallet core
engine is going into a serie of major refactorings to allow for handling new shelley
addresses with delegation. We are also actively working on delegation certificate 
submission and recognition to allow users to take part into delegation.

Meanwhile, we've worked around some limitations in Jörmungandr REST API regarding 
stake distributions; We do now provide an "apparent performance" for stake pools
which allow for ordering them in a frontend application. 

We have also worked on a few minor bug fixes discovered last week.

# Overview

## :heavy_check_mark: Completed

- Extended Jörmungandr binary encoders & decoders to support stake delegation certificate
  (and transactions carrying a delegation payload). Doing so, we've also revised and 
  updated Jörmungandr documentation.

- Extended Jörmungandr binary decoders and internal representation of the fee policy 
  to account for certificate fees (required for submitting delegation certificate).

- Revised construction and interpretation of addresses in the core engine in order
  to enable two things:
    - Recognition of delegated addresses carrying a staking key 
    - Use of legacy addresses in the sequential discovery scheme 
      (i.e. allowing defining a set of API endpoints to work with legacy Yoroi wallets)

- Decoupled address format from their sequential discovery, allowing to efficiently 
  discover address from one address pool, regardless of whether they are delegated 
  addresses or not. 

- Implemented API types for stake pool delegation (Join & Quit), API handlers to
  come later.

- Added more test scenarios regarding listing stake pools, experimenting with
  short epochs and testing failover scenarios of the stake pool monitoring worker.
  We've also extended our integration setup so that we would run integration scenario
  on top of a self-node running multiple stake pools. 

- Computed and added a best-effort "apparent performance" to the list of stake
  pools, ordering them by their performance. This is however not ideal since 
  we don't actually have access to the stake distributions of previous epochs. 
  This means that a wallet offline too often will miss data and return a somewhat
  inaccurate performance indicator.

- Ugraded to Jörmungandr v0.7.0-rc3

- Fixed a bug where pending transactions wouldn't be returned by the API without a corresponding
  timestamp.

- Fixed a bug where the CLI would produce a somewhat unfriendly error when provided with 
  a wrong transaction id. 

- Fixed a bug regarding computation of syncing progress caused by a duplication of information
  in the database: a good reminder that softwares must have only a single source of truth!

- Fixed a bug in a test scenario regarding API ranges, written a long time ago but
  yielded recently by QuickCheck :man_shrugging:


## :construction: Underway

- :no_entry: (blocked, see below) Updating `Haskell.nix` to enable Windows build again.
- :no_entry: (blocked, see below) Fixing found issues on Windows (problem with locale encoding and emulation of `/dev/null` on Windows).
- Extending the transaction layer to construct a transaction for submitting a delegation certificate
- Extending HD derivation model to be able to derive Chimeric account / Staking key from a root key

# User Stories

### :no_entry: Byron Wallet Support

> This milestone will add support for legacy Byron wallets. Users will be able
> to: restore a legacy wallet; view the balance of a legacy wallet; calculate the
> cost of migrating to a new wallet; and migrate funds from a legacy wallet to a
> new wallet. 

```
[==============================================================================] 100% (15/15)
```

:no_entry: Development is done from the wallet backend but a few things remains untested because Jörmungandr does not support transaction from legacy UTxO yet. So the U/S is so-to-speak blocked :no_entry:
  

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
[======================>-------------------------------------------------------] 29% (4/14)
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
[=======================================>--------------------------------------] 50% (10/20)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/32">More Information</a>
</p>

# Known Issues / Debts

- :no_entry: WINDOWS EXECUTABLES :no_entry:

  Windows builds and testing is still an issue. We are able to produce
  executable for Windows but we're still working on getting them to work. We
  are currently blocked by the Nix setup. A recent upgrade of `Haskell.nix` has
  fixed several issues, and concomitantly caused a new set of issues that
  prevent us from carrying on with Windows builds. DevOps are aware of the
  issue and are providing some help.

  See also: https://github.com/input-output-hk/cardano-wallet/pull/888

- :no_entry: CERTIFICATE SIGNATURE :no_entry:

  The implementation for certificate signatures is currently only partial in
  Jörmungandr.  As the wallet is now looking into submitting delegation
  certificates to the blockchain, we need the ability to sign and serialize a
  delegation request. 

- :no_entry: SUPPORT FOR LEGACY ADDRESSES :no_entry:

  It is still not possible to submit transactions from legacy addresses in 
  Jörmungandr. Some work has been by Jörmungandr's team to support the 
  presence of `legacy_fund` in the genesis file, and we can now correctly 
  see and parse legacy UTxO declaration but they remain unusable. 

  See also: https://github.com/input-output-hk/jormungandr/issues/1005

- :warning: Previous Stake Distribution :warning:

  There's currently no way for a node client to have access to stake
  distributions of previous epochs. We have somewhat worked around it by trying
  to accomodate the lack of data by computing a performance indicator from a
  more distant past, yet it is unreliable and unsatisfactory.

  See also: https://github.com/input-output-hk/jormungandr/issues/852

- Missing `libcrypto.so.1.0.0` on some linux distributions

  see also [#923](https://github.com/input-output-hk/cardano-wallet/issues/923)
