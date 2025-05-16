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
        ./localdrop_usb.sh "$@"
        ;;
    serve)
        ./localdrop_server.sh
        ;;
    chat)
        ./localdrop_chat.sh
        ;;
    help|*)
        show_menu
        ;;
esac
