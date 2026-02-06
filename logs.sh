#!/usr/bin/env bash
set -Eeuo pipefail

LOG_FILE="general-logs.log"
LOG_ERR=error.log 

touch $LOG_FILE $LOG_ERR

# Guardar TODO (stdout + stderr), append

exec > >(tee -a "$LOG_FILE") 2> >(tee -a "$LOG_ERR" >&2)

on_error() {
  echo "❌ ERROR detected. Showing logs:"
  echo "---------------------------------"
  cat $LOG_ERR
  echo "---------------------------------"
}

trap on_error ERR
