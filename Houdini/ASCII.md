# ASCII

## ASCIIHIPにおけるデータ構造
MIME形式に基づいたデータフォーマットで管理しているため、下記にあるソースを各情報に紐づけて複数のデータを管理しています。  
これらの情報を基にマージ作業を行うべき箇所を調べていきます。
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/box1.userdata"
Content-Type: text/plain

情報本体

```

### --HOUDINIMIMEBOUNDARY
各情報の境界を表します。  
**管理しているデータの範囲をここで確認します**
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
```

### Content-Disposition
この情報における扱いを示します
```
Content-Disposition: attachment
```

### filename
管理している情報を示す名前です。  
ノードの場合ネットワークパスを含めた名前で管理しています。  
**管理しているデータのノードをここで確認します。**
```
filename="obj/box1.parm"
```
### Content-Type
この情報の管理形式を示します。
```
Content-Type: text/plain
```

以上を踏まえて
* 差分が出ている情報の内容をfilenameで確認    
* 対応すべき情報の範囲を--HOUDINIMIMEBOUNDARYで特定  

という流れで示している情報の確認を行います。


## ASCIIHIP内のノードデータ構造
ASCIIにおけるノード情報は下記の4つで構成されています

### .init
ノードタイプ情報を管理しています。  
ノードを新しく作成するなど以外では、基本的に差分は発生しないです。

### .def
ノードに関連する設定などの情報を管理しています。  
ノードの位置や、色、ワイヤーの接続などの差分はここで発生します。  
**レイアウトやノードネットワークに関するマージやコンフリクト対応作業は基本的にこの中の差分を修正します**  

### .parm
ノードにあるパラメーター情報を管理しています。  
パラメーターだけでなく、VEXやPythonのスクリプトについても管理しているため、  
スクリプトの差分はここで発生します。  
**処理の変更に際するマージやコンフリクト対応作業は基本的にこの中の差分を修正します**  

### .userdata
開発環境に関連する情報を管理しています。  
Houdiniのバージョンや、などの差分はここで発生します。  
作業環境に変化がなければ、基本的に差分は発生しないです。

以上を踏まえて
* レイアウトやノードネットワークに関する対応は.def
* ノード処理の変更に関する対応は.parm   
* その他の情報は.init .def

という流れでノード情報の確認を行います。


## ノードのマージ
Boxノードが存在するHipにSphereノードが存在するHipをマージする対応を行います。  
マージ対応は下記のような流れになります。
* 差分が出ている情報の内容をfilenameで確認
* 対応すべき情報の範囲を--HOUDINIMIMEBOUNDARYで特定
* 対応範囲をマージ   

### 差分が出ている箇所をfilenameで確認
まず、Sphereノードが存在するHipにおいてSphereに関するアスキーの情報を探します。  
SphereノードのNetworkパスで検索をかけると、下記の4つの項目を確認することができます。
```
Content-Disposition: attachment; filename="obj/geo/sphere.init"
Content-Disposition: attachment; filename="obj/geo/sphere.def"
Content-Disposition: attachment; filename="obj/geo/sphere.parm"
Content-Disposition: attachment; filename="obj/geo/sphere.userdata"
```

### 対応すべき情報の範囲を--HOUDINIMIMEBOUNDARYで特定
次に上記4項目が示す情報の範囲を--HOUDINIMIMEBOUNDARYで確認します。  
するとASCIIHIP内のノードデータ構造で確認した4つの情報を特定することができます。
#### sphere.init
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/geo/sphere.init"
Content-Type: text/plain

type = sphere
matchesdef = 1
```
#### sphere.def
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/geo/sphere.def"
Content-Type: text/plain

sopflags sopflags = 
comment ""
position -3.17746 2.30019
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display on render on highlight off unload off savedata off compress on colordefault on exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1741570858
  modify 1741570867
  author yusuke.nakamura@CR-DD063.candrgroup.net
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
```
#### sphere.parm
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/geo/sphere.parm"
Content-Type: text/plain

{
version 0.8
type	[ 0	locks=0 ]	(	"polymesh"	)
surftype	[ 0	locks=0 ]	(	"quads"	)
rad	[ 0	locks=0 ]	(	0.5	0.5	0.5	)
t	[ 0	locks=0 ]	(	0	0	0	)
r	[ 0	locks=0 ]	(	0	0	0	)
scale	[ 0	locks=0 ]	(	10	)
orient	[ 0	locks=0 ]	(	"y"	)
freq	[ 0	locks=0 ]	(	2	)
rows	[ 0	locks=0 ]	(	13	)
cols	[ 0	locks=0 ]	(	24	)
orderu	[ 0	locks=0 ]	(	4	)
orderv	[ 0	locks=0 ]	(	4	)
imperfect	[ 0	locks=0 ]	(	"on"	)
upole	[ 0	locks=0 ]	(	"off"	)
accurate	[ 0	locks=0 ]	(	"on"	)
triangularpoles	[ 0	locks=0 ]	(	"on"	)
}
```
#### sphere.userdata
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/geo/sphere.userdata"
Content-Type: text/plain

{
	"___Version___":{
		"type":"string",
		"value":"20.5.487"
	}
}
```

### 対応範囲をマージ
上記の4つがBoxノードのアスキー情報なので、これらを別Hipにコピーを行えばマージ完了です。  
コンフリクト対応においても、コンフリクトしている箇所のfilenameから対象のノードを確認し、差分を確認した上で対応を行います。



## 参考資料
### ASCII
* ファイルとアセットをテキストとして取り扱う方法(公式)  
https://www.sidefx.com/ja/docs/houdini/assets/textfiles.html
https://www.sidefx.com/docs/houdini/assets/textfiles.html
* hip ascii and diff(サルにもわかるHoudini)  
https://ikatnek.blogspot.com/2018/02/hip-ascii-and-diff.html