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
``` Export
//Boxノードを生成
HAPI_NodeId box_node_id;
result = HAPI_CreateNode(&Session, -1, "Sop/box", "Box_Node_Name", true, &box_node_id);
if (!result == HAPI_RESULT_SUCCESS)
{
    std::cout << "HAPI_CreateNode :: Failed!" << std::endl;
}
```

## 参考資料
* HAPI日本語Tutorial
https://qiita.com/jyouryuusui/items/3d86ab8e69652d5f951c