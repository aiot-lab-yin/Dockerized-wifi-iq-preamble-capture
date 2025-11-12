#!/bin/bash
# start_demo_server.sh
# Go to 'demo' folder and start a Python HTTP server

# Change directory to demo
cd demo || { echo "Folder 'demo' not found"; exit 1; }

# Start Python HTTP server on port 8080
echo "Starting HTTP server in $(pwd) on port 8080..."
python3 -m http.server 8080
