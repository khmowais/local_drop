#!/bin/bash

show_menu() {
    echo "LocalDrop CLI"
    echo "Usage:"
    echo "  ./localdrop.sh usb send <file_path>"
    echo "  ./localdrop.sh usb receive"
    echo "  ./localdrop.sh serve"
    echo "  ./localdrop.sh chat"
    echo "  ./localdrop.sh help"
}

case "$1" in
    usb)
        shift
        ./scripts/localdrop_usb.sh "$@"
        ;;
    serve)
        python3 scripts/server.py
        ;;
    chat)
        ./scripts/localdrop_chat.sh
        ;;
    help|*)
        show_menu
        ;;
esac
