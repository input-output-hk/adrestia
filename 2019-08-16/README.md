# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 33</strong>: 2019/08/12 →  2019/08/16
</p>

# Metrics

| Name            | Value                                        | Description                                                    |
| ---             | ---                                          | ---                                                            |
| Rolling Average | 8.9 days (-54% :chart_with_downwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 16.14 (+0%)                                  | Average number of points the team can handle each week         |

# Non-Technical Summary

Wrapping up the support for random derivation scheme. The team has implemented
most of the building blocks which will allow us to support a wide variety of
features for the legacy wallets. An API extension will soon arrive and make
use of these building blocks to provide a set of functionality to deal with
legacy wallets.
 
# Overview 

## :heavy_check_mark: Completed

- Small improvements and updates on our CI servers to have better reporting 
  on build failures and updated nix packages with latest IOHK tooling available.

- Implement address recognition for random wallets, basically answering the question
  "is this address ours". 

- Add building block to compute private key corresponding to a known address for the
  sequential scheme. This is basically necessary to create transactions.  

- Clarify slotting arithmetic, review module API and improve readability of existing 
  code relying on slotting arithmetic. 

- Fixed bug with Jörmungandr's account addresses (currently unused in the wallet 
  backend but incorrectly implemented). 

- Extend database schemas to store random wallets internal states.

## :construction: Underway

- Generate change addresses for random wallets

- Finalize testing on "transaction list" endpoint


# User Stories 

### :hammer: Primitives for random derivation (legacy) support

:timer_clock: Estimated end date: Aug 11

> Current wallets implementations in the wild use a different derivation scheme
> than the one we initially embedded in the new wallet backend. Yet, the new wallet
> will eventually need to support all or a subset of the features currently supported
> by the wallets in use. In a first towards supporting these features, we need to
> build the cryptographic and low-level primitives which will allow us to perform
> key management, key derivation and address discover following rules stated by the
> legacy scheme.

```
[======================================================>........................] 69% (25/36)
```

# Known Issues / Debts

- N/A
