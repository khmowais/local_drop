#!/bin/bash

SHARE_DIR="$HOME/LocalDrop/Shared_material"
INDEX_FILE="$SHARE_DIR/index.html"
PORT=8080

generate_index() {
    echo "[*] Generating index.html in $SHARE_DIR"
    echo "<html><body><h2>Shared Files</h2><ul>" > "$INDEX_FILE"
    for file in "$SHARE_DIR"/*; do
        [ -f "$file" ] || continue
        fname=$(basename "$file")
        if [[ "$fname" != "index.html" ]]; then
            echo "<li><a href=\"$fname\">$fname</a></li>" >> "$INDEX_FILE"
        fi
    done
    echo "</ul></body></html>" >> "$INDEX_FILE"
    echo "[✓] index.html created."
}

watch_and_update_index() {
    inotifywait -m -e create -e delete --format '%f' "$SHARE_DIR" | while read change; do
        if [[ "$change" != "index.html" ]]; then
            generate_index
        fi
    done
}

start_server() {
    echo "[*] Starting local file server on http://0.0.0.0:$PORT"
    cd "$SHARE_DIR" || exit 1

    # Start watching for changes in background
    watch_and_update_index &
    WATCHER_PID=$!

    # Start the server in the foreground
    python3 -m http.server "$PORT"

    # Kill the watcher when server stops
	trap 'echo "[*] Stopping server..."; if ps -p $WATCHER_PID > /dev/null 2>&1; then kill $WATCHER_PID; fi; exit 0' INT
    }

# Initial setup
generate_index
start_server
