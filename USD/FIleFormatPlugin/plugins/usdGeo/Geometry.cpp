//
// Copyright 2016 Pixar
//
// Licensed under the terms set forth in the LICENSE.txt file available at
// https://openusd.org/license.
//
#include "pxr/pxr.h"
#include "Geometry.h"

#include "HAPI.h"
#include "HAPI_Common.h"

using std::string;
using std::vector;

#include <iostream>
#include <fstream>
#include <sstream>

PXR_NAMESPACE_OPEN_SCOPE

void Geometry::ReadGeometry(const std::string& filePath)
{
    HAPI_Result result;

    HAPI_Session Session;
    HAPI_CookOptions CookOptions;
    HAPI_SessionInfo sessionInfo;
    CookOptions = HAPI_CookOptions_Create();
    HAPI_CreateInProcessSession(&Session, &sessionInfo);
    HAPI_Initialize(&Session,&CookOptions,true,-1,nullptr,nullptr,nullptr,nullptr,nullptr);   

    //HAPI_NodeId geo_nodeId;
    //result = HAPI_CreateNode(&Session, -1, "Sop/box", "Box_Node_Name", true, &geo_nodeId);
    //if (result)
    //{
    //    std::cout << "SUCCESS!!" << std::endl;
    //}
    //else
    //{
    //    std::cout << "Failed!!" << std::endl;
    //}

    //std::string geo_path = "C:/Users/yusuke.nakamura/Desktop/box_geo.geo";
    //result = HAPI_LoadGeoFromFile(&Session, geo_nodeId, filePath.c_str());

    //HAPI_GeoInfo geoInfo;
    //result = HAPI_GetGeoInfo(&Session, geo_nodeId, &geoInfo);

    //HAPI_NodeId part_nodeId;
    //result = HAPI_CreateNode(&Session, -1, "Sop/box", "Box_Node_Name", true, &part_nodeId);

    //HAPI_PartInfo part_info;
    //HAPI_GetPartInfo(&Session, part_nodeId, 0, &part_info);
    //std::cout << "Point Count: " << part_info.pointCount << std::endl;

}

PXR_NAMESPACE_CLOSE_SCOPE

