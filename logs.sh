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

  if [[ -f .terraform/lock_id.txt && -s .terraform/lock_id.txt ]]; then
    echo "Attempting to force-unlock Terraform state..."
    terraform force-unlock -force "$(cat .terraform/lock_id.txt)"
  else
    echo "No lock ID found, skipping force-unlock"
  fi
}

trap on_error ERR
