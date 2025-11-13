# Install script for directory: /home/yinlab/gr-block/gr-foo/include/foo

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/yinlab/miniforge3/envs/gr1")
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

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/home/yinlab/miniforge3/envs/gr1/bin/x86_64-conda-linux-gnu-objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/foo" TYPE FILE FILES
    "/home/yinlab/gr-block/gr-foo/include/foo/api.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/burst_tagger.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/channel_model.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/packet_dropper.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/packet_pad.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/packet_pad2.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/periodic_msg_source.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/random_periodic_msg_source.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/rtt_measure.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/wireshark_connector.h"
    "/home/yinlab/gr-block/gr-foo/include/foo/pad_tagged_stream.h"
    )
endif()

