# GeoフォーマットにおけるFileFormatPluginの実装

## 実装の概要
新規プラグインの実装においては下記の3つのファイルを用意する必要があります。
* プラグインのソース  
* CMakeLists.txt  
* PluginInfo.json  
* FileFormatPlugin.h
* FileFormatPlugin.cpp

これらを用意し、Open_USDのプロジェクトソース内の任意の場所に配置してビルドを行うことでプラグインをビルドすることができます。

## CMakeLists
ビルド内容をまとめるCMakeListsです。パッケージの実装においては主に下記の2つを行います。
* PXR_PACKAGEにパッケージ名を設定する
* カスタム関数のpxr_pluginで使用するソースの情報をまとめる

``` CMakeLists
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
プラグインの情報をまとめるJsonです。今回実装するFileFormatPluginを例にすると、  
* サポートするフォーマット形式に関する情報
* ビルドした際のプラグイン周りのデータに関する情報
などをJSONでまとめます。

``` PluginInfo.json
{
    "Plugins": [
        {
            // プラグインの中身に関する情報をまとめます
            "Info": {
                "Types": {
                    "UsdGeoFileFormat": {
                        "bases": [
                            "SdfFileFormat"
                        ],
                        "displayName": "Geo Text File Format Plugin",
                        "extensions": [
                            "geo"
                        ],
                        "formatId": "geo",
                        "primary": true,
                        "supportsWriting": false,
                        "target": "usd"
                    }
                }
            },
            // プラグインのビルドデータに関する情報をまとめます
            "LibraryPath": "@PLUG_INFO_LIBRARY_PATH@",
            "Name": "usdGeo",
            "ResourcePath": "@PLUG_INFO_RESOURCE_PATH@",
            "Root": "@PLUG_INFO_ROOT@",
            "Type": "library"
        }
    ]
}
```

## FileFormatPlugin
Geometryファイルはアスキーのため文字列から情報を取得し、usdのレイヤーを構築する
``` 

```

## Geometry

### Geoフォーマットからの情報取得処理
``` ReadGeometry
void Geometry::ReadGeometry(const std::string& filePath)
{
 
}
```

### Geometryの情報を基にLayerを構築する
``` CreateLayer
SdfLayerRefPtr CreateLayer()
{
    
}
```

## 参考資料
### 新規プラグインの実装
* Creating a File Format Plugin  
https://openusd.org/dev/api/_sdf__page__file_format_plugin.html
* USDViewのプラグイン作成チュートリアルをやろう  
https://fereria.github.io/reincarnation_tech/usd/python/usdview_plugin_01
* FileFormatPluginについて  
https://fereria.github.io/reincarnation_tech/usd/fileformat_plugin
* USD/Hydra の最新プロシージャルインタフェース  
https://qiita.com/takahito-tejima/items/01ab2abe2f4c0d12eeed#hdgp-%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E4%BD%9C%E6%88%90%E5%AE%9F%E8%A3%85