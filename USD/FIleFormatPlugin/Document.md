## CustomSchema
CustomSchemaを用いた検証

## ToDo
■Schemaの構成
・公式TutorialSchema

#usda 1.0

//サブレイヤーの定義::「import」や「include」的な意味
(
    subLayers = [
        @usd/schema.usda@
    ]
) 

//GLOBALでPrim定義を上書き
//customDataでライブラリ情報を設定
over "GLOBAL" (
    customData = {
        string libraryName       = "usdSchemaExamples"
        string libraryPath       = "."
        string libraryPrefix     = "UsdSchemaExamples"
    }
) {
}

//schemaのクラスを定義
class "SimplePrim" (

	# 説明用のドキュメント
	doc = """An example of an untyped schema prim. Note that it does not specify a typeName"""

	# IsA schemas の定義のため</Typed>を継承する 
    inherits = </Typed>

	
    customData = {
        # C++とPythonのクラス名は分ける
        string className = "Simple"
        }
    )  
{
    int intAttr = 0 (
        doc = "An integer attribute with fallback value of 0."
    )
    rel target (
        doc = """A relationship called target that could point to another prim
        or a property"""
    )
}

# Note that it does not specify a typeName.
class ComplexPrim "ComplexPrim" (
    doc = """An example of a untyped IsA schema prim"""
    # SimplePrimを継承
    inherits = </SimplePrim>
	
	
    customData = {
        string className = "Complex"
    }
)  
{
    string complexString = "somethingComplex"
}



■Schemaの定義方法
●CodelessSchema

●Schema
## Houdini

### Solaris

## Tips
### usdGenSchemaが呼び出せない
ninja2がPythonにインストールされていないとビルドの際にusdGenSchemaがビルドされない。
下記のコマンドでpipからインストールする。
```install ninja2
pip install Jinja2
```
