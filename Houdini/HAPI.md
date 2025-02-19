# HAPI

## Initialize
``` Initialize
// Cookによって使用されるグローバルCookオプションの生成
HAPI_CookOptions CookOptions;
CookOptions = HAPI_CookOptions_Create();

// Houdiniのセッションの生成
HAPI_Session Session;
HAPI_SessionInfo sessionInfo;
HAPI_Result result = HAPI_CreateInProcessSession(&Session, &sessionInfo);
if (!result == HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_CreateInProcessSession :: Failed!" << std::endl;
}

// 生成したCookオプションとHoudiniセッションを用いてHAPIをInitialize
HAPI_Result result = HAPI_Initialize(&Session,&CookOptions,true,-1,nullptr,nullptr,nullptr,nullptr,nullptr);
if (!result == HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_Initialize :: Failed!" << std::endl;
}
```

## Export
``` Export
//SessionをExport
HAPI_Result result = HAPI_SaveHIPFile(&Session, "../test.hip", 0);
if (!result == HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_Initialize :: Failed!" << std::endl;
}
```

## ノードの生成
セーブ終了後にメモリリークが起こる…
セーブはうまくできているが…
``` Export
//Boxノードを生成
HAPI_NodeId box_node_id;
result = HAPI_CreateNode(&Session, -1, "Sop/box", "Box_Node_Name", true, &box_node_id);
if (!result == HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_CreateNode :: Failed!" << std::endl;
}
```

## ノード情報の取得
``` ノード情報の取得
//box_nodeのノード情報を取得
HAPI_NodeInfo box_node_info;
result = HAPI_GetNodeInfo(&Session, box_node_id, &box_node_info);
if (result != HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_GetNodeInfo :: Failed!" << std::endl;
}
```

## ノード同士のをコネクト
``` ノード同士のをコネクト
//BoxノードをCopyノードに接続する接続する
result = HAPI_ConnectNodeInput(&Session, copy_node_id, 0, box_node_id, 0);
if (result != HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_ConnectNodeInput(copy_node to box_node) :: Failed!" << std::endl;
}
``` 

## パラメーターの取得(int型)
``` パラメーターの取得(int型)
//gridのrowsパラメーターの値を取得
int rows_parm_value;
HAPI_GetParmIntValue(&Session, grid_node_id, "rows", 0, &rows_parm_value);
std::cout << "grid_rows :: " << rows_parm_value << std::endl;
```

## パラメーターの設定(int型)
``` パラメーターの設定(int型)
//gridのrowsパラメーターに値を設定
rows_parm_value = 5;
result = HAPI_SetParmIntValue(&Session, grid_node_id, "rows", 0, rows_parm_value);
if (result != HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_SetParmIntValue :: Failed!" << std::endl;
}
```

## クック
ノードの処理を強制的に走らせる処理を行う。  

``` クック
//cook_node_idを強制的に実行する
result = HAPI_CookNode(&Session,cook_node_id, &CookOptions);
if (result != HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_CookNode :: Failed!" << std::endl;
}
//クック完了まで処理を止める
int cookStatus;
HAPI_Result cookResult;
do {
    cookResult = HAPI_GetStatus(&Session, HAPI_STATUS_COOK_STATE, &cookStatus);
    std::cout << "Cooking" << std::endl;
} while (cookStatus > HAPI_STATE_MAX_READY_STATE && cookResult == HAPI_RESULT_SUCCESS);
```

## ジオメトリ入力受付
ジオメトリ入力を行う  
```
//入力ノードの生成
HAPI_NodeId newNode;
HAPI_CreateInputNode(&Session, -1, &newNode, "Cube");

//メッシュ情報を設定
HAPI_PartInfo newNodePart = HAPI_PartInfo_Create();
newNodePart.type = HAPI_PARTTYPE_MESH;
newNodePart.faceCount = 6;
newNodePart.vertexCount = 24;
newNodePart.pointCount = 8;
HAPI_SetPartInfo(&Session, newNode, 0, &newNodePart);

//アトリビュート情報を設定
HAPI_AttributeInfo newNodePointInfo = HAPI_AttributeInfo_Create();
newNodePointInfo.count = 8;
newNodePointInfo.tupleSize = 3;
newNodePointInfo.exists = true;
newNodePointInfo.storage = HAPI_STORAGETYPE_FLOAT;
newNodePointInfo.owner = HAPI_ATTROWNER_POINT;
HAPI_AddAttribute(&Session, newNode, 0, "P", &newNodePointInfo);

//位置データの設定
float positions[24] = { 0.0f, 0.0f, 0.0f,   // 0
                0.0f, 0.0f, 1.0f,   // 1
                0.0f, 1.0f, 0.0f,   // 2
                0.0f, 1.0f, 1.0f,   // 3
                1.0f, 0.0f, 0.0f,   // 4
                1.0f, 0.0f, 1.0f,   // 5
                1.0f, 1.0f, 0.0f,   // 6
                1.0f, 1.0f, 1.0f }; // 7
HAPI_SetAttributeFloatData(&Session, newNode, 0, "P", &newNodePointInfo, positions, 0, 8);

//頂点情報(Vertexアトリビュート)を設定
int vertices[24] = { 0, 2, 6, 4,
            2, 3, 7, 6,
            2, 0, 1, 3,
            1, 5, 7, 3,
            5, 4, 6, 7,
            0, 4, 5, 1 };
HAPI_SetVertexList(&Session, newNode, 0, vertices, 0, 24);

//面情報の設定
int face_counts[6] = { 4, 4, 4, 4, 4, 4 };
HAPI_SetFaceCounts(&Session, newNode, 0, face_counts, 0, 6);

//ジオメトリのコミット
HAPI_CommitGeo(&Session, newNode);
```

## デジタルアセットの読み込み
```
// ロード
HAPI_AssetLibraryId assetLibId = -1;
HAPI_Result result = HAPI_LoadAssetLibraryFromFile(
    &Session, "C:/Users/jyour/Documents/houdini17.0/otls/testAsset.hdalc",
    false, &assetLibId );

//ノードの生成
HAPI_NodeId hda_node_id = -1;
result = HAPI_CreateNode(
    &Session, -1, "Sop/testAssetName",
    nullptr, true, &hda_node_id );

//デジタルアセットのパラメーター設定
HAPI_SetParmFloatValue(&Session,hda_node_id,"height",0,5.0f);
HAPI_SetParmFloatValue(&Session,hda_node_id,"elementsize",0,1.5f);
```

## 参考資料
* HAPI日本語Tutorial
https://qiita.com/jyouryuusui/items/3d86ab8e69652d5f951c