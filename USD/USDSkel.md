# USDSkel
## 概要
Usd上でスケルトンとブレンドシェイプをサポートする機能としてUsdSkelがあります。  
USDSkelにおいて下記の4つの要素が必要になってきます。
* UsdSkelRoot
* UsdSkelton
* UsdSKelAnimation
* UsdMesh(SkelBindingAPI)

## UsdSkelRoot
UsdSkelのレイヤー構築の際に管理を定義するためのルートノードです。  
UsdSkelton、UsdSkelAnimationなどのUsdSkelに関連するPrimitiveのルートノードとなります。
``` C++
//SkelRootを定義
UsdSkelRoot skelRoot = UsdSkelRoot::Define(stage, SdfPath("/SkelRoot"));
//UsdSkelBindingAPIを適応
UsdSkelBindingAPI::Apply(skelRoot.GetPrim());
//Kindにcomponentを設定
skelRoot.GetPrim().SetKind(TfToken("component");)
```
Usdにおける構築結果
``` 
def SkelRoot "Model" (
    kind = "component"
    prepend apiSchemas = ["SkelBindingAPI"]
)
{

}
```

## UsdSkelton
UsdSkelにおけるスケルトンデータを定義するためのPrimです。
ジョイントの階層やバインドポーズを管理します。
``` C++
//Skeltonを定義
UsdSkelSkeleton skel = UsdSkelSkeleton::Define(stage, SdfPath("/SkelRoot/Skeleton"));
//UsdSkelBindingAPIを適応
UsdSkelBindingAPI::Apply(skel.GetPrim());

//SkelAnimationへのRelationShipを設定
UsdRelationShip skeleton_rel = mesh.GetPrim().CreateRelationship(TfToken("skel:skeleton"), true);
skeleton_rel.AddTarget(SdfPath("/SkelRoot/Skeleton"));

//パスを含めたjoint情報を管理する配列を用意
VtArray<UsdSkelJoint> joints;
//jointの名前を管理する配列を用意
VtArray<std::string> jointsName;
//Bindポーズでのジョイント行列を管理する配列を用意
VtArray<GfMatrix4d> jointTransforms;

//それぞれの値をskeltonのAttrに設定
skel.CreateJointsAttr().Set(joints);
skel.CreateJointNamesAttr().Set(jointsName);
skel.CreateRestTransformsAttr().Set(jointTransforms);
skel.CreateBindTransformsAttr().Set(jointTransforms);
```
Usdにおける構築結果
``` 
def Skeleton "Skel" (
	prepend apiSchemas = ["SkelBindingAPI"]
)
{
	#ジョイント配列
	uniform token[] joints = ["Shoulder", "Shoulder/Elbow", "Shoulder/Elbow/Hand"]
	
	#各ジョイントのbind時のTransform行列
	uniform matrix4d[] bindTransforms = [
		((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)),
		((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1)),
		((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,4,1)) 
	]

	#各ジョイントの基準行列
	uniform matrix4d[] restTransforms = [
		((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)),
		((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1)),
		((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1))
	]
	
	#SkelAnimationへのRelationShipを設定
	rel skel:animationSource = </Model/Skel/Anim>
}
```

## UsdSKelAnimation
UsdSkelにおけるアニメーションデータを定義するためのプリミティブです。
時間変化するボーンのトランスフォーム（回転・移動・スケール）を定義します。
``` C++
//SkeltonAnimationを定義
UsdSkelAnimation anim = UsdSkelAnimation::Define(stage, SdfPath("/SkelRoot/Skeleton/Animation"));

//アニメーション情報を持ったjoint情報を管理する配列を用意
VtArray<UsdSkelJoint> joints;
//特定フレームにおける各Jointの回転情報を管理する配列を用意
VtArray<GfRotation> rotations;
//特定フレームにおける各Jointのベクトル情報を管理する配列を用意
VtArray<GfVec3d> translations;
//特定フレームにおける各Jointのスケール情報を管理する配列を用意
VtArray<GfVec3f> scales;

//フレーム数を設定する
UsdTimeCode timecode(frame)

//それぞれの値をSkeltonAnimationのAttrに設定
anim.CreateJointsAttr().Set(joints, timecode);
anim.CreateRotationAttr().Set(rotations, timecode);
anim.CreateTranslationAttr().Set(translations, timecode);
anim.CreateScaleAttr().Set(scales), timecode;
```
Usdにおける構築結果
``` 
def SkelAnimation "Anim" {

	#アニメーション情報を所有しているジョイント一覧
	uniform token[] joints = ["Shoulder/Elbow"]

	#座標値のアニメーション情報
	float3[] translations = [(0,0,2)]
	#回転値のアニメーション情報
	quatf[] rotations.timeSamples = {
		1: [(1,0,0,0)],
		10: [(0.7071, 0.7071 0, 0)]
	}
	#スケール値のアニメーション情報
	half3[] scales = [(1,1,1)]
}
```

## UsdMesh(SkelBindingAPI)
UsdSkelにおいてメッシュのWeight値を設定する処理です。
weight値とそのweightを反映するpointのindexを設定します。
``` C++
//Meshを定義
UsdGeomMesh skelMesh = UsdGeomMesh::Define(stage, SdfPath("/SkelRoot/Mesh"));
//UsdSkelBindingAPIを適応
UsdSkelBindingAPI bindingApi = skelMesh.GetPrim().AddAPI<UsdSkelBindingAPI>();

//各頂点のWeight値が参照するJointのIndexを管理する配列を用意
VtArray<int> jointIndices;
//Weight値を管理する配列を用意
VtArray<float> jointWeights;

//それぞれの値をSkeltonAnimationのAttrに設定
UsdAttribute jointIndicesAttr = bindingApi.CreateJointIndicesAttr();
bindingApi.CreateJointIndicesAttr(jointIndices);
jointIndicesAttr.SetMetadata(TfToken("interpolation"), VtValue("vertex"));
jointIndicesAttr.SetMetadata(TfToken("elementSize"), VtValue("1"));

UsdAttribute jointWeightsAttr = bindingApi.CreateJointWeightsAttr();
bindingApi.CreateJointWeightsAttr(jointWeights);
jointWeightsAttr.SetMetadata(TfToken("interpolation"), VtValue("vertex"));
jointWeightsAttr.SetMetadata(TfToken("elementSize"), VtValue("1"));
```
Usdにおける構築結果
``` 
def Mesh "Arm" (
	prepend apiSchemas = ["SkelBindingAPI"]
)
{
	#スケルトンに関係ない情報は省略

	#SkeltionへのRelationShipを設定
	rel skel:skeleton = </Model/Skel>

	#各頂点のWeight値が参照するJointのIndex
	int[] primvars:skel:jointIndices = [
		2,2,2,2, 0,0,0,0, 1,1,1,1
	] (
		interpolation = "vertex"
		elementSize = 1
	)
	#各頂点のWeight値
	float[] primvars:skel:jointWeights = [
		1,1,1,1, 1,1,1,1, 1,1,1,1
	] (
		interpolation = "vertex"
		elementSize = 1
	)
}
```

## stage情報の設定
stageにフレームに関する情報を設定する
``` C++
//FPSの設定
stage->SetTimeCodesPerSecond(60);
//スタートフレームの設定
stage->SetStartTimeCode(0);
//エンドフレームの設定
stage->SetEndTimeCode(60);
```
Usdにおける構築結果
``` 
#stageに関する情報
(
    defaultPrim = "Model"
    endTimeCode = 10
    startTimeCode = 1
    metersPerUnit = .01
    upAxis = 'Y'
)
```

## 最終結果
上記の構築作業を全て行ったusdaが下記の通りになります。
``` 
#usda 1.0
#stageに関する情報
(
    defaultPrim = "Model"
    endTimeCode = 10
    startTimeCode = 1
    metersPerUnit = .01
    upAxis = 'Y'
)

#Skelに関するPrimのRootとなるSkelRootSchemaのPrim
def SkelRoot "Model" (
    kind = "component"
    prepend apiSchemas = ["SkelBindingAPI"]
)
{
	#スケルトンに関する情報を管理するSkeletonSchemaのPrim
    def Skeleton "Skel" (
        prepend apiSchemas = ["SkelBindingAPI"]
    )
    {
		#ジョイント配列
        uniform token[] joints = ["Shoulder", "Shoulder/Elbow", "Shoulder/Elbow/Hand"]
        
		#各ジョイントのbind時のTransform行列
		uniform matrix4d[] bindTransforms = [
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,4,1)) 
        ]
 
		#各ジョイントの基準行列
        uniform matrix4d[] restTransforms = [
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1))
        ]
 
		#アニメーションに関する情報を管理するSkelAnimationSchemaのPrim
        def SkelAnimation "Anim" {
		
			#アニメーション情報を所有しているジョイント一覧
            uniform token[] joints = ["Shoulder/Elbow"]
        
			#座標値のアニメーション情報
            float3[] translations = [(0,0,2)]
            #回転値のアニメーション情報
			quatf[] rotations.timeSamples = {
                1: [(1,0,0,0)],
                10: [(0.7071, 0.7071, 0, 0)]
            }
			#スケール値のアニメーション情報
            half3[] scales = [(1,1,1)]
        }
        
		#SkelAnimationへのRelationShipを設定
        rel skel:animationSource = </Model/Skel/Anim>
    }

	"メッシュ情報を管理するMeshSchemaのPrim
    def Mesh "Arm" (
        prepend apiSchemas = ["SkelBindingAPI"]
    )
    {
	   #メッシュに関する情報
       int[] faceVertexCounts = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
       int[] faceVertexIndices = [
           2, 3, 1, 0,
           6, 7, 5, 4,
           8, 9, 7, 6,
           3, 2, 9, 8,
           10, 11, 4, 5,
           0, 1, 11, 10,
           7, 9, 10, 5,
           9, 2, 0, 10,
           3, 8, 11, 1,
           8, 6, 4, 11
       ]
       point3f[] points = [
           (0.5, -0.5, 4), (-0.5, -0.5, 4), (0.5, 0.5, 4), (-0.5, 0.5, 4),
           (-0.5, -0.5, 0), (0.5, -0.5, 0), (-0.5, 0.5, 0), (0.5, 0.5, 0),
           (-0.5, 0.5, 2), (0.5, 0.5, 2), (0.5, -0.5, 2), (-0.5, -0.5, 2)
       ]
 
		#SkeltionへのRelationShipを設定
       rel skel:skeleton = </Model/Skel>
 
		#各頂点のWeight値が参照するJointのIndex
       int[] primvars:skel:jointIndices = [
           2,2,2,2, 0,0,0,0, 1,1,1,1
       ] (
           interpolation = "vertex"
           elementSize = 1
       )
	   #各頂点のWeight値
       float[] primvars:skel:jointWeights = [
           1,1,1,1, 1,1,1,1, 1,1,1,1
        ] (
           interpolation = "vertex"
           elementSize = 1
       )
	   
       matrix4d primvars:skel:geomBindTransform = ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1))
    }
}
```

## TimeSampling
時間軸で値を設定するための機能です。
値とフレームの辞書型で管理を行います。
``` Python
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
``` C++
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
* 実装例  
https://fereria.github.io/reincarnation_tech/usd/time_sampling  
https://qiita.com/snowxcrash/items/34f95c5b2367d6ba4a42  