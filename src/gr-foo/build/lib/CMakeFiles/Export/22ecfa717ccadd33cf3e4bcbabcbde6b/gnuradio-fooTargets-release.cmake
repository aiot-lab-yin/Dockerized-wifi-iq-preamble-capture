#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "gnuradio::gnuradio-foo" for configuration "Release"
set_property(TARGET gnuradio::gnuradio-foo APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gnuradio::gnuradio-foo PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libgnuradio-foo.so.gcc8bfc6"
  IMPORTED_SONAME_RELEASE "libgnuradio-foo.so.1.1.0git"
  )

list(APPEND _cmake_import_check_targets gnuradio::gnuradio-foo )
list(APPEND _cmake_import_check_files_for_gnuradio::gnuradio-foo "${_IMPORT_PREFIX}/lib/libgnuradio-foo.so.gcc8bfc6" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
