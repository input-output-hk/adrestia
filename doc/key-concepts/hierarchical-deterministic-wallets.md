HD Wallets
==========

## Recovery Phrases

### Motivation

Recovery phrases (or backup, or seed phrases) are unique and randomly generated sets of 12 words that enable the user to recover their wallet at anytime. 

Seed phrases map to binary data that in turns generates the wallet's private key. Since binary data would be impossible to memorize by a human, programmers use easy-to-read, understandable language to create binary seeds using a simple dictionary of known words. This is available in multiple languages.

### Encoding

The process describing the encoding of recovery phrases is described in [BIP-0039](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki), in the "Generating the mnemonic" section. Below is a reformulation of this specification.

We call _Entropy_ an arbitrary sequence of bytes that has been generated through high quality randomization methods. The allowed size of _Entropy_ is 96-256 bits, and is necessarily a multiple of 32 bits (4 bytes). 

A checksum is appended to the initial entropy by taking the first `ENT / 32` bits of the `SHA256` hash of it, where `ENT` designates the _Entropy_ size in bits. 

Then, the concatenated result is split into groups of 11 bits, each encoding a number from 0 to 2047 serving as an index into a known dictionary (see below).

| Sentence Length | Entropy Size        | Checksum Size |
| ------------    | ------------------- | ------        |
| 9 words         | 96  bits (12 bytes) | 3 bits        |
| 12 words        | 128 bits (16 bytes) | 4 bits        |
| 15 words        | 160 bits (20 bytes) | 5 bits        |
| 18 words        | 192 bits (24 bytes) | 6 bits        |
| 21 words        | 224 bits (28 bytes) | 7 bits        |
| 24 words        | 256 bits (32 bytes) | 8 bits        |

### Dictionaries

Cardano uses the same dictionaries as defined in [BIP-0039](https://github.com/bitcoin/bips/blob/master/bip-0039/bip-0039-wordlists.md).

---

## Hierarchical Deterministic Wallets 

### Motivation 

In Cardano, hierarchical deterministic (HD) wallets are similar to those described in [BIP-0032](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki#motivation).

Deterministic wallets and elliptic curve mathematics permit schemes where one can calculate a wallet's public keys without revealing its private keys. This allows for example a webshop business to let its webserver generate fresh addresses (public key hashes) for each order or for each customer, without giving the web server access to the corresponding private keys (which are required for spending the received funds). However, deterministic wallets typically consist of a single "chain" of keypairs. The fact that there is only one chain means that sharing a wallet happens on an all-or-nothing basis. 

However, in some cases one only wants some (public) keys to be shared and recoverable. In the example of a web shop, the web server does not need access to all public keys of the merchant's wallet; only to those addresses which are used to receive customer's payments, and not for example the change addresses that are generated when the merchant spends money. Hierarchical deterministic wallets allow such selective sharing by supporting multiple keypair chains, derived from a single root. 

### Notation

Conceptually, HD derivation can be seen as a tree with many branches, where keys live at each node and leaf such that an entire sub-tree can be recovered from only a parent key (and seemingly, the whole tree can be recovered from the root master key). 

For deriving new keys from parent keys, we use the same approach as defined in [BIP32-Ed25519: Hierarchical Deterministic Keys over a Non-linear Keyspace](/adrestia/user-guide/Ed25519_BIP.pdf).



We note {{<katex>}}CKD_{priv}{{</katex>}} the derivation of a private child key from a parent private key such that:

```eval_rst 
.. math::

CKD_{prv}((k^P, c^P), i) → (k_i, c_i)

```

We note {{< katex >}}CKD_{pub}{{</katex>}} the derivation of a public child key from a parent public key such that:

{{<katex>}}
i <  2^{31}: CKD_{pub}((A^P, c^P), i) → (A_i, c_i)
{{</katex>}}

> **HINT** This is only possible for so-called "soft" derivation indexes, smaller than {{<katex>}}2^{31}{{</katex>}}.

We note {{<katex>}}N{{</katex>}} the public key corresponding to a private key such that:

{{<katex>}}
N(k, c) → (A, c) 
{{</katex>}}

To shorten notation, we will borrow the same notation as described in BIP-0032
and write {{<katex>}}CKD_{priv}(CKD_{priv}(CKD_{priv}(m,3H),2),5){{</katex>}} as `m/3H/2/5`. Equivalently for
public keys, we write {{<katex>}}CKD_{pub}(CKD_{pub}(CKD_{pub}(M,3),2),5){{</katex>}} as `M/3/2/5`. 

### Path Levels

Cardano wallet defines the following path levels:

{{<katex>}}
m / purpose_H / coin\_type_H / account_H / account\_type / address\_index
{{</katex>}}

- {{<katex>}}purpose_H{{</katex>}} is set to {{<katex>}}1852_H{{</katex>}}
- {{<katex>}}coin\_type_H{{</katex>}} is set to {{<katex>}}1815_H{{</katex>}}
- {{<katex>}}account_H{{</katex>}} is set for now to {{<katex>}}0_H{{</katex>}}
- {{<katex>}}account\_type{{</katex>}} is either:
  - `0` to indicate an address on the external chain, that is, an address 
    that is meant to be public and communicated to other users. 
  - `1` to indicate an address on the internal chain, that is, an address
    that is meant for change, generated by a wallet software.
  - `2` to indicate a reward account address, used for delegation.
- {{<katex>}}address\_index{{</katex>}} is either:
  - `0` if the {{<katex>}}account\_type{{</katex>}} is `2`
  - Anything between 0 and 2<sup>31 otherwise

> **WARNING**  In the _Byron_ era, sequential wallets used in Yoroi (also known as Icarus wallets) have been using `purpose = 44_H` according to standard BIP-44 wallets. 
> The _Shelley_ era introduces an extension to BIP-44, and therefore uses a different `purpose` number.

### Account Discovery

> What follows is taken from the "Account Discovery" section from [BIP-0044](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki#account-discovery)

When the master seed is imported from an external source, the software should start to discover the accounts in the following manner:

-    Derive the first account's node (index = 0)
-    Derive the external chain node of this account
-    Scan addresses of the external chain; respect the gap limit described below
-    If no transactions are found on the external chain, stop discovery
-    If there are some transactions, increase the account index and go to step 1

For the algorithm to be successful, software should disallow the creation of a new accounts if the previous one has no transaction history.

Please note that the algorithm works with the transaction history, not account balances, so you can have an account with 0 total coins and the algorithm will still continue with the discovery.

### Address gap limit

Address gap limit is currently set to 20. If the software hits 20 unused addresses in a row, it assumes that there are no used addresses beyond this point and stops searching the address chain. We scan just the external chains, because internal chains receive only coins that come from the associated external chains.

Wallet software should warn when the user is trying to exceed the gap limit on an external chain by generating a new address. 


## Master Key Generation

### History

Cardano has used different styles of HD wallets, which cane be categorized as:

Wallet Style | Compatible Products
---          | ---
Byron        | Daedalus, Yoroi
Icarus       | Yoroi, Trezor
Ledger       | Ledger

Each wallet is based on Ed25519 elliptic curves, though there are subtle differences, 
which are highlighted in the next sections.

### Overview

The master key generation turns an initial entropy into  a secure cryptographic key. 
Child keys can be derived from a master key to produce a HD structure as outlined above.
Child key derivation is explored in next sections.

In Cardano, the master key generation is different, depending on the style of wallet. 
In each case however, the generation is a function from an initial seed to an extended private key
(XPrv) composed of:

- 64 bytes: an extended Ed25519 secret key composed of:
    - 32 bytes: Ed25519 curve scalar from which few bits have been tweaked (see below)
    - 32 bytes: Ed25519 binary blob used as IV for signing
- 32 bytes: chain code for allowing secure child key derivation

> Additional resources:
> 
> - [SLIP 0010](https://github.com/satoshilabs/slips/blob/master/slip-0010.md)
> - [BIP 0032](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)
> - [BIP 0039](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki)
> - [RFC 8032](https://tools.ietf.org/html/rfc8032#section-5.1.5)

## Pseudo-code

### Byron 
```js
function generateMasterKey(seed) {
    return hashRepeatedly(seed, 1);
}

function hashRepeatedly(key, i) {
    (iL, iR) = HMAC
        ( hash=SHA512
        , key=key
        , message="Root Seed Chain " + UTF8NFKD(i)
        );
    
    let prv = tweakBits(SHA512(iL));

    if (prv[31] & 0b0010_0000) { 
        return hashRepeatedly(key, i+1);
    }

    return (prv + iR);
}

function tweakBits(data) {
    // * clear the lowest 3 bits
    // * clear the highest bit
    // * set the highest 2nd bit
    data[0]  &= 0b1111_1000;
    data[31] &= 0b0111_1111;
    data[31] |= 0b0100_0000;

    return data;
}
```
### Icarus

_Icarus_ master key generation style supports setting an extra password as an arbitrary 
byte array of any size. This password acts as a second factor applied to cryptographic key 
retrieval. When the seed comes from an encoded recovery phrase, the password can therefore
be used to add extra protection in cases where the recovery phrase might be exposed.

```js
function generateMasterKey(seed, password) {
    let data = PBKDF2
        ( kdf=HMAC-SHA512
        , iter=4096
        , salt=seed
        , password=password
        , outputLen=96
        );

    return tweakBits(data);
}

function tweakBits(data) {
    // on the ed25519 scalar leftmost 32 bytes:
    // * clear the lowest 3 bits
    // * clear the highest bit
    // * clear the 3rd highest bit
    // * set the highest 2nd bit
    data[0]  &= 0b1111_1000;
    data[31] &= 0b0001_1111;
    data[31] |= 0b0100_0000;

    return data;
}
```

> For a detailed analysis of the cryptographic choices and the above requirements, 
> have a look at: [Wallet Cryptography and Encoding](https://github.com/input-output-hk/chain-wallet-libs/blob/master/doc/CRYPTO.md#master-key-generation-to-cryptographic-key)

### Ledger

```js
function generateMasterKey(seed, password) {
    let data = PBKDF2
        ( kdf=HMAC-SHA512
        , iter=2048
        , salt="mnemonic" + UTF8NFKD(password)
        , password=UTF8NFKD(spaceSeparated(toMnemonic(seed)))
        , outputLen=64
        );

    let cc = HMAC
        ( hash=SHA256
        , key="ed25519 seed"
        , message=UTF8NFKD(1) + seed
        );

    let (iL, iR) = hashRepeatedly(data);

    return (tweakBits(iL) + iR + cc);
}

function hashRepeatedly(message) {
    let (iL, iR) = HMAC
        ( hash=SHA512
        , key="ed25519 seed"
        , message=message
        );
    
    if (iL[31] & 0b0010_0000) { 
        return hashRepeatedly(iL + iR);
    }

    return (iL, iR);
}

function tweakBits(data) {
    // * clear the lowest 3 bits
    // * clear the highest bit
    // * set the highest 2nd bit
    data[0]  &= 0b1111_1000;
    data[31] &= 0b0111_1111;
    data[31] |= 0b0100_0000;

    return data;
}
```