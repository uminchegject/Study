
#ifndef PXR_EXTRAS_USD_EXAMPLES_USD_OBJ_STREAM_H
#define PXR_EXTRAS_USD_EXAMPLES_USD_OBJ_STREAM_H

#include "pxr/pxr.h"
#include "pxr/base/gf/vec2f.h"
#include "pxr/base/gf/vec3f.h"
#include "pxr/usd/sdf/layer.h"

#include <string>
#include <vector>

PXR_NAMESPACE_OPEN_SCOPE

class Geometry
{
public:

    void ReadGeometry(const std::string& filePath);

    SdfLayerRefPtr CreateLayer()
    {
        SdfLayerRefPtr layer = SdfLayer::CreateAnonymous(".usda");
        return layer;
    };

private:



    std::vector<GfVec3f> m_extent;
    std::vector<GfVec3f> m_points;
    std::vector<GfVec3f> m_normals;
    std::vector<int> m_face_vertex_counts;
    std::vector<int> m_face_vertex_indices;
    std::string m_name;
};

PXR_NAMESPACE_CLOSE_SCOPE

#endif
