# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 47</strong>: 2019/11/18 → 2019/11/22
</p>

# Non-Technical Summary

Moving quite fast and in many directions over the past two weeks caused a few 
small bugs that escaped our testing and internal QA. After fixing those, we are
now back on a more stable track for this final run to implement the remaining 
features regarding delegation. Doing so, we also make sure to improve the overall
monitoring and usability of the software to ease future debugging and support. 

Next week is going to be the week where all the pieces finally fit together to
give birth to a new era of delegation and decentralization. Pretty exciting.


# Overview

## :heavy_check_mark: Completed

- Implemented API endpoints and partially implemented wallet engine core
  functions for joining and quitting a stake pool. We are missing some crucial
  revisions of our binary serializers for transactions to finalize this.

- Revised type used for storing epoch number as a type-level mitigation for the
  overflow bug discovered last week. 

- Added a golden regression test for Byron addresses carrying non-hardened
  derivation paths in their payload.

- Fixed Jörmungandr http-client error handling and make a clear distinction
  between 404 and 400 (the former is benign, the latter is more serious).
  Revised automated integration tests in this area to highlight all possible
  scenarios.

- Extended version number and version logs to also now include a full git
  revision! This makes it really clear to identify what features are included
  in a particular executable.

- Released a new incremental version `2019-11-18` containing some bug fixes and
  small improvement.

- Add Docker images as a release artifact to provide yet an extra solution for 
  some linux users missing old crypto libraries (lib-crypto-1.0.0). 

- Extended our Jörmungandr HTTP client to also support fetching the state of a 
  reward account.

- Removed some obsolete tests regarding generation of Jörmungandr configuration
  file.

## :construction: Underway

- Enabling Jörmungandr `account` and `multisig` addresses to be used in transaction output
- Jörmungandr binary serializers revision, in particular regarding transaction 
- Allowing increasing or decreasing logging level per component (api vs wallet worker vs database)
- Additional tests regarding Jörmungandr API endpoints covering more "negative" scenarios
- Extend blocks to also contain delegation certificates
- Fetch metadata from the stake pool registry

# Bug Fixes

- :bug: Word16 overflow in Jörmungandr binary (SlotId) [#1025](https://github.com/input-output-hk/cardano-wallet/issues/1025)
- :bug: Recurring `Recoverable error following the chain` in the chain follower [#1049](https://github.com/input-output-hk/cardano-wallet/issues/1049)
- :bug: Byron addresses have derivation indexes that are not only hardened. [#1041](https://github.com/input-output-hk/cardano-wallet/issues/1041)
- :bug: Daedalus IPC working intermittently on windows [#1036](https://github.com/input-output-hk/cardano-wallet/issues/1036)
- :bug: Chain follower does not backoff on start-up errors [#1027](https://github.com/input-output-hk/cardano-wallet/issues/1027)

# User Stories

### :heavy_check_mark: Bug Fixes / Windows Compatibility

> At the moment, our CI only produces binary artifacts for linux machines yet,
> most are using Windows and OSX machines so we ought to be able to produce
> executables for these targets too. Ideally, our test suites should also run on
> both platform to ensure that code produced works as expected on these
> platforms.

```
[=============================================================================>] 99%
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/30">More Information</a>
</p>

:warning: Some recent modifications of `haskell.nix` disabled automation of Windows tests under wine. We need this back. :warning:


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
[==============================================================>---------------] 79% (11/14)
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

- :warning: Haskell.nix updates preventing automatic tests executions under Wine (for Windows) :warning: [#316](https://github.com/input-output-hk/haskell.nix/pull/316)

- :warning: Previous Stake Distribution :warning: [#852](https://github.com/input-output-hk/jormungandr/issues/852)
