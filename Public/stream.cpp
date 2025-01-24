#include "pxr/pxr.h"
#include "stream.h"

#include "pxr/base/tf/enum.h"
#include "pxr/base/tf/stringUtils.h"
#include "pxr/base/tf/registryManager.h"

#include <map>
#include <cstdio>

using std::string;
using std::vector;
using std::map;

PXR_NAMESPACE_OPEN_SCOPE

UsdObjStream::Face::Face()
    : pointsBegin(0)
    , pointsEnd(0)
{
}

bool operator==(UsdObjStream::Face const &lhs, UsdObjStream::Face const &rhs)
{
    return lhs.pointsBegin == rhs.pointsBegin && 
        lhs.pointsEnd == rhs.pointsEnd;
}

bool operator!=(UsdObjStream::Face const &lhs, UsdObjStream::Face const &rhs)
{
    return !(lhs == rhs);
}


UsdObjStream::UsdObjStream()
{
}

////////////////////////////////////////////////////////////////////////
// Verts
int
UsdObjStream::AddVert(GfVec3f const &vert)
{
    _verts.push_back(vert);
    int index = _verts.size()-1;
    _AddVertsInternal(_verts.begin() + index);
    return index;
}

void
UsdObjStream::_AddVertsInternal(vector<GfVec3f>::iterator begin)
{
    _AddSequence(SequenceElem::Verts, std::distance(begin, _verts.end()));
}

vector<GfVec3f> const &
UsdObjStream::GetVerts() const
{
    return _verts;
}

////////////////////////////////////////////////////////////////////////
// UVs
int
UsdObjStream::AddUV(GfVec2f const &uv)
{
    _uvs.push_back(uv);
    int index = _uvs.size()-1;
    _AddUVsInternal(_uvs.begin() + index);
    return index;
}

void
UsdObjStream::_AddUVsInternal(vector<GfVec2f>::iterator begin)
{
    _AddSequence(SequenceElem::UVs, std::distance(begin, _uvs.end()));
}

vector<GfVec2f> const &
UsdObjStream::GetUVs() const {
    return _uvs;
}

////////////////////////////////////////////////////////////////////////
// Normals
int
UsdObjStream::AddNormal(GfVec3f const &normal)
{
    _normals.push_back(normal);
    int index = _normals.size()-1;
    _AddNormalsInternal(_normals.begin() + index);
    return index;
}

void
UsdObjStream::_AddNormalsInternal(vector<GfVec3f>::iterator begin)
{
    _AddSequence(SequenceElem::Normals, std::distance(begin, _normals.end()));
}

vector<GfVec3f> const &
UsdObjStream::GetNormals() const
{
    return _normals;
}

////////////////////////////////////////////////////////////////////////
// Points
void
UsdObjStream::AddPoint(Point const &point)
{
    _points.push_back(point);
}

std::vector<UsdObjStream::Point> const &
UsdObjStream::GetPoints() const
{
    return _points;
}


void
UsdObjStream::AddFace(Face const &face)
{
    // If there aren't any groups, add a default group to begin with.
    if (_groups.empty()) {
        AddGroup(string("default_mesh_0"));
    }
    _groups.back().faces.push_back(face);
}

void
UsdObjStream::clear()
{
    UsdObjStream().swap(*this);
}

void
UsdObjStream::swap(UsdObjStream &other)
{
    _verts.swap(other._verts);
    _uvs.swap(other._uvs);
    _normals.swap(other._normals);
    _points.swap(other._points);
    _comments.swap(other._comments);
    _arbitraryText.swap(other._arbitraryText);
    _groups.swap(other._groups);
    _sequence.swap(other._sequence);
}

PXR_NAMESPACE_CLOSE_SCOPE

