---
tags:
  - tools
---

# Git

## Getting started with GitHub

[GitHub Quickstart Guide](https://docs.github.com/en/get-started/quickstart/set-up-git)

## How to more easily split up a PRs into smaller pieces

[Stacked Git](https://stacked-git.github.io/) provides an easier
workflow than standard `git rebase` alone.

## How to configure your GitHub for IOHK

If you already have a personal GitHub account, you don't need to make
a new account just for IOHK. It's possible to achieve a satisfactory
arrangement by tweaking a few settings in GitHub and `git`.

1. Ensure that you have added `your.name@iohk.io` as an additional
   [e-mail address of your GitHub account](https://github.com/settings/emails).
2. In your [GitHub Notifications Settings](https://github.com/settings/notifications),
  scroll down to the
   **Custom routing** section, and ensure that the
   [input-output-hk](https://github.com/input-output-hk) org directs to
   `your.name@iohk.io`. This will also have the effect of attributing
   GitHub-authored commits in IOHK repos to your IOHK e-mail address, rather
   than your personal e-mail address.
3. The GPG key which you use for signing commits as `your.name@iohk.io`
   should be added to your [GitHub GPG Keys](https://github.com/settings/keys) list.
4. GitHub supports MFA with YubiKeys - please use that rather than TOTP
   or phone-based authenticator apps.

## How to configure your git for IOHK

Here are some tips you can try.

### Make a separate config file for IOHK

Your global git config is in `~/.config/git/config` and looks
something like this:

```conf
[user]
	email = "myname_72@hotmail.com"
	name = "My Name"

[includeIf "gitdir:~/iohk/"]
	path = "~/.config/git/iohk.config"
```

And then the IOHK-specific settings you put into
`~/.config/git/iohk.config`, like this:

```conf
[commit]
    gpgSign = true

[user]
    email = "my.name@iohk.io"
    signingKey = "763208E1F43EDBDA1D87A632CFD319FB4C00B5C2"
```

Then any git repo you have cloned under `~/iohk` will receive
IOHK-specific settings.

### More useful merge conflict cookies

```conf
[merge]
	conflictstyle = "diff3"
```

### Prevent accidental pushes to `master`

Put the following into `~/iohk/git-hook-pre-push.sh`:

```bash
#!/usr/bin/env bash

remote="$1"

while read local_ref local_oid remote_ref remote_oid
do
    if [ "$remote" = origin -a "$remote_ref" = refs/heads/master ]; then
        if [ -z "$PUSH_MASTER" ]; then
            echo >&2 "$0 prevents accidental pushes to origin/master."
            echo >&2 "Set the PUSH_MASTER environment variable and try again."
            exit 1
        else
            echo >&2 "Using PUSH_MASTER setting to push..."
        fi
    fi
done

exit 0
```

Then enable this hook for any repo which you would like to protect from accidents. For example:

```shell-session
$ chmod 755 ~/iohk/git-hook-pre-push.sh
$ ln -vsf !$ ~/iohk/cw/cardano-wallet.git/hooks/pre-push.sh
```

To bypass protection, you do this:

```shell-session
$ PUSH_MASTER=1 git push origin master
```

## Emacs Magit

Emacs [Magit](https://magit.vc/) is highly recommended.
Also [magit-forge](https://github.com/magit/forge) can be helpful.
