# GeoフォーマットにおけるFileFormatPluginの実装

## 新規プラグインの実装
### 実装の概要


### CMakeLists

``` PluginInfo.json
set(PXR_PREFIX pxr/usd)
set(PXR_PACKAGE usdGeo)

pxr_plugin(${PXR_PACKAGE}
    LIBRARIES
        tf
        gf
        sdf
        usd
        usdGeom

    INCLUDE_DIRS
        ${Boost_INCLUDE_DIRS}
        ${PYTHON_INCLUDE_DIRS}

    PUBLIC_HEADERS
        UsdGeoFileFormat.h

    PUBLIC_CLASSES
        UsdGeoFileFormat

    RESOURCE_FILES
        plugInfo.json
)
```

### PluginInfo　　
コッペパン

``` PluginInfo.json
{
    "Plugins": [
        {
            "Info": {
                "Types": {
                    "UnwritableFormat": {
                        "bases": [
                            "SdfTextFileFormat"
                        ],
                        "displayName": "Format that does not support writing",
                        "extensions": [
                            "unwritable"
                        ],
                        "supportsWriting": false,
                        "formatId": "UnwritableFormat",
                        "primary": true
                    }
                }
            }
        }
    ]
}
```


## Tips
### pch.h

## 参考資料
* Creating a File Format Plugin  
https://openusd.org/dev/api/_sdf__page__file_format_plugin.html
* USDViewのプラグイン作成チュートリアルをやろう  
https://fereria.github.io/reincarnation_tech/usd/python/usdview_plugin_01
* FileFormatPluginについて  
https://fereria.github.io/reincarnation_tech/usd/fileformat_plugin
* USD/Hydra の最新プロシージャルインタフェース  
https://qiita.com/takahito-tejima/items/01ab2abe2f4c0d12eeed#hdgp-%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E4%BD%9C%E6%88%90%E5%AE%9F%E8%A3%85