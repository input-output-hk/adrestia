# Adrestia Weekly Report

<p align="right">
  <strong>Week 31-32</strong>: 2020/07/27 → 2020/08/06
</p>

# Project Overview

## cardano-wallet

- Finalized the integration with the first versions of SMASH (the stake pool metadata aggregation server). 

- Some various improvements and polishing regarding listing of stake pools. We needed in particular to come up with a satisfactory solution to handle ties in ranking and the lack of historical data during the first epoch of Shelley. We also installed several guards to prevent users from delegating to retiring pools. 

- Facilitate ITN rewards redemption for API clients such as Daedalus. This gives an easier way to withdraw rewards from an ITN stake address without having to go through all the hassle of restoring such wallet, moving funds to it and withdrawing rewards back to another. 

- Worked on fixing most of our nightly scenarios (benchmarks and long-running tests). In particular, we had some nightly syncing tests that were still using the Byron-only version of the wallet which ceased to work after the 29th of July. The same tests are now running on the version capable of crossing the hard fork.

- Several improvements, notably on the error handling, of the time interpreter (a component in charge of converting UTCTime to slot numbers and vice-versa, in the context of a multi-era blockchain like Cardano).


## cardano-addresses

- Re-organized the repository and split the main package into two packages. This makes the main package easier to consume by libraries authors for it does not include anymore specific dependencies only needed for constructing command-line interfaces. 

## cardano-rest

- Upgraded cardano-rest to be able to cross the Shelley hard-fork.

- Various bug fixes of issues found by partners. 

## cardano-graphql

- Integrated with the latest version of `cardano-db-sync` to also support the hard-fork. 

# Known Issues / Debts

- `cardano-rest` is still under tested and remains a fragile product which needs special attentions.

- There are known performance issues for some users of `cardano-wallet` which we have a hard time to reproduce in most cases. In particular:
  - Fees estimation and pool listing seems extremely slow in the case of a multi-wallet server.
  - Restoration is oddly slow for some big parties with large wallets, although not reproducible on various benchmarks and stress tests.

- We accumulated a good number of technical debts in `cardano-wallet` within the past months, working at a full pace for the hard-fork. We need to clear this up if we intend to keep moving forward at a reasonable pace. This includes fixing flakyness and slowness of our continuous integration setup as well as a number of code changes and architectural revisions of the code base. 

- The interoperability with cardano-cli isn't great. CIP-5 which specifies common bech32 prefixes has been merged as "draft" and we are working on a new CIP
  to specify interoperability formats of other objects manipulated by various interfaces.
