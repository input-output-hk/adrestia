# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 42</strong>: 2019/10/13 → 2019/10/18
</p>

# Non-Technical Summary

# Overview

The team is closing the gap between the current Byron wallet implementation and the new 
Shelley one by providing a featureful API supporting both Byron and Shelley wallets at the 
same, allowing an easy migration of Byron wallets to the new Shelley format (API documentation
available [here](https://input-output-hk.github.io/cardano-wallet/api/edge/). We are also 
adding extra features to make our users' life easier by pushing more information through 
the API which now reports about things like node's tip and height, as well as network tip
and precise syncing progress of both wallets with the network and node with the network. 

In parallel we are continuing the effort on stake pools tracking and listing by
pulling information from multiple sources (blocks themselves and the node) and
combining them into a single digestable source for API clients like Daedalus.

## :heavy_check_mark: Completed

- Implemented a new database layer to store information about stake pools, including:
  - Pools productions (i.e. number of blocks produced over many epochs) 
  - Stake distribution (only over available epochs however, when the wallet is online)
  This allow for efficiently storing and manipulating stake pool data issued from following
  the chain. The code is completely separated from the wallet core in such way that it 
  doesn't interfer with the wallet functionality. It's so-to-speak, a secondary service
  running alongside wallets.

- Implemented logic to fetch metrics about stake pools from different data sources, making 
  sure to properly deal with concurrency issues and synchronization of the sources. This is
  still under testing.

- Implemented an endpoint to retrieve network and node information from the API. Clients have
  now access to the underlying node and network tip, as well as the local and remote chain height.

- Implemented wallet and transaction management API endpoints for Byron wallets which can now
  be restored, listed, updated, deleted and for which the transaction history is available. 

- Implemented a new endpoint to forget pending transactions, allowing clients to unlock UTxOs
  being locked up in a pending transactions for too long. The new wallet backend does not have
  any concept of scheduler so, a transaction might remain pending forever and the decision to 
  release the funds it uses is left to API clients.

- Reviewed exception handling in wallet workers to better react to asynchronous exceptions
  (i.e. a thread being killed by a parent or interrupted by a user) in order to avoid logging
  error messages in cases where the a wallet is simply interrupted. 

- Reviewed logging setup as we discovered that the logging library would actually dead-lock
  under certain circumpstances. We've therefore adopted a different style for claiming and 
  releasing logging resources in order to prevent possible deadlocks and resource leaks.

- More accurate restoration progress and chain synchronization reporting. We now report 
  restoration progresses based on where the node is expected to be (a.k.a the network tip)
  and not based on where the node currently is. This is crucial to correctly understand 
  where wallets are on the chain.

- Battled with the continuous integration server trying to figure out why some tests would 
  only fail in CI and not locally. Race conditions from running integration tests in parallel 
  and, with code coverage seems to be the root of the issues. Most tests are isolated enough
  to be run in parallel but turning on coverage report with the Haskell tool chain generates
  some artifacts which conflicts between parallel builds. 

- Released version [v2019-10-16](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2019-10-16) 
  which has partial support for Byron wallets as well as a proper chain follower which can
  accomodate chain switches. 

- Updated Jörmungandr's integration to 0.6.1.

## :construction: Underway

- Improvements on the launcher and CLI interfaces to allow the wallet server to:

  - Give more control to users on Jörmungandr's configuration, allowing an easy
    launch of the wallet and Jörmungandr on TestNet.

  - Enable the wallet to listen on all interfaces (open the gates to dockerization)

- Ad-hoc coin selection algorithm to construct a serie of transactions in order to 
  efficiently migrate a Byron wallet. The algorithm roughly preserves a 1:1 ratio
  between existing UTxO and the one that'll be created on the new wallet, while also
  making sure to clean up small coins (a.k.a dust) along the way.

- Enabled faucet Byron wallets in integration tests, although this is currently blocked
  by a bug in `jcli` (see notes below).

- Connect all pieces for stake pool listing and following (database layer, network layer
  and logic layer), with extra testing.

- Getting integration test scenarios and unit tests running on Windows (or, Wine).


# User Stories

### :heavy_check_mark: Forget Pending Transactions

> As an API client, I want to be able to properly handle a transaction that has
> timed out and/or is stuck in a pending state, so that I am to spend locked
> UTxOs for wallet users.

```
[==============================================================================]  100% (3/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/31">More Information</a>
</p>


### :hammer: Listing Registered Stake Pools

> Clients interested in delegating need to know from a trusted source what are
> the available stake pools. Ideally, clients want the ability to sort existing
> stake pools according to a particular metric. 

```
[=======================================================================>------] 90% (19/21)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/28">More Information</a>
</p>


### :hammer: Byron Wallet Support

> This milestone will add support for legacy Byron wallets. Users will be able
> to: restore a legacy wallet; view the balance of a legacy wallet; calculate the
> cost of migrating to a new wallet; and migrate funds from a legacy wallet to a
> new wallet. 

```
[======================================================================>-------]  87% (13/15)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/29">More Information</a>
</p>

# Known Issues / Debts

- :warning: We now produce Windows and OSX executables which aren't crashing. However, we 
  are still unable to know whether our full test suite run on any of these systems.

- :warning: There's a bug with `jcli` which prevents us from generating a genesis block file 
  if the genesis file contains `legacy_fund`. This is an impediment to e2e testing of Byron
  wallets for we can't fully test migration of existing legacy wallets to new wallets. The 
  Rust team is confident that it's probably a small fix but someone needs to be assigned to
  look at it.

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
