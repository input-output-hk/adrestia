# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 50</strong>: 2019/12/09 → 2019/12/13 :ghost:
</p>

# Non-Technical Summary

The [end of the line](https://www.youtube.com/watch?v=Hdil-F6B1gk) for the
incentivized testnet!  The remaining pieces being assembled together with the
introduction of the off-chain metadata into the stake pools list. This enables
clients like Daedalus to build an awesome user experience where available stake
pools can be shown, compared and chosen based on many criterias. We are also
preparing the ground to facilitate support for Hardware devices like Ledger and
Trezor by offering "coin selection as a service" in the API. On the side, we've
added new benchmarks that are measuring HTTP requests latency on wallets of
various sizes and shape, in order to identify bottlenecks in the API and if
necessary, spend time on optimizations later. 

# Overview

## :heavy_check_mark: Completed

- Measure API and database latency for various read endpoints. The idea is to
  identify bottlenecks in the API handlers while also having clear metrics to
  refer to when it comes to "API performances". We have also turned this
  benchmark into a nightly benchmark to have regular reports, and in
  particular, include this in various release artifacts.

- Keep track of stake pool registration certificates submitted to the network
  and making it into the ledger. With this, we are able to:

  a. Reconciliate pool owners with their matching stake pools
  b. Keep track of on-chain metadata such as the pools' margin and cost

- Associate off-chain metadata from the CF registry to their corresponding stake
  pools! This is done with a bit of caching to avoid querying the registry on 
  every call (which is rather expensive request). Cache is replaced every hour.

- Fixed a few API documentation issues where stake pool ids where documented 
  as bech32 addresses. Also added a bit more details on a few fields. 

- Added a new endpoint in preparation of the hardware ledger support. This enables
  a client to use the wallet to construct an unsigned transaction by running the 
  coin selection for a given target payment. The resulting transaction can then be
  serialized and signed on a hardware device and submitted through [postExternalTransaction](https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/postExternalTransaction).

- Upgraded to Jörmungandr 0.8.0 and released two versions:
  - [v2019-12-09](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2019-12-09)
  - [v2019-12-13](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2019-12-13)

# Bug Fixes

- Apparent performance could be wrong for brief times (because of multiple sources of truth) [#1158](https://github.com/input-output-hk/cardano-wallet/issues/1158).

# User Stories

### :heavy_check_mark: (WB-25) Collect stake pool metadata

### :heavy_check_mark: (WB-18) API latency nightly benchmarks

### :heavy_check_mark: (WB-28) Coin selection as a service

### :hammer: (WB-26) Haskell cardano-node gap analysis

> **User Story**
> 
> As a wallet backend developer and a cardano-node project manager  
> I want to identify gaps and outstanding effort required to integrate the wallet backend with the haskell nodes,  
> So that I can anticipate risks and start planning the integration.  

```
[=======================================>--------------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/41">More Information</a>
</p>


### :hammer: (WB-27) Support Byron Yoroi Wallets 

> **User Story** 
>
> As a end-user owning a wallet made with Yoroi on Byron  
> I want to be able to restore my wallet in Daedalus  
> So that I am able to migrate it to a new Shelley wallet  
> And I can participate in th Jörmungandr TestNet.

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/42">More Information</a>
</p>

### :hammer: (WB-46) Byron Hardware Ledger Auxiliary Seed Generation

> **User Story**
> As an ADA stake holder  
> I want to be able to restore a mnemonic coming from a Byron hardware Ledger wallet,
> so that I can participate in the Jörmungandr TestNet.  

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/43">More Information</a>
</p>

# Known Issues / Debts

- :warning: Still working on enabling automated test execution under Wine. :warning: 
  Outstanding issues are captured in [#1115](https://github.com/input-output-hk/jormungandr/issues/1115)

- :warning: Previous Stake Distribution :warning: [#852](https://github.com/input-output-hk/jormungandr/issues/852)
