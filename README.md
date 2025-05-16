# LocalDrop

LocalDrop is a lightweight offline-first file sharing and communication system designed for local environments with poor or no internet access. It supports USB-based file transfer, local web server access, and is being extended with chat, Bluetooth, and Wi-Fi hotspot features.

---

## Features

-  **Send/Receive files via USB** — Simple CLI utility to move files using a USB drive.
-  **Local file server** — Launches a minimal web interface for non-tech users to access shared files over a browser.
-  Planned: **Peer-to-peer chat** over LAN or hotspot.
-  Planned: **Bluetooth file transfer**
-  Planned: **Mesh/Hotspot sharing system**

---

##  Project Structure

```
LocalDrop/
├── LocalDropReceived/ #Received USB files stored here
├── Shared_material/ #Files to be served on the web server
├── localdrop.sh # Master script, handles user inputs
├── localdrop_usb.sh          # Handles USB file in/out
├── localdrop_server.sh       # Launches local web server
└── README.md                 # You're reading it!
````

---

## How to Use

### 1. USB Send/Receive
```bash
./localdrop_usb.sh send <filename>
./localdrop_usb.sh receive
````

### 2. Start Local Web Server (Tech User)

```bash
./localdrop_server.sh
```

Then open `http://localhost:8080` in your browser.

### 3. Master Command (User-Friendly CLI)

```bash
./localdrop               # Shows menu and helps launch features
./localdrop send <file>   # Shortcut to send file via USB
./localdrop server        # Shortcut to start web server
```

---

## Who It's For

* Off-grid or disaster-struck communities
* Science outreach teams in remote locations
* Local teams needing private LAN file transfer
* Hackers, students, educators working on DIY networking tools

---

## Roadmap

*  Peer-to-peer chat system
*  Bluetooth support for file and text transfer
*  Wi-Fi hotspot-based mesh support
*  Web UI for browsing, uploading, chatting

---

## Contributions

Contributions are welcome — especially if you're working on low-bandwidth networking, bash scripting, or offline-first systems. Fork and open a PR!

---

## License

MIT License — use freely, contribute back if you can!
