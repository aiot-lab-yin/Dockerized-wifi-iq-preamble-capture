# Copyright 2018 Free Software Foundation, Inc.
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

include(CMakeFindDependencyMacro)

set(target_deps "")
foreach(dep IN LISTS target_deps)
    find_dependency(${dep})
endforeach()
include("${CMAKE_CURRENT_LIST_DIR}/gnuradio-fooTargets.cmake")
