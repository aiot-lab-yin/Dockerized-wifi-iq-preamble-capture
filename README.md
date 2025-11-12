# Test_docker_wifi-iq-capture
Wi-Fi IQ capture system using USRP B210 (Dockerized)

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
├── Dockerfile        # Docker image with UHD, GNU Radio, GUI support
├── docker-compose.yml    # Container config with USB, host networking, GUI
├── start_capture.sh     # Smart startup script (interactive + rebuild flags)
├── check_usrp_permission.py # Container-side USRP permission check
├── udev/
│  └── 90-usrp.rules     # Host udev rule for Ettus and NI USRP
├── data/
│  ├── iq_capture.py    # Python script for capturing IQ to CSV
│  └── iq_capture.csv    # Output IQ data file (generated after capture)
├── wifi_rx.grc       # (Optional) GNU Radio flowgraph for Wi-Fi receive
├── CHANGELOG.md       # Version history (Keep a Changelog format)
└── README.md        # This document
```

---
## 🧩 1. Install Docker Components for Ubuntu （If you already have docker, please pass this step）

# Update package index and install required dependencies. 
sudo apt update 
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

### Add Docker’s official GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

### Add the official Docker repository to APT sources.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

### Install Docker Engine, CLI, Containerd, and Compose plugin.
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

### Check installed versions. Verify Docker and Compose are successfully installed.
docker --version 
docker compose version 

### Enable and start Docker service. Ensures Docker runs automatically on startup.
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker

---------------------------------------------------------------------------------------------------

## 🚀 2. First Run: Build and Enter the Container

sudo ./start_capture.sh 

- On the first run, the script automatically builds the Docker image and installs required software (takes about 5 minutes). 

- After installation, you will automatically enter the container: 
 for example: root@ hostname:/app# 
 
- Subsequent runs will directly start the container without rebuilding.


---------------------------------------------------------------------------------------------------

## 🔌 3. Enable USB / USRP Access on the Host

To allow the container to access the USRP device, configure USB permissions on the host.

### Step 1. Copy the udev rule

sudo cp udev/90-usrp.rules /etc/udev/rules.d/ 
sudo udevadm control --reload-rules 
sudo udevadm trigger 

This rule enables access for: 
- Ettus B200/B210 (VID: 2500) 
- NI USRP-2901 (VID: 3923)

### Step 2. Install UHD for firmware and image support

sudo apt install -y uhd-host 
sudo uhd_images_downloader 

✅ You do not need to manually run `uhd_find_devices` — the container automatically uploads firmware through UHD. 
♻️ If the device is hot-plugged, simply re-run `start_capture.sh`.

---------------------------------------------------------------------------------------------------

## 🧪 4. USRP Check Script

Verify device status:

python3 check_usrp_permission.py 


---------------------------------------------------------------------------------------------------

## 🧰 5. Start the Container Manually (Later Runs)

./start_capture.sh 

Once the container is ready, you’ll see: 
root@ hostname:/app# 

---------------------------------------------------------------------------------------------------

## ⚙️ 6. Capture Options (Inside Container)

### Option A. Run IQ Capture Script

cd /app/data 
python3 iq_capture.py 

Captures 10 million IQ samples from the USRP B210 and saves them to iq_capture.csv.
For example:
......
[+] Capturing 10000000 samples ...
[+] Saved 10000000 IQ samples to /app/data/iq_capture.csv

### Option B. Launch GNU Radio Companion GUI

gnuradio-companion 

You can design or execute .grc flowgraphs with full GUI support. 
*In the docker environment, the corresponding .grc programs are saved in root@ hostname:/app/src/gr-ieee802-11-maint-3.10/examples# 

---------------------------------------------------------------------------------------------------

## 🧾 7. Some Script Options (start_capture.sh)

| Command | Description |
|----------|--------------|
| ./start_capture.sh | Normal run (prompts if image exists) |
| ./start_capture.sh --rebuild | Force Docker image rebuild |
| ./start_capture.sh --no-rebuild | Skip rebuild even if image exists |

The script automatically: 
- Enables xhost for GUI display forwarding 
- Maps USB devices into the container 
- Configures DISPLAY for GUI usage 

---------------------------------------------------------------------------------------------------

## ⚠️ 8. Known Issues / Notes

- If GRC fails to open GUI: 
 xhost +local:root 
- If the USRP is plugged in after the container starts: 
 1. Run uhd_find_devices once on the host 
 2. Restart the container 
- CSV files may be large; use tools like head, pandas, or plotting libraries to analyze data.

---------------------------------------------------------------------------------------------------

## 🧭 9. Useful Commands

| Purpose | Command |
|----------|----------|
| View USB devices | lsusb |
| Probe USRP | uhd_usrp_probe |
| Rebuild container | ./start_capture.sh --rebuild |
| Launch GRC on host | gnuradio-companion |
| Copy data from container | docker cp <container_id>:/app/data ./data_out |

---------------------------------------------------------------------------------------------------

## 🧑‍💻 Author

Developed by Yin Chen
Contributions welcome! Feel free to submit issues or pull requests
---

## 🎓 License

MIT License (or update as needed)
