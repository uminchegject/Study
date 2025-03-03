# USDTutorial

## Referencing Layers
### リファレンスを用いた球体の生成
下記のusdデータをリファレンスして球体を生成する
```
def Xform "hello"
{
    double3 xformOp:translate = (4, 5, 6)
    uniform token[] xformOpOrder = ["xformOp:translate"]

    def Sphere "world"
    {
        float3[] extent = [(-2, -2, -2), (2, 2, 2)]
        color3f[] primvars:displayColor = [(0, 0, 1)]
        double radius = 2
    }
}
```

``` Python
#既存のステージを開く
stage = Usd.Stage.Open('HelloWorld.usda')
stage.Export('HelloWorld.usda')
#ステージ内のPrimを取得し、DefaultPrimに設定
hello = stage.GetPrimAtPath('/hello')
stage.SetDefaultPrim(hello)
#XformCommonAPIを使用してprimの位置を設定する
UsdGeom.XformCommonAPI(hello).SetTranslate((4, 5, 6))
stage.GetRootLayer().Save()

# 参照Stageと球体Primを定義
refStage = Usd.Stage.CreateNew('RefExample.usda')
refSphere = refStage.OverridePrim('/refSphere')

# 用意した球体PrimにHelloWorld.usdaを参照させる
refSphere.GetReferences().AddReference('./HelloWorld.usda')
refStage.GetRootLayer().Save()

# 位置をリセットする
refXform = UsdGeom.Xformable(refSphere)
refXform.SetXformOpOrder([])

# もう一つ球体Primを定義
refSphere2 = refStage.OverridePrim('/refSphere2')
refSphere2.GetReferences().AddReference('./HelloWorld.usda')
refStage.GetRootLayer().Save()

# HelloWorld.usda内のworld(球体Prim)を取得して色情報を持たせる
overSphere = UsdGeom.Sphere.Get(refStage, '/refSphere2/world' )
overSphere.GetDisplayColorAttr().Set( [(1, 0, 0)] )
refStage.GetRootLayer().Save()
```

## Simple Shading in USD
### メッシュの構築
``` Python
# ステージの定義
stage = Usd.Stage.CreateNew("simpleShading.usda")
UsdGeom.SetStageUpAxis(stage, UsdGeom.Tokens.y)

# ルートの定義
modelRoot = UsdGeom.Xform.Define(stage, "/TexModel")
Usd.ModelAPI(modelRoot).SetKind(Kind.Tokens.component)

# メッシュの定義
billboard = UsdGeom.Mesh.Define(stage, "/TexModel/card")
billboard.CreatePointsAttr([(-430, -145, 0), (430, -145, 0), (430, 145, 0), (-430, 145, 0)])
billboard.CreateFaceVertexCountsAttr([4])
billboard.CreateFaceVertexIndicesAttr([0,1,2,3])
billboard.CreateExtentAttr([(-430, -145, 0), (430, 145, 0)])
texCoords = UsdGeom.PrimvarsAPI(billboard).CreatePrimvar("st",
                                    Sdf.ValueTypeNames.TexCoord2fArray,
                                    UsdGeom.Tokens.varying)
texCoords.Set([(0, 0), (1, 0), (1,1), (0, 1)])
```

### マテリアルの構築
``` Python
# マテリアルの定義
material = UsdShade.Material.Define(stage, '/TexModel/boardMat')

# プライマリ変数の設定
stInput = material.CreateInput('frame:stPrimvarName', Sdf.ValueTypeNames.Token)
stInput.Set('st')

# PBRシェーダーの作成し設定
pbrShader = UsdShade.Shader.Define(stage, '/TexModel/boardMat/PBRShader')
pbrShader.CreateIdAttr("UsdPreviewSurface")
pbrShader.CreateInput("roughness", Sdf.ValueTypeNames.Float).Set(0.4)
pbrShader.CreateInput("metallic", Sdf.ValueTypeNames.Float).Set(0.0)
# materialにpbrShaderを設定する
material.CreateSurfaceOutput().ConnectToSource(pbrShader.ConnectableAPI(), "surface")

# テクスチャ座標を取得するシェーダー
stReader = UsdShade.Shader.Define(stage, '/TexModel/boardMat/stReader')
stReader.CreateIdAttr('UsdPrimvarReader_float2')
stReader.CreateInput('varname',Sdf.ValueTypeNames.String).ConnectToSource(stInput)

# ディフューズテクスチャの設定
diffuseTextureSampler = UsdShade.Shader.Define(stage,'/TexModel/boardMat/diffuseTexture')
diffuseTextureSampler.CreateIdAttr('UsdUVTexture')
diffuseTextureSampler.CreateInput('file', Sdf.ValueTypeNames.Asset).Set("USDLogoLrg.png")
#pbrShaderでstのInputを生成し、stReaderを設定する
diffuseTextureSampler.CreateInput("st", Sdf.ValueTypeNames.Float2).ConnectToSource(stReader.ConnectableAPI(), 'result')
diffuseTextureSampler.CreateInput("wrapS", Sdf.ValueTypeNames.Token).Set("repeat")
diffuseTextureSampler.CreateInput("wrapT", Sdf.ValueTypeNames.Token).Set("repeat")
diffuseTextureSampler.CreateOutput('rgb', Sdf.ValueTypeNames.Float3)
#pbrShaderでdiffuseColorのInputを生成し、diffuseTextureSamplerを設定する
pbrShader.CreateInput("diffuseColor", Sdf.ValueTypeNames.Color3f).ConnectToSource(diffuseTextureSampler.ConnectableAPI(), 'rgb')

# マテリアルの適用
billboard.GetPrim().ApplyAPI(UsdShade.MaterialBindingAPI)
UsdShade.MaterialBindingAPI(billboard).Bind(material)
```

## snowxcrashさんのTutorial
### メッシュの構築
``` Python
mesh = UsdGeom.Mesh.Define(stage, path)

# Points
vList = []
vList.append((-1, 0, 0))
vList.append(( 0, 0, 0))
vList.append(( 1, 0, 0))
vList.append((-1, 1, 0))
vList.append(( 0, 1, 0))
vList.append(( 1, 1, 0))
mesh.CreatePointsAttr(vList)

# FaceVertexCounts
fList = [] 
fList.append(4)
fList.append(4)
mesh.CreateFaceVertexCountsAttr(fList)

# FaceVertexIndices
fList = []
fList.extend((0, 1, 4, 3))
fList.extend((1, 2, 5, 4))
mesh.CreateFaceVertexIndicesAttr(fList)

# DisplayColor
vList = []
vList.append((1, 0, 0))  # Red
vList.append((0, 1, 0))  # Green
vList.append((0, 0, 1))  # Blue
vList.append((1, 1, 0))  # Yellow
vList.append((1, 1, 1))  # White
vList.append((1, 0, 1))  # Magenta
primvar_api = UsdGeom.PrimvarsAPI(mesh)
primvar = primvar_api.CreatePrimvar('displayColor', Sdf.ValueTypeNames.Color3f, interpolation=UsdGeom.Tokens.varying)
primvar.GetAttr().Set(vList)

# DoubleSided
mesh.CreateDoubleSidedAttr(False)
```

### シェーダーの構築
``` Python
shader = UsdShade.Shader.Define(stage, path)
# シェーダータイプを設定する
shader.CreateIdAttr('UsdPreviewSurface')
# 各々の値を設定する
shader.CreateInput('metallic', Sdf.ValueTypeNames.Float).Set(0.0)
shader.CreateInput('roughness', Sdf.ValueTypeNames.Float).Set(0.4)
shader.CreateInput('diffuseColor', Sdf.ValueTypeNames.Color3f).Set(Gf.Vec3f(1, 0, 1))
shader.CreateInput('opacity', Sdf.ValueTypeNames.Float).Set(1)
```

### マテリアルの設定
``` Python
material = UsdShade.Material.Define(stage, path)
# マテリアルのサーフェス出力を作成
material.CreateSurfaceOutput()
# シェーダーをマテリアルに接続
material.GetSurfaceOutput().ConnectToSource(shader.ConnectableAPI(), 'surface')
```

### テクスチャリーダーを用意
``` Python
uvtexture = UsdShade.Shader.Define(stage, path)
uvtexture.CreateIdAttr('UsdUVTexture')

# pngパス(input)
uvtexture.CreateInput('file', Sdf.ValueTypeNames.Asset).Set('./USDLogoLrg.png')
# uv(input)
uvtexture.CreateInput('st', Sdf.ValueTypeNames.Float2)

# rgb(output)
uvtexture.CreateOutput('rgb', Sdf.ValueTypeNames.Float3)
# alpha(output)
uvtexture.CreateOutput('a', Sdf.ValueTypeNames.Float)
```

### プリミティブ変数リーダーの生成
``` Python
primvarReader = UsdShade.Shader.Define(stage, path)
primvarReader.CreateIdAttr('UsdPrimvarReader_float2')

# Inputs
primvarReader.CreateInput('varname', Sdf.ValueTypeNames.String)
# Outputs
primvarReader.CreateOutput('result', Sdf.ValueTypeNames.Float2)
```

### メッシュへのUV情報の設定
``` Python
# UV
uvList = []
uvList.append((0, 0))
uvList.append((1, 0))
uvList.append((1, 1))
uvList.append((0, 1))
uvList.append((0, 0))
uvList.append((1, 0))
uvList.append((1, 1))
uvList.append((0, 1))

primvar_api = UsdGeom.PrimvarsAPI(mesh)
primvar = primvar_api.CreatePrimvar('st', Sdf.ValueTypeNames.TexCoord2fArray, interpolation=UsdGeom.Tokens.faceVarying)
primvar.GetAttr().Set(uvList)

uvIndexList = []
uvIndexList.extend((0, 1, 2, 3))
uvIndexList.extend((5, 6, 7, 4))

primvar.SetIndices(uvIndexList)
```

## 参考資料
### 公式Tutorial
* https://openusd.org/release/tut_usd_tutorials.html

### snowxcrashさんのTutorial
* https://qiita.com/snowxcrash