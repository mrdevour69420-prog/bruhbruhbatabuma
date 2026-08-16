#!/bin/bash
set -euo pipefail   # -u catches unset vars, -o pipefail catches curl failures in the pipe

log() { echo "[setup] $*"; }

MODPACK="mod.mrpack"
REMLIST="remlist.txt"
MODS_DIR="./mods"
JOBS="${JOBS:-67}"

# --- sanity checks before chmod ---
for f in download.sh remove.sh git.sh; do
    [[ -f "$f" ]] || { echo "ERROR: $f not found" >&2; exit 1; }
done
chmod +x download.sh remove.sh git.sh

log "Downloading modpack ($MODPACK)..."
./download.sh -p "$MODPACK" -j "$JOBS"

log "Removing excluded mods..."
[[ -f "$REMLIST" ]] || { echo "ERROR: $REMLIST not found" >&2; exit 1; }
./remove.sh -f "$REMLIST" -d "$MODS_DIR"

log "Running installer.jar..."
[[ -f installer.jar ]] || { echo "ERROR: installer.jar not found" >&2; exit 1; }
java -jar installer.jar

[[ -f start.sh ]] || { echo "ERROR: start.sh not found (installer may have failed)" >&2; exit 1; }
chmod +x start.sh

log "Launching server..."
exec ./start.sh   # exec replaces this shell's PID with start.sh's — ties into your PID-tracking fix