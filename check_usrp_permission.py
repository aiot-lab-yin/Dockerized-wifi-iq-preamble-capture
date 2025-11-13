import subprocess

def has_permission_and_presence():
    try:
        # Try to run uhd_find_devices and capture stdout+stderr
        out = subprocess.check_output(
            ["uhd_find_devices"],
            stderr=subprocess.STDOUT
        ).decode()

        if "Device Address" in out:
            print("✅ USRP is connected and accessible.")
        else:
            print("❌ No USRP device found.")
            print("📎 Hint: check USB cable and udev rules.")
    except subprocess.CalledProcessError as e:
        output = e.output.decode()
        if "USB open failed: insufficient permissions" in output:
            print("⚠️  USRP detected but access is denied.")
            print("👉  Ensure the host has the proper udev rules installed.")
            print("🔁  Then restart the container to refresh USB mapping.")
            print("💡  Alternatively, run `uhd_find_devices` once on the host to initialize the device.")
        else:
            print("❌ UHD error:\n", output)

if __name__ == "__main__":
    has_permission_and_presence()

