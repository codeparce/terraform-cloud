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
  
  if [[ -f error_plan.log && -s error_plan.log ]]; then
    echo "Attempting to force-unlock Terraform state..."
    grep 'ID:' error_plan.log | awk '{print $3}' | head -n 1 > lock_id.log
    terraform force-unlock -force "$(cat lock_id.log)"
  else
    echo "No lock ID found, skipping force-unlock"
  fi
}

trap on_error ERR
