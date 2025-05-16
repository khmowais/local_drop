#!/bin/bash

USB_MOUNT="/media/ap2kmo/USB_SAMSUNG"  # Adjust as needed
DROPBOX_FOLDER_NAME="dropbox"
RECEIVE_DIR="$HOME/LocalDropReceived"

mkdir -p "$RECEIVE_DIR"

send_file() {
    echo "[*] Sending file to USB..."

    if [ ! -d "$USB_MOUNT" ]; then
        echo "[!] USB not mounted at $USB_MOUNT"
        exit 1
    fi

    DROPBOX="$USB_MOUNT/$DROPBOX_FOLDER_NAME"
    mkdir -p "$DROPBOX" || { echo "[!] Failed to create dropbox folder."; exit 1; }

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
    echo "  ./localdrop.sh usb send <file_path>"
    echo "  ./localdrop.sh usb receive"
}

# Main
case "$1" in
    send)
        if [ -f "$2" ]; then
            send_file "$2"
        else
            echo "[!] File not found: $2"
            print_help
        fi
        ;;
    receive)
        receive_files
        ;;
    *)
        print_help
        ;;
esac
