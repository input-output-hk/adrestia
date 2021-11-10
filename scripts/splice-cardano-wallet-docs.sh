#!/usr/bin/env bash

# Copies in documentation from the given cardano-wallet worktree.
# This is used in CI.

set -euo pipefail

tree="${1:-}"
copy_arg="${2:---symbolic-link}"

if [ -z "$tree" ]; then
  echo "usage: $0 CARDANO-WALLET-DIR"
  exit 1
fi

cd "$(dirname "$0")/.." || exit

docs=docs
dest=$docs/cardano-wallet

cp --no-clobber "$copy_arg" -rv -T "$(realpath "$tree")/docs/" $dest/

test -e $dest/index.md && mv --no-clobber -v $dest/index.md $docs/cardano-wallet.md
