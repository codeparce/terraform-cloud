#!/usr/bin/env bash
set -Eeuo pipefail

LOG_FILE="general-logs.log"
LOG_ERR=error.log 

touch $LOG_FILE $LOG_ERR

# Guardar TODO (stdout + stderr), append

exec > >(tee -a "$LOG_FILE") 2>> "$LOG_ERR"

on_error() {
  echo "❌ ERROR detected. Showing logs:"
  echo "---------------------------------"
  cat $LOG_ERR
  echo "---------------------------------"

  grep 'ID:' error.log | awk '{print $1}' | head -n 1
  grep 'ID:' error.log | awk '{print $2}' | head -n 1
  grep 'ID:' error.log | awk '{print $3}' | head -n 1
  grep 'ID:' error.log | awk '{print $4}' | head -n 1

  LOCK_ID=$(grep 'ID:' "$LOG_ERR" | awk '{print $4}' | head -n 1)

  if [[ -n "$LOCK_ID" ]]; then
    echo "Attempting to force-unlock Terraform state..."
    terraform force-unlock -force "$LOCK_ID"
  else
    echo "No lock ID found, skipping force-unlock"
  fi
}

trap on_error ERR
