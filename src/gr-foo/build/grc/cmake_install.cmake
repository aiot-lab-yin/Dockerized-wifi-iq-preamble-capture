# Install script for directory: /home/yinlab/gr-block/gr-foo/grc

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gnuradio/grc/blocks" TYPE FILE FILES
    "/home/yinlab/gr-block/gr-foo/grc/foo_burst_tagger.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_packet_pad2.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_random_periodic_msg_source.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_valve.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_channel_model.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_packet_pad.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_rtt_measure.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_wireshark_connector.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_packet_dropper.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_periodic_msg_source.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_selector.block.yml"
    "/home/yinlab/gr-block/gr-foo/grc/foo_pad_tagged_stream.block.yml"
    )
endif()

