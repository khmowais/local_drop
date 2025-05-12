#!/bin/bash

USB_MOUNT="/media/ap2kmo/USB_SAMSUNG"  # Your real USB path
DROPBOX_FOLDER_NAME="dropbox"
RECEIVE_DIR="$HOME/LocalDropReceived"

mkdir -p "$RECEIVE_DIR"

send_file() {
    echo "[*] Sending file to USB..."

    if [ ! -d "$USB_MOUNT" ]; then
        echo "[!] USB not mounted at $USB_MOUNT"
        return
    fi

    DROPBOX="$USB_MOUNT/$DROPBOX_FOLDER_NAME"
    mkdir -p "$DROPBOX" || { echo "[!] Failed to create dropbox folder."; return; }

    cp "$1" "$DROPBOX/" && echo "[✓] File sent to USB: $DROPBOX"
}

receive_files() {
    echo "[*] Looking for files to receive from USB..."

    DROPBOX="$USB_MOUNT/$DROPBOX_FOLDER_NAME"

    if [ -d "$DROPBOX" ]; then
        cp "$DROPBOX"/* "$RECEIVE_DIR/" 2>/dev/null
        echo "[✓] Files received to $RECEIVE_DIR"
    else
        echo "[!] No dropbox folder found on USB."
    fi
}

print_help() {
    echo "Usage:"
    echo "  ./localdrop.sh send <file_path>"
    echo "  ./localdrop.sh receive"
}

# Main
if [ "$1" == "send" ] && [ -f "$2" ]; then
    send_file "$2"
elif [ "$1" == "receive" ]; then
    receive_files
else
    print_help
fi
