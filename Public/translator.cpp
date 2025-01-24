//
// Copyright 2016 Pixar
//
// Licensed under the terms set forth in the LICENSE.txt file available at
// https://openusd.org/license.
//
#include "pxr/pxr.h"
#include "translator.h"
#include "stream.h"

#include "pxr/usd/sdf/layer.h"
#include "pxr/usd/sdf/path.h"
#include "pxr/usd/usd/stage.h"
#include "pxr/usd/usdGeom/mesh.h"
#include "pxr/usd/usdGeom/primvarsAPI.h"
#include "pxr/base/vt/array.h"

#include "pxr/base/gf/range3f.h"

PXR_NAMESPACE_OPEN_SCOPE


SdfLayerRefPtr
UsdObjTranslateObjToUsd(const UsdObjStream &objStream)
{
    // Create the layer to populate.
    SdfLayerRefPtr layer = SdfLayer::CreateAnonymous(".usda");

    // Create a UsdStage with that root layer.
    UsdStageRefPtr stage = UsdStage::Open(layer);

	// Create a mesh for the group.
	UsdGeomMesh mesh =　UsdGeomMesh::Define(stage, SdfPath("/" + ));

	// Populate the mesh data from the obj data.  This is not a very smart
	// importer.  We throw all the verts onto everything for simplicity.  If
	// this was a proper obj importer, it would reindex verts per-group.
	mesh.GetPointsAttr().Set(usdPoints);

	VtArray<int> faceVertexCounts, faceVertexIndices, faceUVIndices;
	for (const auto& face : group.faces) {
		faceVertexCounts.push_back(face.size());
		for (int p = face.pointsBegin; p != face.pointsEnd; ++p) {
			faceVertexIndices.push_back(objPoints[p].vertIndex);
			if (objPoints[p].uvIndex >= 0) {
				faceUVIndices.push_back(objPoints[p].uvIndex);
			}
		}
	}

	// Now set the attributes.
	mesh.GetFaceVertexCountsAttr().Set(faceVertexCounts);
	mesh.GetFaceVertexIndicesAttr().Set(faceVertexIndices);

	// Create a primvar for the UVs if stored in the obj data. Note that
	// it's valid in this layer for the UV mapping to not be fully defined
	// in the obj data. For example, this layer may just provide the texture
	// coordinates and another layer the indexing, or vice versa.
	if (!usdUVs.empty() || !faceUVIndices.empty()) {
		UsdGeomPrimvar uvPrimVar = UsdGeomPrimvarsAPI(mesh).CreatePrimvar(
		TfToken("uv"), SdfValueTypeNames->TexCoord2fArray,
		UsdGeomTokens->faceVarying);
		if (!usdUVs.empty()) {
			uvPrimVar.GetAttr().Set(usdUVs);
		}
		if (!faceUVIndices.empty()) {
			uvPrimVar.CreateIndicesAttr().Set(faceUVIndices); // indexed
		}
	}

	// Set extent.
	mesh.GetExtentAttr().Set(extentArray);
    }

    return layer;
}

PXR_NAMESPACE_CLOSE_SCOPE
