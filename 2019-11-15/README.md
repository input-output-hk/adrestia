# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 46</strong>: 2019/11/11 → 2019/11/15
</p>

# Non-Technical Summary

A very intensive week of fixes, polishing and tweaking to deliver the best
possible experience to stakeholders in the balance-check release on the
incentivized testnet.  It has been very demanding and required a great
reactivity but has also further delayed the completion of the stories about
delegation for which only few progresses have been made.  This is still a very
important milestone for us as it is the result of more than a year of hard work
to rebuild and extend the Byron wallets. It's not without disappointment that we
discovered only too late an important issue that was lurking for almost 2 years,
resurfacing from as far as cardano-sl v1.1.0! Fortunately, this is why we have
testNets before mainNet! 

# Overview

## :heavy_check_mark: Completed

- Revised usage of the database in the code to allow running multiple queries in ACID 
  transactions, making sure that any wallet-level operations are fault-tolerant and 
  won't cause any data corruption when forcefully interrupted. 

- Fixed an underflow in pool apparent performance calculation, causing the result to be
  off during the first epochs. 

- Revised the fail-over logic in the chain follower: it appeared that if the chain follower
  started with a failure, it would not backoff errors properly and simply retry every time
  immediately. 

- Adjusted the function responsible for balancing a transaction to allow balancing a
  transaction with no outputs. We encounter this type of transaction when submitting
  delegation certificates. 

- A lot of work done trying to get our integration tests to run under `wine` and in CI.
  We are almost there and still have 2 failing scenarios. 

- Revised the starting order of the Daedalus IPC channel to allow Daedalus to be notified
  as soon as possible of the backend port usage. Before, the port was only sent to Daedalus
  after Jörmungandr had fully started.

- Fixed a bug regarding the calculation of metadata for pending transaction made to 
  self. The outputs that belonged to the wallet were treated as "foreign" output until
  the transaction was discovered.

- Changed the default bech32 prefix used for addresses in the wallet backend to be 
  consistent with newer versions of Jörmungandr and the explorer.

- Solved a bug caught by the SQLite state-machine regarding the newly created table
  for storing delegation certificate: the table primary key was incorrectly declared.

- Added a `--sync-tolerance` option to the command-line to allow tweaking the server
  syncing tolerance (or said differently, the time margin for which we consider to 
  be synced with the network). Before this, a value was simply hard-coded to a specific
  time. 

- Fixed last failing unit tests on Windows. Main errors were due to network exceptions
  not being handled properly on Windows by some libraries we use. Also, there are some 
  known issues with threads in Haskell on the Windows runtime since GHC 8.2.2 which 
  demand some special work-arounds.

- Upgraded to `jormungandr@0.7.0`

- Balance-check release for the incentivized testnet [v2019-11-14](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2019-11-14)! 

- Fixed choice of derivation index for Byron addresses. It seems like Serokell had left
  another special gift for us two years ago.

## :construction: Underway

- Revision of the DaedalusIPC protocol which works intermittently on Windows. 
  The source of the issue is still quite unclear.

- Adding Docker image as a CI artifact

- Extending our Jörmungandr HTTP-Client to support fetching account state.

- Making it possible to create and submit delegation certificate to join a stake pool

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

- :warning: Daedalus IPC working intermittently on windows :warning: [#1036](https://github.com/input-output-hk/cardano-wallet/issues/1036)

- :warning: Previous Stake Distribution :warning: [#852](https://github.com/input-output-hk/jormungandr/issues/852)

- Missing `libcrypto.so.1.0.0` on some linux distributions [#923](https://github.com/input-output-hk/cardano-wallet/issues/923)
