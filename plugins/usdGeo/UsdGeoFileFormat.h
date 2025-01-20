#ifndef PXR_EXTRAS_PLUGINS_USD_GEO_FILE_FORMAT_H
#define PXR_EXTRAS_PLUGINS_USD_GEO_FILE_FORMAT_H

#include "pxr/pxr.h"
#include "pxr/usd/sdf/fileFormat.h"
#include "pxr/base/tf/staticTokens.h"
#include <iosfwd>
#include <string>

PXR_NAMESPACE_OPEN_SCOPE

TF_DECLARE_WEAK_AND_REF_PTRS(UsdGeoFileFormat);

#define USDGEO_FILE_FORMAT_TOKENS       \
    ((Id,      "geo"))                  \
    ((Version, "1.0"))                  \
    ((Target,  "usd"))

TF_DECLARE_PUBLIC_TOKENS(UsdGeoFileFormatTokens, USDGEO_FILE_FORMAT_TOKENS);

class UsdGeoFileFormat : public SdfFileFormat {
public:
    virtual bool CanRead(const std::string& file) const override;
    virtual bool Read(SdfLayer* layer, const std::string& resolvedPath, bool metadataOnly) const override;

protected:
    SDF_FILE_FORMAT_FACTORY_ACCESS;

    virtual ~UsdGeoFileFormat();
    UsdGeoFileFormat();

};

PXR_NAMESPACE_CLOSE_SCOPE

#endif
