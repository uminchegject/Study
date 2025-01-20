//
// Copyright 2016 Pixar
//
// Licensed under the terms set forth in the LICENSE.txt file available at
// https://openusd.org/license.
//
#include "pxr/pxr.h"
#include "UsdGeoFileFormat.h"

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
    std::ifstream fin(resolvedPath.c_str());
    if (!fin.is_open()) {
        TF_RUNTIME_ERROR("Failed to open file \"%s\"", resolvedPath.c_str());
        return false;
    }

    std::string line;
    while (std::getline(fin, line)) {
        if (line.find("pointattributes") != std::string::npos) {
            std::cout << "pointattributes data found: " << line << std::endl;
        }
        else if (line.find("primitives") != std::string::npos) {
            std::cout << "primitives data found: " << line << std::endl;
        }
    }

    return true;
}

PXR_NAMESPACE_CLOSE_SCOPE