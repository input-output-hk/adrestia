# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 12</strong>: 2019/03/18 →  2019/03/22
</p>


# Non-Technical Summary

Following our new agile development process (a.k.a eXtreme Programming), we've
succesfully published a first "pre-release" version of our new wallet backend.
From a user perspective, this is quite poor in terms of features (hence the
"pre-release"), but the internals are putting together a lot of the primitives 
we've developped during the previous weeks.

Code-wise, we've started integration work with testnet & mainnet to make sure
the various low-level building blocks we have are nicely fitting together.
Doing so, we've restored a wallet using a sequential address scheme à la BIP-44
(a.k.a Icarus' address style) with tremendous improvements (an order of
magnitude) in memory allocation and time compared to the current legacy
implementation.  We've started to work on translating our API specification
document into concrete Haskell types to later give birth to both a wallet
backend web server and a command-line interface to interact with both Cardano
random (current Daedalus) and sequential (Yoroi / Icarus) wallets!


# Overview 

- Finalized testing setup and translation of API specification into Haskell types.
  We do currently test our API representation in three different ways:
    - We validate that every `ToJSON` instances for types returned by the API matches the 
      Swagger representation described in the specification. 

    - We validate that all paths & methods that appear in our Haskell API actually exist
      and match the specification.

    - We do have generated golden tests for JSON representations of various types appearing
      in the API, this to prevent breaking changes from sneaking through the API without us
      noticing.

- Ported the integration tests framework from the legacy wallet backend code to prepare
  testing against the wallet server API, making all sort of requests while being connected
  to a local cluster of nodes. On that area, we're trying to have the Rust http bridge 
  connected to a custom / local cluster rather than a remote relay. This will allow us
  to use faucet wallets to make arbitrary transaction and get more integration testing done
  automatically. Not there yet but coming soon.

- The MVP launcher has been finalized and is able to launch and monitor arbitrary commands
  in separate processes while "linking" them together so that, if one dies, they all dies.
  It forwards stdout & stderr to the parent process so that all logs are available from the
  launcher.

- We've connected our various layers together and started experimenting restoring a wallet  
  from our launcher cli, connected to mainnet via the http bridge. Results are encouraging
  and blazing fast :rocket:. 

- Algo got to make our first release automatically from our continuous delivery pipeline.
  The release does little in terms of functionalities but it demonstrates how everything
  plays nicely together from the developement to the CI. 

- Also spent quite some time during the week on adding extra testing on various layers and
  fixing little technical debts like naming and folder organization.  


# User Stories 

### :heavy_check_mark: Setup new cardano-wallet repostiory & CI

> **Summary**
>
> We have a new fresh repository with a working CI that allow us to implement
> our development process and iterate quickly on our various development task.

```
[===============================================================================] 100% (10/10)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099748">More information</a>
</p>


### :heavy_check_mark: Basic Launcher 

> **Summary**
>
> We want to have a basic launcher tool that help us spawn and start both the
> http bridge and the cardano wallet server, and make sure they are both
> up-and-running. If one of them crashes, the launcher crashes the other.

```
[===============================================================================] 100% (8/8)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099756">More information</a>
</p>


### :heavy_check_mark: Receive & Process Blocks (from 'cardano-http-bridge')

> **Summary**
> 
> We are wired to the cardano-http-bridge and are able to receive next blocks
> from the network and be in sync with a given network (mainnet or testnet).
> The bridge is still in the Byron Era and therefore, this is only a temporary
> solution to get something working.

```
[===============================================================================] 100% (16/16)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4099750">More information</a>
</p>

### :hammer: Wallet Layer Integration

> We have created various layers and primitives during the last past weeks, so
> it's now time to connect the pieces together and come up with a "deliverable"
> that can actually do something. For this first iteration, we are aiming for
> something simple and want a basic wallet that fetches blocks from the
> network, apply them, and outputs its current state.

```
[======================================================>........................] 69% (28/36)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4141219">More Information</a>
</p>


# Known Issues / Debts

#### Poor README

Our README is quite poor in information and it would be worth adding some
basics stuff to it. That's a point Johannes already raised on the legacy
repository actually. We could add at least:

- Basic Overview / Goal
- Build & Tests instructions
- A link to the wiki
- Link to the generated Haddock documentation
- Link to the API documentation

#### Areas missing testing:

| Module                                     | Comments             | 
| ---                                        | ---                                                                                                                                                     |
| `Cardano.DBLayer` & `Cardano.DBLayer.MVar` | - Pretty much all function <br/> -`readCheckpoints` in particular _(tested manually during profiling)_                                                  |
| `Cardano.NetworkLayer`                     | -`listen` _(tested manually during profiling)_                                                                                                          |
| `Cardano.NetworkLayer.HttpBridge`          | - Error cases from `convertError`                                                                                                                       |
| `Cardano.Wallet`                           | - Tracking of pending transactions <br/> - Wallet metadata manipulation <br/> -`currentTip` _(tested manually during profiling)_                        |
| `Cardano.Wallet.AddressDerivation`         | - Overflow on address indexes                                                                                                                           |
| `Cardano.Wallet.AddressDiscovery`          | - Overflow on address indexes during pool extension <br/> - `IsOurs` & `isOurs`                                                                         |
| `Cardano.Wallet.Binary`                    | - Decoding EBB _(discarded by network layer)_ <br/> - Invalid constructors in block representations <br/> - Decoding redeem addresses & witnesses _(?)_ |
| `Cardano.Wallet.Binary.Packfile`           | - Some error paths (`VersionTooOld` & `BlobDecodeError` with unconsumed data)                                                                           |
| `Cardano.Wallet.Mnemonic`                  | - Error cases in `mkMnemonic` <br/> - Error cases in `genEntropy`                                                                                       |
| `Cardano.Wallet.Primitive`                 | - Arithmetic overflow on `SlotId`                                                                                                                       |


#### Unused code 

| Module                            | Comments                                                                     |
| ---                               | ---                                                                          |
| `Cardano.Wallet.AddressDiscovery` | - Manual semigroup instance on `AddressPool`                                 | 
| `Cardano.WalletLayer`             | - Debug `printInfo` function in the implementation of `watchWallet`          |
| `Servant.Extra.ContentTypes`      | - `WithHash` & `Hash "Blockheader"` in the `Cardano.NetworkLayer.HttpBridge` | 
