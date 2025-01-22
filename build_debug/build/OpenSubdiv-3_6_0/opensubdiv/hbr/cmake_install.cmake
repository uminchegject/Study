# Install script for directory: D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opensubdiv/hbr" TYPE FILE PERMISSIONS OWNER_READ GROUP_READ WORLD_READ FILES
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/allocator.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/bilinear.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/catmark.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/cornerEdit.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/creaseEdit.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/faceEdit.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/face.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/fvarData.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/fvarEdit.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/halfedge.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/hierarchicalEdit.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/holeEdit.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/loop.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/mesh.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/subdivision.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/vertexEdit.h"
    "D:/USD/build_debug/src/OpenSubdiv-3_6_0/opensubdiv/hbr/vertex.h"
    )
endif()

