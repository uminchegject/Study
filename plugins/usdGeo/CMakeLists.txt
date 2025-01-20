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

    PUBLIC_HEADERS
        UsdGeoFileFormat.h

    PUBLIC_CLASSES
        UsdGeoFileFormat

    RESOURCE_FILES
        plugInfo.json
)

