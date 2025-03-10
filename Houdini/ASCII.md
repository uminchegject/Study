# ASCII

## 情報を管理する構造体
下記にあるソースのようにMIME形式に基づいたデータフォーマットで、複数のデータをアスキー形式で管理しています。  
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

という流れでマージ対応を行って行きます。

## ノードのマージ
Boxノードが存在するHipにSphereノードが存在するHipをマージする対応を行います。
大まかな流れとしては
* 差分が出ている情報の内容をfilenameで確認
* 対応すべき情報の範囲を--HOUDINIMIMEBOUNDARYで特定
* 対応範囲をマージ
という流れとなります。

### 差分が出ている箇所をfilenameで確認
まず、Sphereノードが存在するHipにおいてSphereに関するアスキーの情報を探します。
SphereノードのNetworkパスはobj/box_geo2/sphere1のためパスで検索をかけます。
すると下記の4つの項目を確認することができます。

```
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.init"
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.def"
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.parm"
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.userdata"
```


### 対応すべき情報の範囲を--HOUDINIMIMEBOUNDARYで特定
次に上記4項目が示す情報の範囲を--HOUDINIMIMEBOUNDARYで確認します。
すると下記の4を特定することができます。

```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.init"
Content-Type: text/plain

type = sphere
matchesdef = 1
```

```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.def"
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

```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.parm"
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

```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/box_geo2/sphere1.userdata"
Content-Type: text/plain

{
	"___Version___":{
		"type":"string",
		"value":"20.5.487"
	}
}
```

### 対応範囲をマージ
上記の4つのアスキー情報を別Hipにコピーを行えばマージ完了です。  
コンフリクト対応においても、コンフリクトしている箇所のfilenameから対象のノードを確認し、
差分を確認した上で対応を行う流れで大丈夫かと思われます。


## マージ対応において不必要な情報
差分確認の際に作業内容とは関係ない差分が出てしまうことがありました。
その際に確認した情報をまとめています。

### .variables
ファイルに関する基本情報です。  
SAVETIMEなど何もしなくても情報が更新されてしまい、差分が出てしまうためマージは不要です。

```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename=".variables"
Content-Type: text/plain

set -g ACTIVETAKE = 'Main'
set -g E = '2.7182818284590452354'
set -g EYE = 'stereo'
set -g HIP = 'C:/Users/yusuke.nakamura/Desktop/Hip'
set -g HIPFILE = 'C:/Users/yusuke.nakamura/Desktop/Hip/Box.hip'
set -g HIPNAME = 'Box'
set -g JOB = 'C:/Users/yusuke.nakamura'
set -g PI = '3.1415926535897932384'
set -g POSE = 'C:/Users/yusuke.nakamura/Documents/houdini20.5/poselib'
set -g _HIP_SAVEPLATFORM = 'windows-x86_64-cl19.35'
set -g _HIP_SAVETIME = 'Fri Mar  7 12:25:08 2025'
set -g _HIP_SAVEVERSION = '20.5.487'
set -g status = '0'
```

### .OPdummydefs
MIMEのbase64というデータの変換方法でエンコードしている情報です。  
Content-Typeもアスキーでなくバイナリで管理していることを示しており、スクリプトとしてのマージ対応が行えません。
ここの差分に変更があった場合は元のデータを優先する対応を行います。
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename=".OPdummydefs"
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64

バイナリ情報

```

### stat
各ノードに関する作成・更新情報を管理しています。  
ノードの中身に変更がなくてもここだけ更新されてしまい、差分が出てしまうことがあるため、  
そのような場合は基本的にここの差分は更新しなくても大丈夫です。
```
stat
{
  create 1741570858
  modify 1741570867
  author yusuke.nakamura@CR-DD063.candrgroup.net
  access 0777
}
```


## 参考資料
### ASCII
* ファイルとアセットをテキストとして取り扱う方法(公式)  
https://www.sidefx.com/ja/docs/houdini/assets/textfiles.html
https://www.sidefx.com/docs/houdini/assets/textfiles.html
* hip ascii and diff(サルにもわかるHoudini)  
https://ikatnek.blogspot.com/2018/02/hip-ascii-and-diff.html