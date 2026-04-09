#!/usr/bin/env bash
set -Eeuo pipefail

LOG_FILE="general-logs.log"
LOG_ERR="error.log"

touch "$LOG_FILE" "$LOG_ERR"

# Guardar stdout y stderr
exec > >(tee -a "$LOG_FILE") 2>>"$LOG_ERR"

on_error() {
  EXIT_CODE=$?
  LINE_NO=$1

  echo ""
  echo "❌ ERROR detected (exit code: $EXIT_CODE) at line $LINE_NO"
  echo "---------------------------------"
  
  echo "👉 Last 50 lines of error log:"
  tail -n 50 "$LOG_ERR" || true
  
  echo "---------------------------------"

  # Buscar LOCK_ID de forma segura (sin romper el script)
  LOCK_ID=$(grep 'ID:' "$LOG_ERR" 2>/dev/null | awk '{print $4}' | head -n 1 || true)

  if [[ -n "${LOCK_ID:-}" ]]; then
    echo "🔓 Attempting to force-unlock Terraform state with ID: $LOCK_ID"
    terraform force-unlock -force "$LOCK_ID" || echo "⚠️ Failed to unlock (ignored)"
  else
    echo "ℹ️ No lock ID found, skipping force-unlock"
  fi

  echo "❌ Script failed"
  exit "$EXIT_CODE"
}

# Pasar número de línea al trap
trap 'on_error $LINENO' ERR