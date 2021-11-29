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

password=$(cat)

item=$( ( bw get --organizationid "$BW_ORGANIZATION_ID" item "$1" || bw get template item ) | jq --arg name "$1" --arg password "$password" --arg folderId "$BW_FOLDER_ID" --arg notes "NixOps deployment key" '.name=$name|.login.password=$password|.folderId=$folderId|.notes=$notes')

item_id=$(jq -r .id <<< "$item")

if [ "$item_id" = "null" ]; then
  echo "Creating."
  updated=$(bw encode <<< "$item" | bw create item)
  item_id=$(jq -r .id <<< "$updated")
else
  echo "Updating item $item_id."
  updated=$(bw encode <<< "$item" | bw edit item "$item_id")
fi

if [ $(jq -r .organizationId <<< "$updated") = "null" ]; then
  echo "Setting organization and collection."
  updated=$(echo '["'"$BW_COLLECTION_ID"'"]' | bw encode | bw share "$item_id" "$BW_ORGANIZATION_ID")
fi

echo "Updated object:"
jq . <<< "$updated"
