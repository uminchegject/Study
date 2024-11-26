## USDPlugin
プラグインの実装方法の調査

## ToDo
* Tutorialフォルダの中身を確認
    * ビルドに必要な情報を調査
    * 実装できる内容を確認

## Build手順
### CMakeLists.txtにビルド対象を記載

作業フォルダにCMakeListsを配置し下記のソースを書いてビルド対象に加える
```CMakeLists.txt
add_subdirectory(作業フォルダ名)
```

### ソースの用意
PythonとC++の場合で必要なソースが変わってくる
**※一部中身を変える必要あり**
* Pythonの場合
    * Pythonソース
    * CMakeLists
* C++の場合
    * usdGenSchemaで生成したファイル
    * __init__.py
    * module.cpp
    * moduleDeps.cpp
    * CMakeLists
    * pch.h

### CMakeList.txtに読み込むソースを追加


### build_usd.pyでビルド
build_usd.pyでUSD全体をビルド


## Tips
### pxr_python_binにおけるCMakeLists
pythonからビルドをする場合のcmakeのコーディング例
```CMakeLists.txt
pxr_python_bin("Plugin名"
    DEPENDENCIES
        tf
        kind
        sdf
        usd
)
```


##　参考文献
* USDTutorial(公式)
https://openusd.org/docs/Creating-a-Usdview-Plugin.html
* USDTutorialの日本語解説
https://fereria.github.io/reincarnation_tech/usd/python/usdview_plugin_01
* PluginSystem
https://lucascheller.github.io/VFX-UsdSurvivalGuide/pages/core/plugins/overview.html