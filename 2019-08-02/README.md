# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 31</strong>: 2019/07/29 →  2019/08/02
</p>

# Metrics

| Name            | Value                                        | Description                                                    |
| ---             | ---                                          | ---                                                            |
| Rolling Average | 13.1 days (-3% :chart_with_downwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 16.14 (+0%)                                  | Average number of points the team can handle each week         |

# Non-Technical Summary

# Overview 

Half of the team was on holidays this week, so work is going a bit slower than
usual. Also, we had some unexpected trouble with a 'double upgrade' to perform
on our integrated components:

- Upgrading our integration layer for Jörmungandr to work with its latest
  version
- Adjusting the `cardano-http-bridge` to work with the new fresh testnet
  recently deployed

Meanwhile, the team has made great progress in (re-)implementing the necessary
primitives for managing legacy wallets using a random derivation address
scheme. With these primitives, we'll now be able to implement higher-level
functionality and eventually, make random wallets available in the new wallet
backend.

## :heavy_check_mark: Completed

- Upgraded Jörmungandr integration to work with latest version of Jörmungandr
  (`v0.3.1`).  This had some unexpected complications as, since `v0.3.0`,
  Jörmungandr has changed the way transaction ids are computed and now requires
  keeping track of witnesses alongside inputs and outputs. 

- Updated cardano-http-bridge to work with the new `testnet` recently reset and
  deployed by IOHK. This had quite an impact (2 to 3 man-day) as it also broke
  our CI and prevented developers from merging and carrying on with their work.

- (re)Implemented cryptographic primitives for random address derivation:
  allowing to derive new child keys from a root private keys and, encrypting /
  decrypting derivation path into the address itself, using the legacy format.

- Replaced code shared via symbolic links by a dedicated shared library.
  Cleaner and, incidentally re-enabled a few Haskell tools to work nicely with
  the codebase.

- Completed necessary slotting arithmetic to convert back-and-forth between
  slots and UTCTime. This was necessary in order to complete the
  'listTransactions' API and allow filtering transaction by date of insertion
  into the ledger.

## :construction: Underway

- Wallet layer capabilities regarding address discovery and derivation

- Parameterizing wallet layer over the a 'key' type to allow different sort of
  keys to be used in a wallet layer (and therefore, allowing the wallet layer
  to work with either legacy or new format).

- Wrapping up 'listTransactions' endpoint

# User Stories 

### :heavy_check_mark: Bugs & Debts - Sprint 29-30 (1/1)

### :hammer: Finalize Transaction Endpoints

:timer_clock: Estimated end date: Jul 19

> The current / new API exposed by the wallet backend isn't yet fully implemented. 
> As Daedalus is now starting to integrate with this new API, we ought to complete
> the remaining endpoints with a lower priority that were left out the initial releases.

```
[======================================================================>........] 89% (17/19)
```

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
[=========================>.....................................................] 33% (12/36)
```

# Known Issues / Debts

- N/A

