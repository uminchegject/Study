# USDTutorial

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
### snowxcrashさんのTutorial
* https://qiita.com/snowxcrash