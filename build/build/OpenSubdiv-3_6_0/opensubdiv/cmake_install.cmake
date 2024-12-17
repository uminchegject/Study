# Install script for directory: C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opensubdiv" TYPE FILE PERMISSIONS OWNER_READ GROUP_READ WORLD_READ FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/OpenSubdiv-3_6_0/opensubdiv/version.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/Debug/osdCPU.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/Release/osdCPU.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/MinSizeRel/osdCPU.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/RelWithDebInfo/osdCPU.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/Debug/osdGPU.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/Release/osdGPU.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/MinSizeRel/osdGPU.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/lib/RelWithDebInfo/osdGPU.lib")
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/opensubdiv/hbr/cmake_install.cmake")
  include("C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/opensubdiv/sdc/cmake_install.cmake")
  include("C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/opensubdiv/vtr/cmake_install.cmake")
  include("C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/opensubdiv/far/cmake_install.cmake")
  include("C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/opensubdiv/bfr/cmake_install.cmake")
  include("C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/OpenSubdiv-3_6_0/opensubdiv/osd/cmake_install.cmake")

endif()

