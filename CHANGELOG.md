# Changelog

All notable changes to this project will be documented in this file.

This project follows:
- [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
- [Semantic Versioning](https://semver.org/)

---

## [Unreleased]

## [v0.3.0] - 2025-07-16

### Added
- USRP firmware auto-initialization inside container using `uhd_find_devices`
- `init_usrp_via_container.sh` with 3x retry, `lsusb` check, and filtered error output
- Docker Compose `privileged` + `devices` for USB access
- `gnuradio_prefs.conf` mounted to configure shared memory (sysv_shm)
- `check_usrp_permission.py` for in-container USRP diagnostics
- `start_capture.sh` auto-detects Docker CLI (`compose` vs `docker-compose`)
- Option parsing (`--rebuild`, `--no-rebuild`) in `start_capture.sh`
- USRP reinitialization now handled on container hotplug retry, not host
- Enhanced `.gitignore` for CSV, IQ, logs, Python cache
- Improved `README.md` with clean setup instructions and GUI notes

### Changed
- Removed host-side requirement to run `uhd_find_devices`
- Removed container-side prefs.conf creation (now host-mounted)
- Startup script no longer touches root-owned files
- Cleaned Dockerfile comments and grouped related dependencies
- Updated `README.md` to reflect in-container initialization and remove outdated host instructions

---


### Added
- Added `gnuradio_prefs.conf` to force GNU Radio to use shared memory buffer mode (`gr_vmcircbuf_sysv_shm`)
- Mounted `gnuradio_prefs.conf` into container at `/root/.gnuradio/prefs.conf` via Docker volume
- Updated `start_capture.sh` to remove redundant root-pref writing logic

### Changed
- Modified `docker-compose.yml` to include new volume mount for GNU Radio configuration



### Added
- Added GTK GUI support (`python3-gi`, `gir1.2-gtk-3.0`) in Dockerfile
- `start_capture.sh` supports `--rebuild` and `--no-rebuild`
- `.gitignore` for Python, logs, and data output
- CHANGELOG and project documentation complete

---

## [v0.2.0] - 2025-07-15

### Added
- Host-side udev rule for USRP (Ettus + NI) under `udev/90-usrp.rules`
- Container script `check_usrp_permission.py` to detect USRP and permission errors
- README instructions for USRP hotplug setup, udev rule, and container restart

### Changed
- Improved documentation and structure in `README.md`
- Enhanced troubleshooting section for USB access failures after hotplug

---

## [v1.0.0] - 2025-07-12

### Added
- Initial Dockerfile with GNU Radio and UHD
- IQ capture script `iq_capture.py`
- Working `start_capture.sh` and `docker-compose.yml`

