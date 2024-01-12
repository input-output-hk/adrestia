---
title: Common Errors
date: 2021-02-09
---

```
error: getting status of '/nix/store/1dg75ahm07ah26phnd1jy1jq06s680ps-source/some-file.nix': No such file or directory
```

Make sure the file is staged to version control. Flakes can't see files that are not tracked by version control.

```
warning: Git tree '/home/rodney/iohk/cardano-wallet' is dirty
```

It can be hidden (if desired) by using the allow-dirty = true option in nix.conf.
