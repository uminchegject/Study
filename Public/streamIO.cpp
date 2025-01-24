#include "pxr/pxr.h"
#include "streamIO.h"
#include "stream.h"
#include "pxr/base/tf/stringUtils.h"

#include <algorithm>
#include <charconv>
#include <iostream>
#include <fstream>
#include <string>
#include <utility>

using std::string;
using std::vector;

PXR_NAMESPACE_OPEN_SCOPE

bool
UsdObjReadDataFromFile(std::string const &fileName,
                      UsdObjStream *stream, std::string *error)
{
    // try and open the file
    std::ifstream fin(fileName.c_str());
    if (!fin.is_open()) {
        if (error) {
            *error = TfStringPrintf("Could not open file: (%s)\n",
                                    fileName.c_str());
        }
        return false;
    }

    return UsdObjReadDataFromStream(fin, stream, error);
}

static UsdObjStream::Point
_ParsePoint(string const &str)
{
    UsdObjStream::Point result;

    int *indexes[] = {&result.vertIndex, &result.uvIndex, &result.normalIndex};
    for (int i = 0; i != numRanges; ++i) {
        if (std::from_chars(ranges[i].first, ranges[i].second, *indexes[i]).ec 
                == std::errc{}) {
            --(*indexes[i]);
        }
    }

    return result;
}

bool
UsdObjReadDataFromStream(std::istream &input,
                         UsdObjStream *stream, std::string *error)
{
    string line;
    std::istringstream lineStream;

    UsdObjStream::Group curGroup;

    while (getline(input, line)) {
        if (line.empty())
            continue;

        // check the first character for the type
        lineStream.clear();
        lineStream.str(line);

        string type;
        lineStream >> type;

        if (type == "v") {
            GfVec3f newVert;
            lineStream >> newVert[0] >> newVert[1] >> newVert[2];
            stream->AddVert(newVert);
        } else if (type == "vt") {
            GfVec2f newUV;
            lineStream >> newUV[0] >> newUV[1];
            stream->AddUV(newUV);
        } else if (type == "vn") {
            GfVec3f newNormal;
            lineStream >> newNormal[0] >> newNormal[1] >> newNormal[2];
            stream->AddNormal(newNormal);
        } else if (type == "f") {
            int pointsBegin = int(stream->GetPoints().size()), pointsEnd;
            std::string indexStr;
            while (lineStream >> indexStr)
                stream->AddPoint(_ParsePoint(indexStr));

            pointsEnd = int(stream->GetPoints().size());
            stream->AddFace(UsdObjStream::Face(pointsBegin, pointsEnd));
        } else {
            // Add arbitrary text (or comment).
            stream->AppendArbitraryText(line);
        }
    }

    return true;
}

PXR_NAMESPACE_CLOSE_SCOPE

