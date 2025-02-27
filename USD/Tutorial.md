# USDTutorial

## Simple Shading in USD
### メッシュの構築
``` Python
from pxr import Gf, Kind, Sdf, Usd, UsdGeom, UsdShade

stage = Usd.Stage.CreateNew("simpleShading.usda")
UsdGeom.SetStageUpAxis(stage, UsdGeom.Tokens.y)

modelRoot = UsdGeom.Xform.Define(stage, "/TexModel")
Usd.ModelAPI(modelRoot).SetKind(Kind.Tokens.component)

billboard = UsdGeom.Mesh.Define(stage, "/TexModel/card")
billboard.CreatePointsAttr([(-430, -145, 0), (430, -145, 0), (430, 145, 0), (-430, 145, 0)])
billboard.CreateFaceVertexCountsAttr([4])
billboard.CreateFaceVertexIndicesAttr([0,1,2,3])
billboard.CreateExtentAttr([(-430, -145, 0), (430, 145, 0)])
texCoords = UsdGeom.PrimvarsAPI(billboard).CreatePrimvar("st",
                                    Sdf.ValueTypeNames.TexCoord2fArray,
                                    UsdGeom.Tokens.varying)
texCoords.Set([(0, 0), (1, 0), (1,1), (0, 1)])

stage.Save()
```

### マテリアルの構築
``` Python
 Now make a Material that contains a PBR preview surface, a texture reader,
# and a primvar reader to fetch the texture coordinate from the geometry
material = UsdShade.Material.Define(stage, '/TexModel/boardMat')
stInput = material.CreateInput('frame:stPrimvarName', Sdf.ValueTypeNames.Token)
stInput.Set('st')

# Create surface, and connect the Material's surface output to the surface 
# shader.  Make the surface non-metallic, and somewhat rough, so it doesn't
# glare in usdview's simple camera light setup.
pbrShader = UsdShade.Shader.Define(stage, '/TexModel/boardMat/PBRShader')
pbrShader.CreateIdAttr("UsdPreviewSurface")
pbrShader.CreateInput("roughness", Sdf.ValueTypeNames.Float).Set(0.4)
pbrShader.CreateInput("metallic", Sdf.ValueTypeNames.Float).Set(0.0)

material.CreateSurfaceOutput().ConnectToSource(pbrShader.ConnectableAPI(), "surface")

# create texture coordinate reader 
stReader = UsdShade.Shader.Define(stage, '/TexModel/boardMat/stReader')
stReader.CreateIdAttr('UsdPrimvarReader_float2')
# Note here we are connecting the shader's input to the material's 
# "public interface" attribute. This allows users to change the primvar name
# on the material itself without drilling inside to examine shader nodes.
stReader.CreateInput('varname',Sdf.ValueTypeNames.String).ConnectToSource(stInput)

# diffuse texture
diffuseTextureSampler = UsdShade.Shader.Define(stage,'/TexModel/boardMat/diffuseTexture')
diffuseTextureSampler.CreateIdAttr('UsdUVTexture')
diffuseTextureSampler.CreateInput('file', Sdf.ValueTypeNames.Asset).Set("USDLogoLrg.png")
diffuseTextureSampler.CreateInput("st", Sdf.ValueTypeNames.Float2).ConnectToSource(stReader.ConnectableAPI(), 'result')
diffuseTextureSampler.CreateInput("wrapS", Sdf.ValueTypeNames.Token).Set("repeat")
diffuseTextureSampler.CreateInput("wrapT", Sdf.ValueTypeNames.Token).Set("repeat")
diffuseTextureSampler.CreateOutput('rgb', Sdf.ValueTypeNames.Float3)
pbrShader.CreateInput("diffuseColor", Sdf.ValueTypeNames.Color3f).ConnectToSource(diffuseTextureSampler.ConnectableAPI(), 'rgb')

# Now bind the Material to the card
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