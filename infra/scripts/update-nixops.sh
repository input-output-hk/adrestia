#!/usr/bin/env bash

set -euo pipefail

if [ -n "${top:-}" ]; then
  cd "$top"
fi

if nixops info >& /dev/null; then
  cmd=modify
else
  cmd=create
fi

cmd=modify

nixops $cmd -d "$NIXOPS_DEPLOYMENT" --network .
nixops set-args --arg gceAccessKeyFile ./secrets/gce-nixops-key

nixops list || true

for thing in aws_access_key_id aws_secret_access_key; do
  value=$(fetch-secret adrestia_$thing)
  aws configure --profile="$AWS_PROFILE" set $thing "$value"
done

aws configure list
