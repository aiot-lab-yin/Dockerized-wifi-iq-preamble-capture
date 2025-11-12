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
├── Dockerfile                # Docker image with UHD, GNU Radio, GUI support
├── docker-compose.yml       # Container config with USB, host networking, GUI
├── start_capture.sh         # Smart startup script (interactive + rebuild flags)
├── check_usrp_permission.py # Container-side USRP permission check
├── udev/
│   └── 90-usrp.rules         # Host udev rule for Ettus and NI USRP
├── data/
│   ├── iq_capture.py        # Python script for capturing IQ to CSV
│   └── iq_capture.csv       # Output IQ data file (generated after capture)
├── wifi_rx.grc              # (Optional) GNU Radio flowgraph for Wi-Fi receive
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

### 3. Inside the Container

#### Option A: Run IQ Capture Script

```bash
cd /app/data
python3 iq_capture.py
```

This captures 10M IQ samples from USRP B210 and saves them to `iq_capture.csv`.

#### Option B: Run GNU Radio Companion GUI

```bash
gnuradio-companion
```

Design or run `.grc` files with full GUI support.

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

