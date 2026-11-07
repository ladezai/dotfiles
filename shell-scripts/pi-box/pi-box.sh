pi-box() {
  # Locate the directory where this script resides
  SCRIPT_DIR="$HOME/.config/shell-scripts/pi-box"
  MACHINE_STATUS=$(podman machine inspect --format '{{.State}}' 2>/dev/null)
  
  if [ "$MACHINE_STATUS" != "Running" ]; then
    echo "⚙️ Podman machine is not running (Current state: ${MACHINE_STATUS:-not found}). Starting machine..."
    podman machine start
    
    # Brief pause to let the backend socket fully initialize
    sleep 3
  fi
  if ! podman machine info >/dev/null 2>&1; then
    echo ">>> Podman machine is not running. Starting default machine..."
    podman machine start
  fi

  if ! podman image exists pi-sandbox; then
    echo ">>> 'pi-sandbox' container image not found. Building it now..."
    if [ -f "$SCRIPT_DIR/Dockerfile" ]; then
      podman build -t pi-sandbox "$SCRIPT_DIR"
    else
      echo ">>> Error: Dockerfile not found at $SCRIPT_DIR/Dockerfile. Cannot build image."
      return 1
    fi
  fi

  CONFIG_INI="$SCRIPT_DIR/models.ini"
  if [ ! -f "$CONFIG_INI" ]; then
    echo ">>> Error: Required model preset file not found at: $CONFIG_INI"
    return 1
  fi

  echo ">>> Starting local llama-server using preset ($CONFIG_INI)..."
  llama-server --models-preset "$CONFIG_INI" --host 0.0.0.0 --port 8080 > /tmp/llama-server.log 2>&1 &
  LLAMA_PID=$!
  sleep 2

  podman run --rm -it \
    -v "$(pwd):/workspace:Z" \
    -v "$HOME/.pi:/home/piuser/.pi:Z" \
    -e HOME=/home/piuser \
    pi-sandbox "$@"

  echo ">>> Stopping local llama-server..."
  kill $LLAMA_PID 2>/dev/null
}
