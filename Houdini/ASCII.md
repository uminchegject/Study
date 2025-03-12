# ASCII

## ASCIIHIPにおけるデータ構造
MIME形式に基づいたデータフォーマットで管理するため、下記にあるソースを各情報に紐づけて複数のデータを管理しています。  
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
大まかな流れとしては
* 差分が出ている情報の内容をfilenameで確認
* 対応すべき情報の範囲を--HOUDINIMIMEBOUNDARYで特定
* 対応範囲をマージ   

という流れとなります。

### 差分が出ている箇所をfilenameで確認
まず、Sphereノードが存在するHipにおいてSphereに関するアスキーの情報を探します。
SphereノードのNetworkパスはobj/geo/sphereのためパスで検索をかけます。
すると下記の4つの項目を確認することができます。
```
Content-Disposition: attachment; filename="obj/geo/sphere.init"
Content-Disposition: attachment; filename="obj/geo/sphere.def"
Content-Disposition: attachment; filename="obj/geo/sphere.parm"
Content-Disposition: attachment; filename="obj/geo/sphere.userdata"
```

### 対応すべき情報の範囲を--HOUDINIMIMEBOUNDARYで特定
次に上記4項目が示す情報の範囲を--HOUDINIMIMEBOUNDARYで確認します。
すると下記の4つを特定することができます。
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
上記の4つのアスキー情報を別Hipにコピーを行えばマージ完了です。  
コンフリクト対応においても、コンフリクトしている箇所のfilenameから対象のノードを確認し、差分を確認した上で対応を行います。


## マージ対応における注意点
マージ作業において、注意すべき情報をまとめています。

### .variables
ファイルに関する基本情報です。  
SAVETIMEなど何もしなくても情報が更新されてしまい、差分が出てしまうためマージ対応は不要です。

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
Content-Typeもアスキーでなくバイナリで管理していることを示しており、アスキーとしてのマージ対応が行えません。  
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
ノードの中身に変更がなくてもここだけ更新されてしまい差分が出てしまうことがあるため、その場合はマージ対応は不要です。
```
stat
{
  create 1741570858
  modify 1741570867
  author yusuke.nakamura@CR-DD063.candrgroup.net
  access 0777
}
```

### .application
HIPデータ内のシーン情報などを管理しています。  
シーンの画角や保存した際に選択していたノードに違いがあった場合などで差分が発生してしまうことがあるため、  
その場合はマージ対応は不要です。
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename=".application"
Content-Type: text/plain

panepath -d Build2 -f -p panetab14 /obj/geo/merge1
panepath -d Build2 -f -p panetab5 /obj/geo/merge1
panepath -d Build2 -f -p panetab1 /obj/geo/merge1
panepath -d Build2 -f -p panetab7 /obj/geo/merge1
panepath -d Build2 -f -p panetab2 /obj/geo/merge1
panepath -d Build2 -f -p panetab3 /obj/geo/merge1
```

### geo.order
ジオメトリノード内に存在するノードを管理しています。  
ジオメトリノード内で新しいノードを追加するなどの変更があった際に、ノードの総数、追加したノード名を追加する必要があります。
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/geo.order"
Content-Type: text/plain

7
testgeometry_pighead1
testgeometry_squab1
copytopoints1
python1
copytopoints2
merge1
attribwrangle1
```

##Gitを用いたマージの実例
以上の調査内容を踏まえて  
実際にGitを用いてマージ対応を行う一連の作業を実践します。  
検証内容としては下記3つの差分を2つのブランチで行い、最後にマージを行います。  
* パラメーターの変更
* スクリプト(Python, Vex)の変更
* 新しいノードの追加

###Originファイルの用意
まず、検証に使用するHipファイルを用意します。  
中身は下記の通りになっています。

###ブランチを分割
リモートのブランチを分割して2つの作業ブランチを用意します。

###メインブランチでファイルを編集
まず、メインブランチとなるasciiブランチでHIPの編集を行います。

###メインブランチをコミット
作業が完了したら、コミットを行いプッシュをします。

###リモートで差分を確認
リモートで差分を確認するとこのようになります。

###Copyブランチでファイルを編集
もう一方のブランチでメインブランチで行った別の作業を行います。

###メインブランチをマージ
作業が完了したらメインブランチからCopyブランチへマージを行います。

###コンフリクトを解消
※注意点に沿って無視する箇所を説明  
ここでコンフリクトが発生するので、コンフリクトファイルをWinMergeで解決します。

###リモートにプッシュ
コンフリクトが解決したらコミットを行いリモートにプッシュします。

###リモートでもマージ
修正したコミットをリモートでも反映させたら作業完了です。

## 参考資料
### ASCII
* ファイルとアセットをテキストとして取り扱う方法(公式)  
https://www.sidefx.com/ja/docs/houdini/assets/textfiles.html
https://www.sidefx.com/docs/houdini/assets/textfiles.html
* hip ascii and diff(サルにもわかるHoudini)  
https://ikatnek.blogspot.com/2018/02/hip-ascii-and-diff.html