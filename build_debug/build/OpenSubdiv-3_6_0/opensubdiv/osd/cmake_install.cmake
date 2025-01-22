# Install script for directory: D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/USD/build_debug")
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
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/bufferDescriptor.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuEvaluator.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuPatchTable.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuVertexBuffer.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/mesh.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/nonCopyable.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/opengl.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/types.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/patchBasisTypes.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/patchBasis.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/cpuGLVertexBuffer.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/glLegacyGregoryPatchTable.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/glPatchTable.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/glVertexBuffer.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/glMesh.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/glslPatchShaderSource.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/glXFBEvaluator.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/osd/glComputeEvaluator.h"
    )
endif()

