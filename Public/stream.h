
#ifndef PXR_EXTRAS_USD_EXAMPLES_USD_OBJ_STREAM_H
#define PXR_EXTRAS_USD_EXAMPLES_USD_OBJ_STREAM_H

#include "pxr/pxr.h"
#include "pxr/base/gf/vec2f.h"
#include "pxr/base/gf/vec3f.h"

#include <string>
#include <vector>

PXR_NAMESPACE_OPEN_SCOPE


class UsdShjStream
{
public:

    struct Point {
        int vertIndex;
        int uvIndex;
        int normalIndex;

        /// Default constructor leaves all indexes invalid.
        Point() : vertIndex(-1), uvIndex(-1), normalIndex(-1) {}

        /// Construct with indexes \a v, \a uv, and \a n.
        Point(int v, int uv, int n)
            : vertIndex(v), uvIndex(uv), normalIndex(n) {}
    };


    struct Face {
        int pointsBegin;
        int pointsEnd;

        /// Default constructor leaves range == [0, 0).
        Face();

        /// Construct with range specified by [\a begin, \a end).
        Face(int begin, int end) : pointsBegin(begin), pointsEnd(end) {}

        /// Return the number of points in this face.
        inline int size() const { return pointsEnd - pointsBegin; }

        /// Return true if \a lhs has the same range as \a rhs.
        friend bool operator==(Face const &lhs, Face const &rhs);

        /// Return true if \a lhs has a different range from \a rhs.
        friend bool operator!=(Face const &lhs, Face const &rhs);
    };

    /// Construct with an optional epsilon value.
    explicit UsdObjStream();

    /// Clear the contents of this data object.  Leaves no verts, uvs, points,
    /// or groups.
    void clear();

    /// Swap the contents of this data object with \a other.
    void swap(UsdObjStream &other);

    ////////////////////////////////////////////////////////////////////////
    // Verts

    /// Unconditionally add \a vert and return the new index.
    int AddVert(GfVec3f const &vert);

    /// Add a range of vertices.
    template <class Iter>
    void AddVerts(Iter begin, Iter end) {
        size_t oldSize = _verts.size();
        _verts.insert(_verts.end(), begin, end);
        _AddVertsInternal(_verts.begin() + oldSize);
    }

    /// Return a const reference to the verts in this data object.
    std::vector<GfVec3f> const &GetVerts() const;

    ////////////////////////////////////////////////////////////////////////
    // UVs

    /// Unconditionally add \a UV and return the new index.
    int AddUV(GfVec2f const &uv);

    /// Add a range of UVs.
    template <class Iter>
    void AddUVs(Iter begin, Iter end) {
        size_t oldSize = _uvs.size();
        _uvs.insert(_uvs.end(), begin, end);
        _AddUVsInternal(_uvs.begin() + oldSize);
    }

    /// Return a const reference to the UVs in this data object.
    std::vector<GfVec2f> const &GetUVs() const;

    ////////////////////////////////////////////////////////////////////////
    // Normals

    /// Unconditionally add \a normal and return the new index.
    int AddNormal(GfVec3f const &normal);

    /// Add a range of normals.
    template <class Iter>
    void AddNormals(Iter begin, Iter end) {
        size_t oldSize = _normals.size();
        _normals.insert(_normals.end(), begin, end);
        _AddNormalsInternal(_normals.begin() + oldSize);
    }

    /// Return a const reference to the normals in this data object.
    std::vector<GfVec3f> const &GetNormals() const;

    ////////////////////////////////////////////////////////////////////////
    // Points

    /// Add a single point.
    void AddPoint(Point const &point);

    /// Add a range of points.
    template <class Iter>
    void AddPoints(Iter begin, Iter end) {
        _points.insert(_points.end(), begin, end);
    }

    /// Return a const reference to the points in this data object.
    std::vector<Point> const &GetPoints() const;

    ////////////////////////////////////////////////////////////////////////


private:

    // Data members storing geometry.
    std::vector<GfVec3f> _verts;
    std::vector<GfVec2f> _uvs;
    std::vector<GfVec3f> _normals;
    std::vector<Point> _points;
};



PXR_NAMESPACE_CLOSE_SCOPE

#endif // PXR_EXTRAS_USD_EXAMPLES_USD_OBJ_STREAM_H
