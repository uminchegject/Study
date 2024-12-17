# Install script for directory: C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opensubdiv/osd" TYPE FILE PERMISSIONS OWNER_READ GROUP_READ WORLD_READ FILES
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/bufferDescriptor.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuEvaluator.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuPatchTable.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuVertexBuffer.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/mesh.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/nonCopyable.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/opengl.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/types.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/patchBasisTypes.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/patchBasis.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuGLVertexBuffer.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/glLegacyGregoryPatchTable.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/glPatchTable.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/glVertexBuffer.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/glMesh.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/glslPatchShaderSource.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/glXFBEvaluator.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/osd/glComputeEvaluator.h"
    )
endif()

