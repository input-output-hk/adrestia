#!/usr/bin/env bash

set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "usage: $0 NAME"
  exit 1
fi

if [ -z "${BW_SESSION:-}" ]; then
  echo "BW_SESSION not set. Use 'bw login' or 'bw unlock'."
  exit 2
fi

bw get  --organizationid "$BW_ORGANIZATION_ID" password "$1"
