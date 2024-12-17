# Install script for directory: C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore

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
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/lib/Debug/MaterialXCore.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/lib/Release/MaterialXCore.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/lib/MinSizeRel/MaterialXCore.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/lib/RelWithDebInfo/MaterialXCore.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/bin/Debug/MaterialXCore.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/bin/Release/MaterialXCore.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/bin/MinSizeRel/MaterialXCore.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/bin/RelWithDebInfo/MaterialXCore.dll")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/MaterialXCore" TYPE FILE FILES
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/source/MaterialXCore/Generated.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Definition.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Document.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Element.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Exception.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Export.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Geom.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Interface.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Library.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Look.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Material.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Node.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Property.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Traversal.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Types.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Unit.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Util.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Value.h"
    "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/src/MaterialX-1.38.10/source/MaterialXCore/Variant.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE OPTIONAL FILES "C:/Users/yusuke.nakamura/Desktop/OpenUSD/OpenUSD-release/build_scripts/build/MaterialX-1.38.10/source/MaterialXCore/Release/MaterialXCore.pdb")
endif()

