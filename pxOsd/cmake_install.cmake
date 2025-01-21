# Install script for directory: D:/USD/OpenUSD-release/pxr/imaging/pxOsd

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/USD/OpenUSD-DebugBuild")
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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/pxr/imaging/pxOsd" TYPE FILE FILES "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/api.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/pxr/imaging/pxOsd" TYPE FILE FILES "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/meshTopology.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/pxr/imaging/pxOsd" TYPE FILE FILES "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/meshTopologyValidation.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/pxr/imaging/pxOsd" TYPE FILE FILES "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/refinerFactory.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/pxr/imaging/pxOsd" TYPE FILE FILES "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/subdivTags.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/pxr/imaging/pxOsd" TYPE FILE FILES "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/tokens.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Debug/usd_pxOsd.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Release/usd_pxOsd.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/MinSizeRel/usd_pxOsd.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/RelWithDebInfo/usd_pxOsd.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Debug/usd_pxOsd.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Release/usd_pxOsd.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/MinSizeRel/usd_pxOsd.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/RelWithDebInfo/usd_pxOsd.dll")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE OPTIONAL FILES
      "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Debug/usd_pxOsd.pdb"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/EXPORT"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/pxrTargets"
      )
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE OPTIONAL FILES
      "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Release/usd_pxOsd.pdb"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/EXPORT"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/pxrTargets"
      )
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE OPTIONAL FILES
      "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/MinSizeRel/usd_pxOsd.pdb"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/EXPORT"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/pxrTargets"
      )
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE OPTIONAL FILES
      "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/RelWithDebInfo/usd_pxOsd.pdb"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/EXPORT"
      "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/pxrTargets"
      )
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python/pxr/PxOsd" TYPE FILE FILES
    "D:/USD/OpenUSD-release/pxr/imaging/pxOsd/__init__.py"
    "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/__init__.pyc"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python/pxr/PxOsd" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Debug/_pxOsd.pyd")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python/pxr/PxOsd" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/Release/_pxOsd.pyd")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python/pxr/PxOsd" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/MinSizeRel/_pxOsd.pyd")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python/pxr/PxOsd" TYPE SHARED_LIBRARY FILES "D:/USD/OpenUSD-DebugBuild/build/OpenUSD-release/pxr/imaging/pxOsd/RelWithDebInfo/_pxOsd.pyd")
  endif()
endif()

