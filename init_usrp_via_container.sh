#!/bin/bash

# USRP Initialization via Compose-defined container
# Usage: ./init_usrp_via_container.sh <docker-compose|docker compose> <service-name>

DC_CMD="$1"
SERVICE_NAME="$2"

if [[ -z "$DC_CMD" || -z "$SERVICE_NAME" ]]; then
  echo "[!] Usage: $0 <docker-compose or docker compose> <service-name>"
  exit 1
fi

MAX_RETRY=3
DELAY_BETWEEN_RETRIES=3

# Function: check if USRP is ready (non-WestBridge)
is_usrp_ready() {
  lsusb | grep -i "3923:7814" | grep -qi "USRP"
}

# Function: print current device info
print_usrp_info() {
  lsusb | grep -i "3923:7814"
}

# Retry loop
for i in $(seq 1 $MAX_RETRY); do
  echo "[*] Checking for initialized USRP device... (attempt $i)"
  if is_usrp_ready; then
    echo "✅ USRP device is ready:"
    print_usrp_info
    exit 0
  fi

  echo "❌ USRP not initialized. Running container to upload firmware..."

  # Use docker compose/docker-compose to run service (relies on compose file for privileges)
  $DC_CMD run --rm "$SERVICE_NAME" bash -c \
  	"uhd_find_devices 2>&1 | awk '/USB open failed/ {skip=1; next} /See the application notes/ {if(skip) {skip=0; next}} {skip=0; if (NF) print}' || true"


  echo "[*] Waiting $DELAY_BETWEEN_RETRIES seconds for USB re-enumeration..."
  sleep $DELAY_BETWEEN_RETRIES
done

echo "❌ Failed to initialize USRP after $MAX_RETRY attempts."
exit 1

