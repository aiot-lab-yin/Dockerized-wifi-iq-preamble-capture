# Wi-Fi IQ Capture System (USRP B210 + Docker + GNU Radio)

This project enables capturing Wi-Fi IQ data using a USRP B210 and saving it in CSV format. It is fully containerized using Docker, and supports both script-based capture and GNU Radio Companion (GRC) GUI operation inside the container.

---

## 🛠️ Requirements

* **Hardware:** USRP B210 with USB 3.0
* **Host OS:** Ubuntu 20.04+ (with GUI)
* **Software:** Docker, Docker Compose, X11 GUI support

---

## 📂 Project Structure

```
wifi-iq-capture/
├── Dockerfile                        # Docker image with UHD, GNU Radio, GUI support
├── docker-compose.yml                # Container config with USB, host networking, GUI
├── start_capture.sh                  # Smart startup script (interactive + rebuild flags)
├── check_usrp_permission.py          # Container-side USRP permission check
├── udev/
│   └── 90-usrp.rules                 # Host udev rule for Ettus and NI USRP
├── data/
│   └── mac_address.csv               # The MAC address of the device being collected needs to be entered.
├── src/
|   ├── gr-foo                        # A collection of custom blocks from https://github.com/bastibl/gr-foo
|   ├── gr-ieee802-11-maint-3.10      # The secondary development module gr-ieee802-11 a/p/g
|   └── gr-rftap-maint-3.10_202509m   # The secondary development module gr-rftap
├── CHANGELOG.md             # Version history (Keep a Changelog format)
└── README.md                # This document
```

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <your_repo_url>
cd wifi-iq-capture
```

### 2. Run the Startup Script

```bash
./start_capture.sh
```

### 3. Configure Target MAC Addresses
In `/data/mac_address.csv`, write the MAC addresses of the devices you want to capture in the first column, and the current number of collected samples for each device in the second column (you may initialize this value as 0).


### 4. Run GNU Radio Companion GUI

```bash
gnuradio-companion
```

Design or run `/src/gr-ieee802-11-maint-3.10/example/wifi_rx.grc` files with full GUI support.

### 5. Select the Sampling Channel

In the corresponding XXX module, select the desired Wi-Fi channel (you can confirm it via your router settings), and start the IQ sampling.

### 6. Data Storage

The collected IQ samples are stored in the Docker container under the data directory.

---

## 🔌 USRP Access Setup (Required)

To ensure the container can access the USRP B210, you **must enable USB permissions on the host**:

1. Copy the provided udev rule to your system:

```bash
sudo cp udev/90-usrp.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
```

This rule enables USB access for:
- Ettus B200/B210 (VID: 2500)
- NI USRP-2901 (VID: 3923)

2. (Optional but recommended) Install UHD on the host to enable fallback firmware access:

```bash
sudo apt install uhd-host
sudo uhd_images_downloader
```

> ✅ No need to manually run `uhd_find_devices` on the host.  
> The container will automatically attempt to upload firmware using UHD inside Docker.

> ♻️ If the device was hotplugged, simply re-run `start_capture.sh` — it will retry initialization automatically.

---

## 📜 In-Container USRP Check Script

You can verify USRP status inside the container using:

```bash
python3 check_usrp_permission.py
```

This script will detect:

- Whether a USRP device is connected
- Whether it has the correct permissions
- Whether firmware initialization succeeded

If issues are found, the script will suggest actions like:

* "Device not found or not initialized"
* "Replug the device and re-run the container"

---

## 🔧 Script Options (`start_capture.sh`)

The script supports interactive or automatic rebuild modes:

```bash
./start_capture.sh              # Prompts if image exists
./start_capture.sh --rebuild   # Forces Docker image rebuild
./start_capture.sh --no-rebuild # Skips rebuild even if image exists
```

The script also auto-enables `xhost` for GUI display forwarding and runs the container with proper USB and DISPLAY access.

---

## 🚧 Known Issues / Notes

* If GRC fails to open GUI: ensure your host has X11 and run `xhost +local:root` before starting.
* **If the USRP is plugged in after the container starts**, you must:

  * Run `uhd_find_devices` once on the host to initialize it
  * Then **restart the container** to refresh USB mapping
* CSV files can be large; use `head`, `pandas`, or plotting tools for analysis.

---

## 🔍 Useful Commands

* View USB devices: `lsusb`
* Probe USRP: `uhd_usrp_probe`
* Rebuild container manually: `./start_capture.sh --rebuild`
* Launch GUI from host: `gnuradio-companion`

---

## 🧑‍💻 Author

Developed by Yin Chen
Contributions welcome! Feel free to submit issues or pull requests
---

## 🎓 License

MIT License (or update as needed)

