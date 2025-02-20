# USDSkel
## 概要
Usd上でスケルトンとブレンドシェイプをサポートする機能としてUsdSkelがあります。  
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

//ToDo SdfPathとなるJoints（関節）属性の値を取得
VtArray<UsdSkelJoint> joints;
//ToDo 各フレームのrotationリストを設定
VtArray<GfRotation> rotations;
//ToDo 各フレームのtranslationリストを設定
VtArray<GfVec3d> translations;
//ToDo 各フレームのscaleリストを設定
VtArray<GfVec3f> scales;


//それぞれの値をSkeltonAnimationのAttrに設定
anim.CreateJointsAttr().Set(joints);
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

## TimeSampling
時間軸で値を設定するための機能です。
値とフレームの辞書型で管理を行います。
``` TimeSampling
from pxr import Usd, Sdf

stage = Usd.Stage.CreateNew('TimeSample.usda')
stage.SetTimeCodesPerSecond(30)
stage.SetStartTimeCode(1)
stage.SetEndTimeCode(30)

prim = stage.DefinePrim("/samplePrim")
attr = prim.CreateAttribute('sampleValue',Sdf.ValueTypeNames.Float)
attr.Set(1,1)
attr.Set(10,10)

stage.GetRootLayer().Save()
``` 

## ジョイント構築
Jointに必要な情報をクラス化
* ローカル座標
* ワールド座標
* ローカル回転値
* 親ジョイント
```
struct Joint 
{
    GfVec3f m_local_position;
    GfQuatf m_local_rotation;
    Joint* m_parent;

	// ワールド座標とワールド回転を求める関数
	void calculateWorldTransform(GfVec3f& world_position, GfQuatf& world_rotation) {
		if (joint == nullptr) return;

		// ルートジョイントの場合、ワールド座標とワールド回転はローカルの値と同じ
		if (m_parent == nullptr) {
			world_position = m_local_position;
			world_rotation = m_local_rotation;
		} else {
			// 親ジョイントのワールド座標と回転を取得
			GfVec3f m_parentworld_position;
			GfQuatf m_parentworld_rotation;
			calculateWorldTransform(m_parent, m_parentworld_position, m_parentworld_rotation);

			// 親ジョイントのワールド座標と回転を使って現在のワールド座標を計算
			world_position = m_parentworld_position + m_parentworld_rotation * m_local_position;
			world_rotation = m_parentworld_rotation * m_local_rotation;
		}
	}
};
```

ジョイントを構築する処理
```
//ルートジョイント
Joint root;
root.localPosition = GfVec3f(0, 0, 0);
root.localRotation = pxr::GfQuatf::Identity();
root.parent = nullptr;
root.computeWorldTransform();

// 子ジョイント
Joint child;
child.localPosition = GfVec3f(0, 1, 0); 
child.localRotation = pxr::GfQuatf rotation(pxr::GfRotationf(pxr::GfVec3f(0, 0, 1), M_PI / 4));
child.parent = &root;
child.computeWorldTransform();
```

## 参考資料
### USDSkelとは
* 公式ドキュメント  
https://openusd.org/dev/api/_usd_skel__intro.html  
https://openusd.org/dev/api/_usd_skel__schemas.html#UsdSkel_Skeleton

* 日本語解説  
https://fereria.github.io/reincarnation_tech/usd/python/usdskel

### Source
* 実装例  
https://fereria.github.io/reincarnation_tech_bk/65_SampleCode/Notebook/USD/UsdSkel/usdskel_02/  
https://fereria.github.io/reincarnation_tech_bk/65_SampleCode/Notebook/USD/UsdSkel/usdskel_01/

### TimeSampling
https://fereria.github.io/reincarnation_tech/usd/time_sampling
https://qiita.com/snowxcrash/items/34f95c5b2367d6ba4a42