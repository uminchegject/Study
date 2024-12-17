# Install script for directory: C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts")
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

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opensubdiv/far" TYPE FILE PERMISSIONS OWNER_READ GROUP_READ WORLD_READ FILES
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/error.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/patchDescriptor.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/patchParam.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/patchMap.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/patchTable.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/patchTableFactory.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/primvarRefiner.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/ptexIndices.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/stencilTable.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/stencilTableFactory.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/topologyDescriptor.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/topologyLevel.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/topologyRefiner.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/topologyRefinerFactory.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/far/types.h"
    )
endif()

