## API reference

### Components

| id                     | name                                                               |
|------------------------|--------------------------------------------------------------------|
| cardano\-wallet        | https://input\-output\-hk\.github\.io/cardano\-wallet/edge         |
| cardano\-submit\-api   | https://input\-output\-hk\.github\.io/cardano\-rest/submit\-api/   |
| cardano\-explorer\-api | https://input\-output\-hk\.github\.io/cardano\-rest/explorer\-api/ |
| cardano\-graphql       | Available soon                                                     |

**About cardano-wallet**

Cardano-wallet comes with a command-line interface (CLI) that can be used as a quick alternative to cURL or wget to interact with a server running on localhost. Every endpoint of the API is mapped to a corresponding command that often offers a better user experience than directly interacting with the API as a human (API are for programs, command-lines are for humans).

For example, restoring a wallet goes normally through POST /byron-wallets, or can be done interactively with:

`$ cardano-wallet wallet create MyWallet`

The CLI also provides some useful helpers, such as a command to generate mnemonic sentences, or doing key derivation. For more details, see the wallet command-line user manual.

### Libraries

| Library                  | Haskell                                                                 | JavaScript                               |
|--------------------------|-------------------------------------------------------------------------|------------------------------------------|
| cardano\-addresses       | https://input\-output\-hk\.github\.io/cardano\-addresses/haddock/       | Soon available\.                         |
| cardano\-transactions    | https://input\-output\-hk\.github\.io/cardano\-transactions/haddock/    | Soon available\.                         |
| cardano\-coin\-selection | https://input\-output\-hk\.github\.io/cardano\-coin\-selection/haddock/ | Soon available\.                         |
| bech32                   | https://input\-output\-hk\.github\.io/bech32/haddock/                   | See https://github\.com/bitcoinjs/bech32 |

**About cardano-transactions**

In addition to the low-level library, cardano-transactions also provides a CLI (cardano-tx) to construct transactions directly in the terminal. Check out the repository's documentation and examples to see example usage.