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

start_server() {
    echo "[*] Starting local file server on http://0.0.0.0:$PORT"
    cd "$SHARE_DIR" || exit 1
    python3 -m http.server "$PORT"
}

# Main
generate_index
start_server
