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


## 参考資料
* HAPI日本語Tutorial
https://qiita.com/jyouryuusui/items/3d86ab8e69652d5f951c