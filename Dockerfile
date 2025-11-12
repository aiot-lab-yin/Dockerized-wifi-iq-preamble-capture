# Base image: Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Disable interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# Install all required packages
# RUN apt-get update && apt-get install -y \
#     gnuradio \                    
#     uhd-host \                    
#     python3 \                     
#     python3-pip \                 
#     python3-uhd \                 
#     net-tools \                   
#     iputils-ping \               
#     gr-osmosdr \                 
#     gnuradio-dev \               
#     dbus-x11 \                   
#     libgtk-3-0 \                 
#     usbutils \                   
#     udev \                       
#     python3-gi \                 
#     gir1.2-gtk-3.0 \
#     libsndfile-dev \
#     git \
#     doxygen \
#     libuhd-dev \
#     build-essential \
#     cmake && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*
# Add PPA for GNU Radio 3.9
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:gnuradio/gnuradio-releases && \
    apt-get update && apt-get install -y \
    gnuradio=3.10.* \
    gnuradio-dev=3.10.* \
    uhd-host \
    libuhd-dev \
    python3 \
    python3-pip \
    python3-uhd \
    gr-osmosdr \
    net-tools \
    iputils-ping \
    libsndfile-dev \
    dbus-x11 \
    libgtk-3-0 \
    usbutils \
    udev \
    git \
    doxygen \
    python3-gi \
    gir1.2-gtk-3.0 \
    build-essential \
    cmake && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download USRP FPGA/firmware images
RUN uhd_images_downloader

# Copy your source folder into the container
COPY src/ /app/src/

# Build and install source code.
# Build gr-foo
WORKDIR /app/src/gr-foo
RUN rm -rf build && mkdir build && cd build && \
    cmake .. && make -j$(nproc) && make install && ldconfig

# Build gr-ieee802-11-maint-3.10
WORKDIR /app/src/gr-ieee802-11-maint-3.10
RUN rm -rf build && mkdir build && cd build && \
    cmake .. && make -j$(nproc) && make install && ldconfig


# Build gr-rftap-maint-3.10_202509m
WORKDIR /app/src/gr-rftap-maint-3.10_202509m
RUN rm -rf build && mkdir build && cd build && \
    cmake .. && make -j$(nproc) && make install && ldconfig

# Set working directory
WORKDIR /app

# Default command
CMD ["/bin/bash"]

