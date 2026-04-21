#!/usr/bin/env bash

LOG_FILE="general-logs.log"
LOG_ERR="error.log"

touch "$LOG_FILE" "$LOG_ERR"

exec 1> >(tee -a "$LOG_FILE") 2> >(tee -a "$LOG_ERR" >&2)

on_error() {
  EXIT_CODE=$?
  echo "❌ ERROR detected. Showing logs:"
  echo "---------------------------------"
  cat "$LOG_ERR"
  echo "---------------------------------"

  LOCK_ID=$(grep 'ID:' "$LOG_ERR" | awk '{print $4}' | head -n 1)

  if [[ -n "$LOCK_ID" ]]; then
    echo "Attempting to force-unlock Terraform state..."
    terraform force-unlock -force "$LOCK_ID" || true
  else
    echo "No lock ID found, skipping force-unlock"
  fi

  exit $EXIT_CODE
}

trap 'on_error' ERR
