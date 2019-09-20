# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 38</strong>: 2019/09/16 → 2019/09/20
</p>

# Non-Technical Summary

After the re-structuring of the database schema during the previous weeks, we have 
now focused on adjusting the internal implementation of the database layer to make
sure to store multiple wallet checkpoints as we follow a chain. We are now working
on the final step: allowing arbitrary rollbacks to a previous checkpoints. 

On the side, we continue with improving our testing, following closely 
Jörmungandr's releases and integrating them as they are published. We are reworking
several parts of the code to either get it more reliable, or to simplify the
manipulation of some data-structures. 

# Overview

## :heavy_check_mark: Completed

- The DB now keeps track of multiple wallet checkpoints. We used to store only
  a single checkpoint (a.k.a wallet state) but in order to support rollback, we
  need to efficiently store many of them. This induced many careful changes in
  the db implementation: 

    - Making sure UTxOs are discarded when used, but remain accessible for a 
      quick recovery. We wanted to avoid storing a copy of each UTxO per 
      checkpoint to avoid completely bloating the database (we may have as 
      many as 2000 checkpoints in the database, with a UTxO containing ~5k 
      transactions -- like exchanges may have, we can't really affort cloning
      all of them). Yet, sharing UTxOs between checkpoints while making sure
      rollbacks are working correctly was quite a challenge.

    - Reviewing how transaction metadata are stored such that we can easily 
      revert a status change.

    - Propagating changes to the internal address discovery states, for both
      random and sequential wallets.

    - Adapt how UTxO and transaction history are fetched from the DB. 

  In the end, the top-level interface hasn't changed, so it's nice to see 
  existing testing in place as a safe-guard, especially the state-machine testing
  hammering the database and finding issues for us. 

- Pruned old checkpoints from the database to keep it under a reasonnable size.
  We now that the chain can't rollback beyond a certain number `k` of blocks, so 
  there's no need to keep checkpoints that are older than `k`. So periodically, we
  make sure that the database gets pruned from old data. In order to accomplish 
  that, we had to store protocol parameters in the database, which would have been
  needed anyway once we'd get into applying protocol updates. So it's a double-win.
  
- Improved error handling on wallet workers. Workers won't die silently anymore but
  leave a clear error log entry.

- Reviewed some integration tests and replace unreliable delays with
  a retry/timeout approach. Delays are really machine-specifics and
  should be avoided as much as possible.

- Fix builds on Windows machine.

- Reviewed Jörmungandr command-line interface to better match genesis/praos
  interface.

## :construction: Underway

- Using a linear slot identifier within the wallet layer (instead of compound 
  identifier as slotNumber + epochNumber). At the edge of the system, we still
  perform a conversion from and to linear, but it greatly simplifies a lot of
  the internal manipulation as the slotting arithmetic goes away.

- Bumping Jörmungandr to latest version and allowed modifying its version directly
  from the wallet repository (at the moment, this goes through the IOHK nix
  machinery which requires the revision to be changed on `iohk-nix` to update
  CI everywhere, which is quite unpractical).

- Improving testing of UTxO in the database state-machine engine. With rollbacks,
  we may end up in tricky situations for which we would like a deep testing on
  the state-machine tests. So, we are extending some of our generators and 
  required scenarios to better observe database changes through arbitrary commands.

- Reworking chain length tracking and read it from the binary block header instead
  of computing it in the wallet layer. This information is provided by nodes for
  all block header, so we better get it from the source and avoid having two sources
  of truth.

- Finally implementing rolling back the database now that we're done with all the
  pre-requisite regarding schema changes and storage of multiple checkpoints. 


# User Stories

### :hammer: Support Rollbacks

> In a standard setup, it is very likely for a core node to roll-back (i.e.
> rewind the chain to a previous point in time). This means that the wallet
> backend must be able to correctly keep track of blocks, rolling backwards
> when needed and not only append blocks to an existing chain. Doing so,
> transactions that could have been inserted in recent blocks might become
> pending again, and balances may change to reflect the chain after a rollback.
> Beside, we do not want roll back to have a significant impact on the software
> usability. Hence, most features should remain available during rollbacks.
> Submitting transactions may be however forbidden during rollbacks.

```
[========================================================>--------------------]  73% (29/40)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/25">More Information</a>
</p>

### :hammer: Listing Registered Stake Pools

> Clients interested in delegating need to know from a trusted source what are
> the available stake pools. Ideally, clients want the ability to sort existing
> stake pools according to a particular metric. 

```
[=========>-------------------------------------------------------------------]  10% (2/21)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/28">More Information</a>
</p>


# Known Issues / Debts

- N/A
