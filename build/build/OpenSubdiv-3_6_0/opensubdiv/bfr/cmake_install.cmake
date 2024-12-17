# Install script for directory: C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opensubdiv/bfr" TYPE FILE PERMISSIONS OWNER_READ GROUP_READ WORLD_READ FILES
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/irregularPatchType.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/limits.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/parameterization.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/refinerSurfaceFactory.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/surface.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/surfaceData.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/surfaceFactory.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/surfaceFactoryMeshAdapter.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/surfaceFactoryCache.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/tessellation.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/bfr/vertexDescriptor.h"
    )
endif()

