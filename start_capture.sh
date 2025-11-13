#!/bin/bash

# Script to start the Docker container with optional rebuild and GUI setup

IMAGE_NAME="wifi-capture"
REBUILD_MODE="ask"  # default mode: ask user whether to rebuild

# Detect available Docker Compose command
if command -v docker compose &> /dev/null; then
  DC_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
  DC_CMD="docker-compose"
else
  echo "[!] Neither 'docker compose' nor 'docker-compose' is available."
  exit 1
fi

# Parse command line options
for arg in "$@"; do
  case $arg in
    --rebuild)
      REBUILD_MODE="yes"  # force rebuild
      shift
      ;;
    --no-rebuild)
      REBUILD_MODE="no"   # skip rebuild
      shift
      ;;
  esac
done

# Enable GUI access from container to host display
echo "[*] Enabling X11 GUI access..."
xhost +local:root
trap 'xhost -local:root' EXIT  # Revoke access on script exit

# Skip writing prefs.conf; it is mounted into the container via Docker volume
# mkdir -p /root/.gnuradio
# echo "gr.vmcircbuf_default_type = gr_vmcircbuf_sysv_shm" > /root/.gnuradio/prefs.conf


# Stop and remove any existing containers
echo "[*] Stopping any running containers..."
$DC_CMD down

# Check if Docker image already exists
IMAGE_EXISTS=$(docker images -q $IMAGE_NAME)

# Ask user whether to rebuild
if [[ -n "$IMAGE_EXISTS" && "$REBUILD_MODE" == "ask" ]]; then
  echo "[?] Docker image '$IMAGE_NAME' already exists. Rebuild? [y/N]"
  read -r USER_INPUT
  if [[ "$USER_INPUT" =~ ^[Yy]$ ]]; then
    REBUILD_MODE="yes"
  else
    REBUILD_MODE="no"
  fi
fi

# Rebuild image if needed
if [[ "$REBUILD_MODE" == "yes" ]]; then
  echo "[*] Rebuilding Docker image..."
  $DC_CMD build
else
  echo "[*] Skipping image rebuild."
fi


# Initialize USRP via container if needed
echo "[*] Checking and initializing USRP (if needed)..."
./init_usrp_via_container.sh "$DC_CMD" "$IMAGE_NAME"
if [ $? -ne 0 ]; then
  echo "❌ Failed to initialize USRP. Aborting container launch."
  exit 1
fi


# Launch container in interactive mode
echo "[*] Starting container..."
$DC_CMD run --rm wifi-capture bash

