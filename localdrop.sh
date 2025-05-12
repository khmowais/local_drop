#!/bin/bash

USB_MOUNT="/media/$USER" # Adjust if your distro mounts elsewhere
DROPBOX_FOLDER_NAME="dropbox"
RECEIVE_DIR="$HOME/LocalDropReceived"

mkdir -p "$RECEIVE_DIR"

send_file() {
    echo "[*] Scanning for USB drives..."
    for mount in "$USB_MOUNT"/*; do
        if [ -d "$mount" ]; then
            DROPBOX="$mount/$DROPBOX_FOLDER_NAME"
            mkdir -p "$DROPBOX"
            echo "[+] Sending '$1' to $DROPBOX"
            cp "$1" "$DROPBOX/"
            echo "[✓] File sent to USB: $mount"
            return
        fi
    done
    echo "[!] No USB drive found."
}

receive_files() {
    echo "[*] Looking for files to receive from USB..."
    for mount in "$USB_MOUNT"/*; do
        DROPBOX="$mount/$DROPBOX_FOLDER_NAME"
        if [ -d "$DROPBOX" ]; then
            echo "[+] Receiving from: $DROPBOX"
            cp "$DROPBOX"/* "$RECEIVE_DIR/" 2>/dev/null
            echo "[✓] Files received to $RECEIVE_DIR"
        fi
    done
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
