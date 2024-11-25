## USDPlugin
プラグインの実装方法の調査

## ToDo
* ビルドに必要な情報を調査
    * Tutorialフォルダの中身を確認
* 実装できる内容を確認

## Build手順
### CMakeLists.txtにソースを追加

### ソースの用意

### build_usd.pyでビルド


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
