# FileFormatPlugin
## 概要
新規プラグインの実装においては下記のファイルを用意する必要があります。
* CMakeLists.txt  
* PluginInfo.json  
* Class SdfFileFormat
* その他のソース 

これらを用意し、Open_USDのプロジェクトソース内の任意の場所に配置してビルドを行うことでプラグインをビルドすることができます。
公式のTutorialにあるObjフォーマットをサポートしたFileFormatPluginのプロジェクトを参考に説明します

## CMakeLists
ビルド内容をまとめるCMakeListsです。パッケージの実装においては主に下記の2つを行います。
* PXR_PACKAGEにパッケージ名を設定する
* カスタム関数のpxr_pluginで使用するソースの情報をまとめる
``` 
set(PXR_PREFIX pxr/usd)
set(PXR_PACKAGE usdObj)

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

    CPPFILES
        fileFormat.cpp #SdfFileFormatクラスをオーバーライドしたクラス
        #その他追加で実装したソース
        stream.cpp
        streamIO.cpp
        translator.cpp

    RESOURCE_FILES
        plugInfo.json
)
```


## PluginInfo　　
プラグインの情報をまとめるJsonです。
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
                    "UsdObjFileFormat": {
                        "bases": [
                            "SdfFileFormat"
                        ],
                        "displayName": "USD Tutorial Rudimentary OBJ",
                        "extensions": [
                            "obj"
                        ],
                        "formatId": "obj",
                        "primary": true,
                        "supportsWriting": false,
                        "target": "usd"
                    }
                }
            },
            // プラグインのビルドデータに関する情報をまとめます
            "LibraryPath": "@PLUG_INFO_LIBRARY_PATH@",
            "Name": "usdObj",
            "ResourcePath": "@PLUG_INFO_RESOURCE_PATH@",
            "Root": "@PLUG_INFO_ROOT@",
            "Type": "library"
        }
    ]
}
```
## SdfFileFormatクラス
### SdfFileFormatクラスの下記の2つの処理をOverrideして読み込み処理を実装します
```
virtual bool Read(
    SdfLayer* layer,
    const std::string &	resolvedPath,
    bool metadataOnly 
)const

virtual bool ReadFromString(
    SdfLayer* layer, 
    const std::string& str
) const
```
### SdfFileFormatクラスの下記の2つの処理をOverrideして書き込み処理を実装します
```
virtual bool WriteToString(
    const SdfLayer& layer,
    std::string* str,
    const std::string& comment=std::string()
)const

virtual bool WriteToStream(
    const SdfSpecHandle &spec,
    std::ostream& out,
    size_t indent
)const
```

## その他のソース
Objフォーマットから情報を取得し、Usd上でレイヤーを構築する処理するためのソースが下記のような形であります。
* translator.cpp
* stream.cpp
* streamIO.cpp

その中でもUsd上でレイヤーを構築するtranslator.cppが重要になってきます。


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