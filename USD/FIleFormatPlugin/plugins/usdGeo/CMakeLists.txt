set(PXR_PREFIX pxr/usd)
set(PXR_PACKAGE usdGeo)

pxr_plugin(${PXR_PACKAGE}
    LIBRARIES
        tf
        gf
        sdf
        usd
        usdGeom

    INCLUDE_DIRS
        ${Boost_INCLUDE_DIRS}
        ${PYTHON_INCLUDE_DIRS}
        "C:/Program Files/Side Effects Software/Houdini 20.5.410/toolkit/include/HAPI"

    CPPFILES
        Geometry.cpp
        UsdGeoFileFormat.cpp

    RESOURCE_FILES
        plugInfo.json
)

target_link_libraries(${PXR_PACKAGE} 
    "C:/Program Files/Side Effects Software/Houdini 20.5.410/custom/houdini/dsolib/libHAPIL.lib"
)