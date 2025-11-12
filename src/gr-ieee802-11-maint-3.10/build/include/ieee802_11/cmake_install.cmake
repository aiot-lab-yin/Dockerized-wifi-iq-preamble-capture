# Install script for directory: /home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/ieee802_11" TYPE FILE FILES
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/api.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/chunks_to_symbols.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/constellations.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/decode_mac.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/ether_encap.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/extract_csi.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/frame_equalizer.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/mac.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/mapper.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/parse_mac.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/signal_field.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/sync_long.h"
    "/home/yinlab/下载/GUO ZEWEI/wifi-iq-capture-usb-hotplugable0930/wifi-iq-capture-usb-hotplugable/src/gr-ieee802-11-maint-3.10/include/ieee802_11/sync_short.h"
    )
endif()

