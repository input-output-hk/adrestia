---
pandoc:
  rewriteClass:
    frontbox2: rounded-t-xl bg-gradient-to-b from-indigo-100 to-indigo-400 bg-white p-8 mb-4
    frontbox1: grid grid-cols-2 gap-4 p-3 bg-indigo-500 md:grid-cols-3

---

# Adrestia Project

:::{.frontbox2}
:::{.frontbox1}

[[code|Code (what)]]{class="h-32 p-4 border-4 bg-white rounded-md flex items-center justify-center text-center text-2xl font-extrabold hover:bg-indigo-300 hover:border-yellow-600 hover:no-underline"}

[[process|Process (how)]]{class="h-32 p-4 border-4 bg-white rounded-md flex items-center justify-center text-center text-2xl font-extrabold hover:bg-indigo-300 hover:border-yellow-600 hover:no-underline"}

[[resources]]{class="h-32 p-4 border-4 bg-white rounded-md flex items-center justify-center text-center text-2xl font-extrabold hover:bg-indigo-300 hover:border-yellow-600 hover:no-underline"}

[Tags](-/tags){class="h-32 p-4 border-4 bg-indigo-100 rounded-md flex items-center justify-center text-center text-2xl font-extrabold hover:bg-indigo-300 hover:border-yellow-600 hover:no-underline"}

[Index](-/all){class="h-32 p-4 border-4 bg-indigo-100 rounded-md flex items-center justify-center text-center text-2xl font-extrabold hover:bg-indigo-300 hover:border-yellow-600 hover:no-underline"}

[Docs TODO List](-/tasks){class="h-32 p-4 border-4 bg-indigo-100 rounded-md flex items-center justify-center text-center text-2xl font-extrabold hover:bg-indigo-300 hover:border-yellow-600 hover:no-underline"}
:::
:::


## What is Adrestia?

Adrestia is a process, a suite of products, and a team within IOHK.

### Process

Our vision is to produce a set of orthogonal and self-contained services and
APIs to support Cardano applications such as wallets and explorer applications.

These services are developed in a usable, reliable, extensible, and maintainable
way. These are our processes and practices.

See:
- [[code]]
- [[process]]

### Products

Our flagship product is [[cardano-wallet]], which is a HTTP
service for sending and receiving payments on the Cardano blockchain.

[[cardano-wallet]] is a application which can be used on its own,
but usually it will be used as the backend service of other applications such as
a desktop wallet app, in a web shop, or at a cryptocurrency exchange.

Underlying the service applications are several Haskell packages which
developers can use to create new applications based on Cardano.

See:
- [[Adrestia-Architecture]]
- [[user-guide|Cardano Wallet User Guide]]

### Team

Adrestia are also the [engineering team][github-team] whose goal
is to bring Cardano to users and developers through our products.

We work with the Cardano community and alongside other teams in IOHK.

[github-team]: https://github.com/orgs/input-output-hk/teams/adrestia/members
