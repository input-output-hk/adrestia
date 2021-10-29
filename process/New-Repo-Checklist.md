**Status**: Draft - Review and Comments please.

Policy and checklist for creating a new repo on GitHub.

[input-output-hk]: https://github.com/input-output-hk
[teams]: https://github.com/orgs/input-output-hk/teams
[Adrestia]: https://github.com/orgs/input-output-hk/teams/adrestia
[Adrestia Admins]: https://github.com/orgs/input-output-hk/teams/adrestia-admins
[Adrestia Maintainers]: https://github.com/orgs/input-output-hk/teams/adrestia-maintainers
[Adrestia Guests]: https://github.com/orgs/input-output-hk/teams/adrestia-guests
[devops]: https://github.com/orgs/input-output-hk/teams/devops
[release]: https://github.com/orgs/input-output-hk/teams/release

### 0. Does it need to be a separate repo?

Often, you can simply use a subdirectory of an existing repo. Even
Haskell packages that will be published to Hackage can be kept in
subdirectories of another project.

Multiple repos are more work to maintain (e.g. CI), and it's more
stuff to keep track of.

Ensure that you have a good reason to create a separate repo.

### 1. Decide which GitHub organization owns the repo

In general, **DON'T** use your private GitHub account to own
repos/forks which are dependencies of IOHK repos. Unless this fork is
temporary, prefer [input-output-hk][]. If you leave, we don't want our
project repos to disappear.

However, to state the obvious, **DON'T** add repos which are likely to
harm to harm the reputation of IOHK or mislead the public. Ask first,
if in doubt.

### 2. Decide whether the repo should be private

Usually a repo should be public, unless there is some real reason to
restrict access.

**DON'T** create private repos under [input-output-hk][], unless you
are certain that it should remain private for a while. It's rather
difficult to change a private repo to public, or even to delete the
private repo that you just created.

### 3. Could an existing repo just be moved?

If doing renames, merges, etc, consider using "Transfer ownership",
"Rename", or "Change repository visibility" in the GitHub repo
settings. This is safe, because the old locations will redirect. You
may need IT to help with this change.

### 4. Checklist for adding a new repo

- [ ] Ensure appropriate access to the repo in _Settings_ → _Manage access_.

  **DO** use GitHub [Input Output organization teams][teams] to manage access levels.

  **DON'T** invite individual developers (except your own user), unless for exceptional circumstances. Consider using the [Adrestia Guests][] team.

  Invite teams according to this scheme:

  * [Adrestia][] - Triage (the umbrella group)
  * [Adrestia Admins][] - Admin
  * [Adrestia Maintainers][] - Maintainers (most developers are in this group).
  * [Adrestia Guests][] - Write
  * [devops][] - Admin (for setting up CI things)
  * [release][] - Write (for editing release notes and making releases)
      
- [ ] Name of `master` branch - it really doesn't matter, but consistency is nice.

- [ ] Switch off features such as Issues/Wiki/Project/Pages unless you actually need them.

- [ ] Add Autolink references for jira:

  ADP-123  →  https://jira.iohk.io/browse/ADP-123
  
  ([see the GitHub documentation for more information](https://docs.github.com/en/github/administering-a-repository/configuring-autolinks-to-reference-external-resources))

- [ ] Remember to customize the "About" text and URL if applicable.

- [ ] CI: if using Buildkite, set up a [pipeline](https://buildkite.com/input-output-hk) and webhook.

- [ ] CI: if using Hydra open a PR to add a [jobset](https://github.com/input-output-hk/ci-ops/blob/master/jobsets/default.nix).

- [ ] CI: if your CI requires secrets such as auth tokens, ensure that
  all secrets are also stored in our shared LastPass folder (see
  [Passwords](./Passwords)).

- [ ] If this repo is splitting off an existing repo, see [this document from our wiki](https://github.com/input-output-hk/cardano-coin-selection/blob/master/information/repository-creation-process.md).
      
