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

## Traversing a Stage
### ステージからPrimをTraverseする処理
``` Python
# stage内のPrimを全て照らし合わせる
stage = Usd.Stage.Open("RefExample.usda")
assert([x for x in stage.Traverse()] == [stage.GetPrimAtPath("/refSphere"), 
    stage.GetPrimAtPath("/refSphere/world"), stage.GetPrimAtPath("/refSphere2"), 
    stage.GetPrimAtPath("/refSphere2/world")])

# stage内のPrimの中で、sphere型のジオメトリを照らし合わせる
assert([x for x in stage.Traverse() if UsdGeom.Sphere(x)] == 
        [stage.GetPrimAtPath("/refSphere/world"), 
         stage.GetPrimAtPath("/refSphere2/world")])

# Primパスのイテレーターを取得
treeIter = iter(Usd.PrimRange.PreAndPostVisit(stage.GetPseudoRoot()))
# リストを用意
treeIterExpectedResults = [(stage.GetPrimAtPath("/"), False),
        (stage.GetPrimAtPath("/refSphere"), False),
        (stage.GetPrimAtPath("/refSphere/world"), False),
        (stage.GetPrimAtPath("/refSphere/world"), True),
        (stage.GetPrimAtPath("/refSphere"), True),
        (stage.GetPrimAtPath("/refSphere2"), False),
        (stage.GetPrimAtPath("/refSphere2/world"), False),
        (stage.GetPrimAtPath("/refSphere2/world"), True),
        (stage.GetPrimAtPath("/refSphere2"), True),
        (stage.GetPrimAtPath("/"), True)]
# イテレーターとリストをそれぞれ照らし合わせる
treeIterActualResults = [(x, treeIter.IsPostVisit()) for x in treeIter]
assert treeIterExpectedResults == treeIterActualResults

# 特定Primを非アクティブにして照らし合わせる
ref2Prim = stage.GetPrimAtPath('/refSphere2')
# stageのSessionLayerを編集ターゲットに設定
stage.SetEditTarget(stage.GetSessionLayer())
# ref2Primを非アクティブにする
Usd.Prim.SetActive(ref2Prim, False)
# アクティブなPrimのみを照らし合わせる
assert ([x for x in stage.Traverse()] == [stage.GetPrimAtPath("/refSphere"), 
stage.GetPrimAtPath("/refSphere/world")])
```

## Authoring Variants
バリアントを設定することで切り替えを簡単に行えるようにする
### 元データ
```plaintext
def Xform "hello"
{
    custom double3 xformOp:translate = (4, 5, 6)
    uniform token[] xformOpOrder = ["xformOp:translate"]

    def Sphere "world"
    {
        float3[] extent = [(-2, -2, -2), (2, 2, 2)]
        color3f[] primvars:displayColor = [(0, 0, 1)]
        double radius = 2
    }
}
```
### ソース
``` Python
stage = Usd.Stage.Open('HelloWorld.usda')

# カラー値をリセット
colorAttr = UsdGeom.Gprim.Get(stage, '/hello/world').GetDisplayColorAttr()
colorAttr.Clear()

# Variantを定義
rootPrim = stage.GetPrimAtPath('/hello')
vset = rootPrim.GetVariantSets().AddVariantSet('shadingVariant')

# 定義したVariantに種類を設定
vset.AddVariant('red')
vset.AddVariant('blue')
vset.AddVariant('green')

# それぞれの種類に値を設定
vset.SetVariantSelection('red')
with vset.GetVariantEditContext():
    colorAttr.Set([(1,0,0)])
vset.SetVariantSelection('blue')
with vset.GetVariantEditContext():
    colorAttr.Set([(0,0,1)])
vset.SetVariantSelection('green')
with vset.GetVariantEditContext():
    colorAttr.Set([(0,1,0)])

stage.GetRootLayer().Export('HelloWorldWithVariants.usda')
```
### 実行結果
```plaintext
def Xform "hello" (
    # variantの初期値
    variants = {
        string shadingVariant = "green"
    }
    # 定義したVariant
    prepend variantSets = "shadingVariant"
)
{
    custom double3 xformOp:translate = (4, 5, 6)
    uniform token[] xformOpOrder = ["xformOp:translate"]

    def Sphere "world"
    {
        float3[] extent = [(-2, -2, -2), (2, 2, 2)]
        # カラー値をリセット
        color3f[] primvars:displayColor
        double radius = 2
    }

    #各Variantの種類ごとに値が設定されている
    variantSet "shadingVariant" = {
        "blue" {
            over "world"
            {
                color3f[] primvars:displayColor = [(0, 0, 1)]
            }

        }
        "green" {
            over "world"
            {
                color3f[] primvars:displayColor = [(0, 1, 0)]
            }

        }
        "red" {
            over "world"
            {
                color3f[] primvars:displayColor = [(1, 0, 0)]
            }

        }
    }
}
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

## Transformations, Time-sampled Animation, and Layer Offsets

### Python
```python

from pxr import Usd, UsdGeom, Gf, Sdf

#ステージの定義
def MakeInitialStage(path):
    stage = Usd.Stage.CreateNew(path)
    UsdGeom.SetStageUpAxis(stage, UsdGeom.Tokens.z)
    #スタート時のタイムコードを設定
    stage.SetStartTimeCode(0)
    #エンド時のタイムコードを設定
    stage.SetEndTimeCode(192)
    return stage

#ジオメトリへの参照を追加
def AddReferenceToGeometry(stage, path):
    geom = UsdGeom.Xform.Define(stage, path)
    #top.geom.usdを参照
    geom.GetPrim().GetReferences().AddReference('./top.geom.usd')
    return geom

#スピンを追加
def AddSpin(top):
    spin = top.AddRotateZOp(opSuffix='spin')
    #スピンのTimeCodeと値を設定
    spin.Set(time=0, value=0)
    spin.Set(time=192, value=1440)

#傾きを追加
def AddTilt(top):
    tilt = top.AddRotateXOp(opSuffix='tilt')
    tilt.Set(value=12)

#オフセットを追加
def AddOffset(top):
    top.AddTranslateOp(opSuffix='offset').Set(value=(0, 0.1, 0))

#回転運動を追加
def AddPrecession(top):
    precess = top.AddRotateZOp(opSuffix='precess')
    precess.Set(time=0, value=0)
    precess.Set(time=192, value=360)

#コマ単体のアニメーション情報レイヤーを作成
def CreateBaseAnimationData():
    stage = MakeInitialStage('BaseAnimation.usda')
    stage.SetMetadata('comment', 'BaseAnimation: Adding precession and offset')
    top = AddReferenceToGeometry(stage, '/Top')
    AddPrecession(top)
    AddOffset(top)
    AddTilt(top)
    AddSpin(top)
    stage.Save()

if __name__ == '__main__':
    # Use animated layer from BaseAnimation
    CreateBaseAnimationData()
    anim_layer_path = './BaseAnimation.usda'

    stage = MakeInitialStage('AnimatedTop.usda')
    stage.SetMetadata('comment', 'AnimatedTop: Layer offsets and animation')

    #コマをそのまま配置
    left = UsdGeom.Xform.Define(stage, '/Left')
    left_top = UsdGeom.Xform.Define(stage, '/Left/Top')
    left_top.GetPrim().GetReferences().AddReference(
        assetPath = anim_layer_path,
        primPath = '/Top')

    #位置をズラし、フレームを96ズラしたコマを配置
    middle = UsdGeom.Xform.Define(stage, '/Middle')
    middle.AddTranslateOp().Set(value=(2, 0, 0))
    middle_top = UsdGeom.Xform.Define(stage, '/Middle/Top')
    middle_top.GetPrim().GetReferences().AddReference(
        assetPath = anim_layer_path,
        primPath = '/Top',
        layerOffset = Sdf.LayerOffset(offset=96))

    #位置をズラし、FPSを4倍にしたコマを配置
    right = UsdGeom.Xform.Define(stage, '/Right')
    right.AddTranslateOp().Set(value=(4, 0, 0))
    right_top = UsdGeom.Xform.Define(stage, '/Right/Top')
    right_top.GetPrim().GetReferences().AddReference(
        assetPath = anim_layer_path,
        primPath = '/Top',
        layerOffset = Sdf.LayerOffset(scale=0.25))

    stage.Save()
```

### usda
BaseAnimation
``` python
#usda 1.0
(
    endTimeCode = 192
    startTimeCode = 0
    upAxis = "Z"
)

def Xform "Top" (
    #メッシュ情報をリファレンスする
    prepend references = @./top.geom.usd@
)
{
    #傾き角度
    float xformOp:rotateX:tilt = 12
    #コマが傾きながら回転する際の運動情報
    float xformOp:rotateZ:precess.timeSamples = {
        0: 0,
        192: 360,
    }
    #コマ自体の回転運動情報
    float xformOp:rotateZ:spin.timeSamples = {
        0: 0,
        192: 1440,
    }
    double3 xformOp:translate:offset = (0, 0.1, 0)
    #配列内の順序で変換を行う
    uniform token[] xformOpOrder = ["xformOp:rotateZ:precess", "xformOp:translate:offset", "xformOp:rotateX:tilt", "xformOp:rotateZ:spin"]
}
```
AnimatedTop
```plaintext
#usda 1.0
(
    endTimeCode = 192
    startTimeCode = 0
    upAxis = "Z"
)
そのままリファレンスしたコマ
def Xform "Left"
{
    def Xform "Top" (
        prepend references = @./BaseAnimation.usda@</Top>
    )
    {
    }
}

#位置をズラし、フレームを96ズラしたコマ
def Xform "Middle"
{
    double3 xformOp:translate = (2, 0, 0)
    uniform token[] xformOpOrder = ["xformOp:translate"]

    def Xform "Top" (
        prepend references = @./BaseAnimation.usda@</Top> (offset = 96)
    )
    {
    }
}

#位置をズラし、FPSを4倍にしたコマ
def Xform "Right"
{
    double3 xformOp:translate = (4, 0, 0)
    uniform token[] xformOpOrder = ["xformOp:translate"]

    def Xform "Top" (
        prepend references = @./BaseAnimation.usda@</Top> (scale = 0.25)
    )
    {
    }
}
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