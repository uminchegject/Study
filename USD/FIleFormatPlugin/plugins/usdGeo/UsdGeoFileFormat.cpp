//
// Copyright 2016 Pixar
//
// Licensed under the terms set forth in the LICENSE.txt file available at
// https://openusd.org/license.
//
#include "pxr/pxr.h"
#include "UsdGeoFileFormat.h"
#include "Geometry.h"

#include "pxr/usd/usd/usdaFileFormat.h"
#include "pxr/usd/sdf/layer.h"

#include "pxr/base/tf/fileUtils.h"
#include "pxr/base/tf/registryManager.h"

#include <fstream>
#include <string>

PXR_NAMESPACE_OPEN_SCOPE

using std::string;

TF_DEFINE_PUBLIC_TOKENS(
    UsdGeoFileFormatTokens, 
    USDGEO_FILE_FORMAT_TOKENS);

TF_REGISTRY_FUNCTION(TfType)
{
    SDF_DEFINE_FILE_FORMAT(UsdGeoFileFormat, SdfFileFormat);
}

UsdGeoFileFormat::UsdGeoFileFormat()
    : SdfFileFormat(
        UsdGeoFileFormatTokens->Id,
        UsdGeoFileFormatTokens->Version,
        UsdGeoFileFormatTokens->Target,
        UsdGeoFileFormatTokens->Id)
{
}

UsdGeoFileFormat::~UsdGeoFileFormat()
{
}

bool 
UsdGeoFileFormat::CanRead(const string& file) const
{
    return true;
}

bool UsdGeoFileFormat::Read(
    SdfLayer* layer,
    const string& resolvedPath,
    bool metadataOnly) const
{
    //Geometry geo;
    //geo.ReadGeometry(resolvedPath);
    return true;
}

PXR_NAMESPACE_CLOSE_SCOPE