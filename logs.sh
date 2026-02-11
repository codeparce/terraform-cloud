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
  echo "Attempting to force-unlock Terraform state..."
  grep 'ID:' $LOG_ERR | awk '{print $3}' | head -n 1 > lock_id.log

  if [[ -f lock_id.log && -s lock_id.log ]]; then
    terraform force-unlock -force "$(cat lock_id.log)"
  else
    echo "No lock ID found, skipping force-unlock"
  fi
}

trap on_error ERR
