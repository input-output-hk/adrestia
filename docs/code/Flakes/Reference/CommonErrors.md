---
title: Common Errors
date: 2021-02-09
---

```
error: getting status of '/nix/store/1dg75ahm07ah26phnd1jy1jq06s680ps-source/some-file.nix': No such file or directory
```

Make sure the file is staged to version control. Flakes can't see files that are not tracked by version control.
