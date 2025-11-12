#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "gnuradio::gnuradio-ieee802_11" for configuration "Release"
set_property(TARGET gnuradio::gnuradio-ieee802_11 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gnuradio::gnuradio-ieee802_11 PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/x86_64-linux-gnu/libgnuradio-ieee802_11.so.v1.1-compat-xxx-xunknown"
  IMPORTED_SONAME_RELEASE "libgnuradio-ieee802_11.so.1.1.0git"
  )

list(APPEND _IMPORT_CHECK_TARGETS gnuradio::gnuradio-ieee802_11 )
list(APPEND _IMPORT_CHECK_FILES_FOR_gnuradio::gnuradio-ieee802_11 "${_IMPORT_PREFIX}/lib/x86_64-linux-gnu/libgnuradio-ieee802_11.so.v1.1-compat-xxx-xunknown" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
