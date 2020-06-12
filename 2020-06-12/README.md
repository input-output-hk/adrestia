# Adrestia Weekly Report

<p align="right">
  <strong>Week 24</strong>: 2020/06/08 → 2020/06/12
</p>

# Project Overview

## ⛅ Forecast

### 2020/06/16

- (ADP-291) Document error conditions of API endpoints
- (ADP-311) Make stakepool metrics available through the API
- (ADP-302) Make reward account balance available through the API

### 2020/06/23

- (ADP-284) Redeem ITN rewards to mainnet wallet
- (ADP-287) Reward account as possible input for coin selection
- (ADP-333) Hardfork detection 

# Past Week Overview

#### cardano-wallet | latest = [v2020-06-05](https://github.com/input-output-hk/cardano-wallet/releases/v2020-06-05)

- Finally pulled off a release which contains 9 release artifacts: 
  - cardano-wallet-itn
  - cardano-wallet-byron
  - cardano-wallet-shelley
  On all three platforms (Linux, MacOS, Windows) as well as with corresponding docker images. We had to drop our haddock 
  documentation export (which is a small loss) in order to get CI able to run and build all these in an acceptable time.

- Worked on getting an integration test cluster ready running a BFT leader and stake pools. We run (and keep running) into
  networking issues, in particular in CI which makes the cluster very clunky at the moment. It however allows us to move on
  with integration tests of various API scenarios.

- Join/Quit stake pools endpoints now available on cardano-wallet-shelley to delegate funds from cardano-wallet. 

- Delegation fee estimation endpoint also available on cardano-wallet-shelley

- Reworked stake pool model in the API so that we can serve both Jörmungandr & cardano-node stake pools through cardano-wallet.
  The model have some subtle differences (cardano-node gives us non-myopic member rewards, whereas we used the desirability 
  in Jörmungandr; we also do not have access to the apparent performance with cardano-node, at least yet). 

- Get final user-facing encoding done at the API level for Shelley (so that Byron addresses are served Base58-encoded, whereas
  Shelley ones are bech32). Right now, everything is hexadecimal to match what's produced by cardano-cli. 

- Drafted initial work for reporting correct reward account balance in cardano-wallet-shelley. 


#### cardano-graphql | latest = [1.0.0-rc10](https://github.com/input-output-hk/cardano-graphql/releases/tag/v1.0.0-rc.10)

- ø

#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = N/A

- ø

#### cardano-coin-selection | latest = [1.0.1](https://github.com/input-output-hk/cardano-graphql/releases/1.0.1)

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- ø

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- ø

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Small bug fix regarding auto-detection of bech32 encoding which would fail in some cases.

# Known Issues / Debts

- ø
