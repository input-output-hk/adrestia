# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 30</strong>: 2019/07/21 →  2019/07/26
</p>

# Metrics

| Name            | Value                                         | Description                                                    |
| ---             | ---                                           | ---                                                            |
| Rolling Average | 13.4 days (-55% :chart_with_downwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 16.14 (-15% :chart_with_downwards_trend:)     | Average number of points the team can handle each week         |

# Non-Technical Summary

# Overview 

Released a new version of the wallet backend with support for two different
backend targets: `cardano-http-bridge` and `Jörmungandr`. Meanwhile, the team
continues the effort to make the API version 2 more complete, as well as 
extending the engine to support the random address derivation scheme currently
used by Daedalus in the Byron era. This will allow current wallets to be loaded
and manipulated in the new wallet backend, in order to facilitate migration from
the old to the new format. 


## :heavy_check_mark: Completed

- Implemented endpoint and command-line command to list transaction. As
  mentioned in the "Known Issues" last week, there was some complications
  regarding inputs resolution. Implementing this requires a substantial amount
  of efforts and some rather big design decisions. We have therefore postponed
  the effort and are for now, considering resolved inputs only in the context
  of outgoing transactions (for which we do fully know inputs _most of the
  time_).

- Released [v2019-07-24](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2019-07-24)
  with support for Jörmungandr, fee estimation, and UTxO distribution statistics. 
  Also comes with richer errors that are more user-friendly in the command-line.

- Prepared ground for (legacy) random derivation support. Separating common 
  functionalities from the ones specific to the sequential derivation scheme. 

- Changed API for 'list transaction' to use a query parameter instead of a 
  `Range` header. This decisions is delaying a bit the completion of the feature
  for a greater design, simpler to use for users of the API.

- Explored and fully documented an example of networking layer using the new
  Haskell mini-protocols. This exploration will eventually be turned into a 
  real implementation to connect the wallet backend into a Shelley Haskell node
  in pbft mode. 


## :construction: Underway

- Turn integration tests into a shared library instead of using symbolic links.
  It seems that symbolic links break a few tools (editors or code introspection).

- Key generation and address derivation for random scheme.

- Upgrade Jörmungandr support to `v0.3.1`

- Wrap-up endpoint to fetch transaction history.


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
[===>...........................................................................] 5% (2/36)
```

# Known Issues / Debts

- N/A

