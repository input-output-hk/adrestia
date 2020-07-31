Migrating From SL
=================

This section provides practical tips for migrating from SL.

## I am using _explorer_ from _cardano-sl_, what should I do?

The API from the old explorer has been ported identically to [cardano-submit-api](https://github.com/input-output-hk/cardano-rest). This component is part of [cardano-rest](https://github.com/input-output-hk/cardano-rest). Source code dealing with the _explorer_ API from _cardano-sl_ should be straightforward to migrate. See the installation instructions and documentation available on [cardano-rest](https://github.com/input-output-hk/cardano-rest) for more details.

The setup is slightly different. With _cardano-sl_, the explorer is mounted directly on the core node as one monolith, and can be turned on and off. These components have been split off one another and use an extra middleware to communicate. The "infrastructure" is slightly more complex, but enables greater flexibility and robustness.

> **INFORMATION**: It is possible to automatically migrate an existing blockchain database from _cardano-sl_ into its new format compatible with _cardano-node_. For this, have a look at the [db-converter][db-converter] and in particular, the `convert` command:

```
$ db-converter convert --help
Usage: db-converter convert --epochDir STRING --dbDir STRING --epochSlots WORD64

Available options:
  -h,--help                Show this help text
  --epochDir STRING        Path to the directory containing old epoch files
  --dbDir STRING           Path to the new database directory
  --epochSlots WORD64      Slots per epoch
```

> **INFORMATION**: On Byron, the number of slots per epoch is fixed to `21600`.

This can save you an hour of time downloading the blockchain from the network!

Build it with [Nix](https://nixos.org/download.html) as follows:

```
$ git clone https://github.com/input-output-hk/ouroboros-network
$ cd ouroboros-network
$ nix-build -A haskellPackages.ouroboros-consensus-byron.components.exes.db-converter -o db-converter
$ ./db-converter/bin/db-converter --help
```

[db-converter]: https://github.com/input-output-hk/ouroboros-network/tree/master/ouroboros-consensus-byron

## I am using _wallet V1_ from _cardano-sl_, what should I do?

A new `V2` API is now available on [cardano-wallet](https://github.com/input-output-hk/cardano-wallet). In a similar fashion to _cardano-rest_, this component used to be mounted directly on the core node, but it is now an independent process. The _cardano-wallet_ is nothing more than a webserver that connects to a local core node through a domain socket.

There are some variations between the `V2` and `V1` APIs, but both APIs follow a very similar approach and are still very resource-centric (a.k.a ReST). _cardano-wallet_ is a large component that covers multiple networks and node backends. If you're coming from sl, you're most likely interested in _cardano-wallet-byron_ at the moment, since it is integrated with a Byron-reboot OBFT _cardano-node_. Follow the setup instructions on _cardano-wallet_'s README and Wiki.

The API documentation is available in [API References](api-references.md). Note that only the _Legacy_ sub-part of the API matters at this stage. The _Shelley_ part is not available on the Byron integration but can be looked up as a reference for future integration.

> **WARNING**: _cardano-sl_ had the concept of "accounts" inside wallets. This concepts is now entirely gone. If you need multiple accounts, use multiple wallets.

## I am using _wallet V0_ from _cardano-sl_, what should I do?

If you use wallet V0, it will be harder to migrate to _cardano-wallet_. The gaps between `V0` and `V2` are larger, but everything from the previous section applies.

More questions? Have a look at the [FAQ](faq.md) or else, reach out on [Github](https://github.com/input-output-hk/adrestia/issues/new/choose)!
