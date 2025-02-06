# USDSkel

## USDSkelとは

## UsdSkelRoot
UsdSkelのレイヤーにおけるルートに
``` Python
skelRoot = UsdSkel.Root.Define(stage, "/SkelRoot")
```

``` C++
UsdSkelRoot skelRoot = UsdSkelRoot::Define(stage, SdfPath("/SkelRoot"))
```


## UsdSkelton
``` Python
skel = UsdSkel.Skeleton.Define(stage, "/SkelRoot/Skeleton")

# ToDo 各々の変数に情報を入れる
joints = []
jointsName = []
jointTransforms = []

skel.CreateJointsAttr().Set(joints)
skel.CreateJointNamesAttr().Set(jointsName)
skel.CreateRestTransformsAttr(jointTransforms)
skel.CreateBindTransformsAttr(jointTransforms)
```

``` C++
UsdSkelSkeleton skel = UsdSkelSkeleton::Define(stage, SdfPath("/SkelRoot/Skeleton"));

// ToDo 各々の変数に情報を入れる
VtArray<UsdSkelJoint> joints;
VtArray<std::string> jointsName;
VtArray<GfMatrix4d> jointTransforms;

skel.CreateJointsAttr().Set(joints);
skel.CreateJointNamesAttr().Set(jointsName);
skel.CreateRestTransformsAttr().Set(jointTransforms);
skel.CreateBindTransformsAttr().Set(jointTransforms);
```


## UsdSKelAnimation
``` Python
anim = UsdSkel.SkelAnimation.Define(stage, '/SkelRoot/Skeleton/Animation')

# ToDo 各々の変数に情報を入れる
rotations = []
translations = []
scales = []

anim.CreateRotationAttr().Set()
anim.CreateTranslationAttr().Set()
anim.CreateScaleAttr().Set()
```

``` C++
UsdSkelAnimation anim = UsdSkelAnimation::Define(stage, SdfPath("/SkelRoot/Skeleton/Animation"));

# ToDo 各々の変数に情報を入れる
VtArray<GfRotation> rotations;
VtArray<GfVec3d> translations;
VtArray<GfVec3f> scales;

anim.CreateRotationAttr().Set(rotations);
anim.CreateTranslationAttr().Set(translations);
anim.CreateScaleAttr().Set(scales);
```

## BindSkin
``` Python
skelMesh = UsdSkel.Root.Define(stage, "/SkelRoot/Mesh")
bindingApi = skelMesh.GetPrim().AddAPI(UsdSkel.BindingAPI)

# ToDo 各々の変数に情報を入れる
jointIndices = []
jointWeights = []

bindingApi.CreateJointIndicesAttr(jointIndices)
bindingApi.CreateJointWeightsAttr(jointWeights)
```

``` C++
UsdGeomMesh skelMesh = UsdGeomMesh::Define(stage, SdfPath("/SkelRoot/Mesh"));
UsdSkelBindingAPI bindingApi = skelMesh.GetPrim().AddAPI<UsdSkelBindingAPI>();

# ToDo 各々の変数に情報を入れる
VtArray<int> jointIndices;
VtArray<float> jointWeights;

bindingApi.CreateJointIndicesAttr(jointIndices);
bindingApi.CreateJointWeightsAttr(jointWeights);
```


## 参考資料
### USDSkelとは
* 公式ドキュメント  
https://openusd.org/dev/api/_usd_skel__intro.html

* 日本語解説  
https://fereria.github.io/reincarnation_tech/usd/python/usdskel

### Source
* 実装例  
https://fereria.github.io/reincarnation_tech_bk/65_SampleCode/Notebook/USD/UsdSkel/usdskel_02/  
https://fereria.github.io/reincarnation_tech_bk/65_SampleCode/Notebook/USD/UsdSkel/usdskel_01/