# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 42</strong>: 2019/10/13 → 2019/10/18
</p>

# Non-Technical Summary

# Overview

TODO: Non-Technical Summary

## :heavy_check_mark: Completed

- Removed `cardano-wallet-http-bridge` implementation. It was about time to get rid of this
  as it was becoming a maintenance burden costing us hours and hours of development. 

- Got the wallet cross-compiled to OSX and unit & integration tests running on OSX. Said 
  differently, OSX is now a platform supported by the wallet backend and will be added to
  the next release. Still actively working on Windows.

- Allow the server to listen on all interfaces (rather than only localhost). This is particularly
  useful to "Dockerize" the wallet server.

- Enable legacy faucet accounts in the integration setup. This was blocked by `jcli` not able
  to recognized `legacy_fund` in the genesis file, but was fixed by Jörmungandr's team in `v0.7.0-rc1`

- Provide Nix derivations for Daedalus installer, allowing Daedalus to run against current TestNet

- Review options passing to Jörmungandr to allow users to pass their own configuration. This is 
  mandatory to run against the current TestNet which now requires a list of trusted peers keys as
  a configuration.

- Wrapped-up implementation for listing stake pools from the API. The server has now a dedicated
  worker monitor stake pool activity from the blockchain and giving back details about stake pools,
  their stake and their production in a dedicated API endpoint.

- Implemented and calibatred a new coin selection algorithm which sole function is to empty a wallet,
  moving as much coins as possible to another wallet while preserving a reasonable UTxO shape at a 
  reasonable cost. 

- Added support for creating and signing transaction from legacy UTxO 

- Implemented a new endpoint to migrate all funds from a legacy 'Daedalus' wallet into a wallet using 
  a new address format.

- Implemented an endpoint to evaluate the cost of migrating a legacy wallet.

- Implemented an endpoint to allow forgetting a transaction made from a legacy wallet. 

- Added more tests to the previously introduced endpoint and command to forget a pending transaction.

- Fixed start-up issues in the launcher code to make sure that the wallet would correctly wait for
  Jörmungandr to start and not give up too early.

- Ugraded to Jörmungandr v0.7.0-rc1

## :construction: Underway

- Updating `Haskell.nix` to enable Windows build again 
- Fixing found issues on Windows (problem with locale encoding and emulation of `/dev/null` on Windows).
- Implementing API types for delegation endpoints
- Prototyping an approximate performance calculation for pool that does not require access to stake distribution of previous epochs
- Deep refactoring of the address derivation code to enable two things: future support for Yoroi legacy wallets and grouped address recognition
- Allowing sequential discovery to be made on grouped address containing a staking key

# User Stories

### :heavy_check_mark: Listing Registered Stake Pools

> Clients interested in delegating need to know from a trusted source what are
> the available stake pools. Ideally, clients want the ability to sort existing
> stake pools according to a particular metric. 

```
[==============================================================================] 100% (21/21)
```

:warning: Jörmungandr does not provide stake distribution of last epochs, so we haven't implemented any sort of performance metrics at the moment. :warning:

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/28">More Information</a>
</p>


### :no_entry: Byron Wallet Support

> This milestone will add support for legacy Byron wallets. Users will be able
> to: restore a legacy wallet; view the balance of a legacy wallet; calculate the
> cost of migrating to a new wallet; and migrate funds from a legacy wallet to a
> new wallet. 

```
[==============================================================================] 100% (15/15)
```

:warning: Development is done from the wallet backend but a few things remains untested because Jörmungandr does not support transaction from legacy UTxO yet. So the U/S is so-to-speak blocked:warning:
  

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
[------------------------------------------------------------------------------] 0% (0/14)
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
[------------------------------------------------------------------------------] 0% (0/20)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/32">More Information</a>
</p>

# Known Issues / Debts

- :warning: Windows builds and testing is still an issue. We are able to produce executable 
  for Windows but we're still working on getting them to work.

- :warning: There's currently no way for a node client to have access to stake distributions
  of previous epochs. Jörmungandr's REST API only exposes the stake distribution for the ongoing
  epoch. This makes it impossible for a client like the wallet to construct metrics like
  ranking or performance for stake pools without being online 24h/7. 
  See also: https://github.com/input-output-hk/jormungandr/issues/852

- :warning: The implementation for certificate signatures is currently only partial in Jörmungandr.
  As the wallet is now looking into submitting delegation certificates to the blockchain, we need
  the ability to sign and serialize a delegation request. 

- :warning: The absence of tooling or library to sign and verify KES/VRF signatures for non-Rust
  code makes it impossible to finalize the implementation of the stake pool metadata registry on
  GitHub. Without signatures, this registry becomes extremely weak and loses most of its benefits.
  See also: https://github.com/input-output-hk/jormungandr/issues/893)

- Missing `libcrypto.so.1.0.0` on some linux distributions, see also [#923](https://github.com/input-output-hk/cardano-wallet/issues/923)

- Unfriendly error message when an invalid tx id is provided to the CLI when forgetting transactions, see also [#922](https://github.com/input-output-hk/cardano-wallet/issues/922)

- Pre-condition too hard to satisfy in some property tests regarding ranges, see also [#917](https://github.com/input-output-hk/cardano-wallet/issues/917)
