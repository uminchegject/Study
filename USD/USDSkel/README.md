# USDSkel
## 概要
USDSkelにおいて下記の4つの要素が必要になってきます。
* UsdSkelRoot
* UsdSkelton
* UsdSKelAnimation
* BindSkin

## UsdSkelRoot
UsdSkelのレイヤー構築の際に管理を定義するためのルートノードです。
UsdSkelton、UsdSkelAnimationなどのUsdSkelに関連するPrimitiveのルートノードとなります。
``` Python
#SkelRootを定義
skelRoot = UsdSkel.Root.Define(stage, "/SkelRoot")
```
``` C++
//SkelRootを定義
UsdSkelRoot skelRoot = UsdSkelRoot::Define(stage, SdfPath("/SkelRoot"))
```

## UsdSkelton
UsdSkelにおけるスケルトンデータを定義するためのプリミティブです。
ボーンの階層やバインドポーズを管理します。
``` Python
#Skeltonを定義
skel = UsdSkel.Skeleton.Define(stage, "/SkelRoot/Skeleton")

#ToDo SdfPathとなるJoints（関節）属性の値を取得
joints = []
#ToDo スケルトンの各ジョイントの名前を設定
jointsName = []
#ToDo 初期ポーズ（Tポーズなど）でのジョイントの変換情報（行列） を設定
jointTransforms = []

#それぞれの値をskelのAttrに設定
skel.CreateJointsAttr().Set(joints)
skel.CreateJointNamesAttr().Set(jointsName)
skel.CreateRestTransformsAttr(jointTransforms)
skel.CreateBindTransformsAttr(jointTransforms)
```
``` C++
//Skeltonを定義
UsdSkelSkeleton skel = UsdSkelSkeleton::Define(stage, SdfPath("/SkelRoot/Skeleton"));

//ToDo SdfPathとなるJoints（関節）属性の値を取得
VtArray<UsdSkelJoint> joints;
//ToDo スケルトンの各ジョイントの名前を設定
VtArray<std::string> jointsName;
//ToDo 初期ポーズ（Tポーズなど）でのジョイントの変換情報（行列） を設定
VtArray<GfMatrix4d> jointTransforms;

//それぞれの値をskeltonのAttrに設定
skel.CreateJointsAttr().Set(joints);
skel.CreateJointNamesAttr().Set(jointsName);
skel.CreateRestTransformsAttr().Set(jointTransforms);
skel.CreateBindTransformsAttr().Set(jointTransforms);
```

## UsdSKelAnimation
UsdSkelにおけるアニメーションデータを定義するためのプリミティブです。
時間変化するボーンのトランスフォーム（回転・移動・スケール）を定義します。
``` Python
#SkeltonAnimationを定義
anim = UsdSkel.SkelAnimation.Define(stage, '/SkelRoot/Skeleton/Animation')

#ToDo 各フレームのrotationリストを設定
rotations = []
#ToDo 各フレームのtranslationリストを設定
translations = []
#ToDo 各フレームのscaleリストを設定
scales = []

#それぞれの値をSkeltonAnimationのAttrに設定
anim.CreateRotationAttr().Set()
anim.CreateTranslationAttr().Set()
anim.CreateScaleAttr().Set()
```
``` C++
//SkeltonAnimationを定義
UsdSkelAnimation anim = UsdSkelAnimation::Define(stage, SdfPath("/SkelRoot/Skeleton/Animation"));

//ToDo 各フレームのrotationリストを設定
VtArray<GfRotation> rotations;
//ToDo 各フレームのtranslationリストを設定
VtArray<GfVec3d> translations;
//ToDo 各フレームのscaleリストを設定
VtArray<GfVec3f> scales;

//それぞれの値をSkeltonAnimationのAttrに設定
anim.CreateRotationAttr().Set(rotations);
anim.CreateTranslationAttr().Set(translations);
anim.CreateScaleAttr().Set(scales);
```

## BindSkin
UsdSkelにおいてメッシュのWeight値を設定する処理です。
weight値とそのweightを反映するpointのindexを設定します。
``` Python
#Meshを定義
skelMesh = UsdSkel.Root.Define(stage, "/SkelRoot/Mesh")
#MeshにおけるBind情報の設定及び取得のためのBindAPIをMeshに設定
bindingApi = skelMesh.GetPrim().AddAPI(UsdSkel.BindingAPI)

#ToDo Weight値を設定するpointのindex情報を設定
jointIndices = []
#ToDo Weight値を設定
jointWeights = []

#それぞれの値をSkeltonAnimationのAttrに設定
bindingApi.CreateJointIndicesAttr(jointIndices)
bindingApi.CreateJointWeightsAttr(jointWeights)
```
``` C++
//Meshを定義
UsdGeomMesh skelMesh = UsdGeomMesh::Define(stage, SdfPath("/SkelRoot/Mesh"));
//#MeshにおけるBind情報の設定及び取得のためのBindAPIをMeshに設定
UsdSkelBindingAPI bindingApi = skelMesh.GetPrim().AddAPI<UsdSkelBindingAPI>();

//ToDo Weight値を設定するpointのindex情報を設定
VtArray<int> jointIndices;
//ToDo Weight値を設定
VtArray<float> jointWeights;

//それぞれの値をSkeltonAnimationのAttrに設定
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