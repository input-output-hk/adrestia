# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 32</strong>: 2019/08/05 →  2019/08/09
</p>

# Metrics

| Name            | Value                                       | Description                                                    |
| ---             | ---                                         | ---                                                            |
| Rolling Average | 16.7 days (+27% :chart_with_upwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 16.14 (+0%)                                 | Average number of points the team can handle each week         |

# Non-Technical Summary

Now fully engaged into the support for the random derivation scheme, we've done
some rather big re-design and code changes in order to accomodate the core
engine to work with random or sequential derivation. We have also wrapped up
some of the remaining work regarding filtering and sorting for the transaction
API.

In addition, the team is currently reviewing a bit its development process in
order to be more efficient and gain in both productivity and code quality. An
updated process will be in effect soon. 

# Overview 

## :heavy_check_mark: Completed

- Parameterized the wallet layer over an underlying key format allowing to 
  define wallet layers working with random and sequential derivation in _theory_.
  We've also implemented most of the primitives to perform random derivation, and
  random address discovery and are now looking into implementing the corresponding
  wallet abstractions with these primitives.

- Wrapped up remaining work on listing transactions from the API / command-line, in 
  particular with regards to filtering and sorting using time ranges. Written integration
  tests to ensure a correct behavior of the API for edge and standard cases.

- Upgraded to Jörmungandr v0.3.2

- Implemented compatibility abstraction for transforming address public keys into
  Byron legacy addresses in the `http-bridge` target.

- Working a few development process evolutions in order to make the team more autonomous
  and capable of tackling various user stories in parallel. Among these changes: 
  - A better approach to capture and prioritize user requirements.
  - User Story ownership spread across the team.
  - New repository to discuss architectural decisions and technical solutions prior to
    working on user stories.
  - A 'recovery week' every 2 sprints to do house-keeping and tackle technical debts.
  - More frequent small voice chat, rather than long slack threads

## :construction: Underway

- Serialization of keys to keystore for random derivation keys

- Wallet layer higher-level abstractions for random derivation scheme (address recognition,
  change generation etc ..) using available low-level primitives.

# User Stories 

### :heavy_check_mark: Finalize Transaction Endpoints

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
[===========================================>...................................] 56% (20/36)
```

# Known Issues / Debts

- N/A

