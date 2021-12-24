#!/usr/bin/env bash

set -euo pipefail

url=$(nix eval --raw --impure --expr 'let f = import ./flake.nix; in f.inputs.rvl.url')

rvl="${1:-$url}"

rm -f flake.lock

nix flake lock --override-flake rvl "$rvl" --inputs-from "$rvl" --show-trace
nix develop --override-flake rvl "$rvl" --inputs-from "$rvl" --show-trace --command true
