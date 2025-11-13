#!/usr/bin/env python3

import uhd
import numpy as np

# ----------------------------------------
# Create USRP object and configure settings
# ----------------------------------------

usrp = uhd.usrp.MultiUSRP()  # Create a USRP device handle

# RF configuration
center_freq = 2.412e9       # Wi-Fi Channel 1 (2.412 GHz)
sample_rate = 10e6          # 10 MS/s
gain = 30                   # Gain in dB
duration = 1.0              # Duration of capture in seconds
num_samps = int(sample_rate * duration)

# Apply configuration
usrp.set_rx_rate(sample_rate)
usrp.set_rx_freq(uhd.types.TuneRequest(center_freq))
usrp.set_rx_gain(gain)
usrp.set_time_now(uhd.types.TimeSpec(0.0))

# ----------------------------------------
# Set up RX streamer
# ----------------------------------------

st_args = uhd.usrp.StreamArgs("fc32", "sc16")  # fc32: complex float32 samples
streamer = usrp.get_rx_stream(st_args)
recv_buffer = np.zeros((num_samps,), dtype=np.complex64)

# Prepare metadata and stream command
md = uhd.types.RXMetadata()
stream_cmd = uhd.types.StreamCMD(uhd.types.StreamMode.num_done)
stream_cmd.num_samps = num_samps
stream_cmd.stream_now = True
streamer.issue_stream_cmd(stream_cmd)

# ----------------------------------------
# Start receiving samples
# ----------------------------------------

print(f"[+] Capturing {num_samps} samples ...")
num_rx = streamer.recv(recv_buffer, md, timeout=5.0)

# ----------------------------------------
# Save to CSV (real, imag)
# ----------------------------------------

output_path = "/app/data/iq_capture.csv"
np.savetxt(output_path, np.column_stack((recv_buffer.real, recv_buffer.imag)), delimiter=",")
print(f"[+] Saved {num_rx} IQ samples to {output_path}")

