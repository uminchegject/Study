# ASCII

## アスキーの保存方法

## アスキーの構造
下記にあるソースのようにMIME形式に基づいたデータフォーマットで、複数のデータをアスキー形式で管理しています。  
ラベルとして情報確認の際に利用します。
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/box1.userdata"
Content-Type: text/plain
```

### --HOUDINIMIMEBOUNDARY

### Content-Disposition
このパートの内容が添付ファイルであることを示します。
```
Content-Disposition: attachment
```
### filename
このパートが管理しているデータの名前です。  
**管理しているデータの内容をここで確認します。**
```
filename="obj/box1.userdata"
```
### Content-Type
テキストファイルとして保存されていることを示します。
```
Content-Type: text/plain
```

### 例  
例えば下記のようなデータがある場合、  
filenameの"obj/box1/box1.parm"からbox1のパラメーターの情報ということを確認し、  
差分の部分のパラメーターを確認するといった具合で差分を確認していきます。
```
--HOUDINIMIMEBOUNDARY0xD3ADD339-0x00000F49-0x56B122C9-0x00000001HOUDINIMIMEBOUNDARY
Content-Disposition: attachment; filename="obj/box1/box1.parm"
Content-Type: text/plain

{
version 0.8
type	[ 0	locks=0 ]	(	"polymesh"	)
surftype	[ 0	locks=0 ]	(	"quads"	)
consolidatepts	[ 0	locks=0 ]	(	"on"	)
size	[ 0	locks=0 ]	(	1	1	1	)
t	[ 0	locks=0 ]	(	0	0	0	)
r	[ 0	locks=0 ]	(	0	0	0	)
scale	[ 0	locks=0 ]	(	1	)
divrate	[ 0	locks=0 ]	(	2	2	2	)
orderrate	[ 0	locks=0 ]	(	4	4	4	)
dodivs	[ 0	locks=0 ]	(	"off"	)
divs	[ 0	locks=0 ]	(	3	3	3	)
rebar	[ 0	locks=0 ]	(	"off"	)
orientedbbox	[ 0	locks=0 ]	(	"off"	)
vertexnormals	[ 0	locks=0 ]	(	"off"	)
}
```

## Git管理


## 参考資料
### ASCII
* ファイルとアセットをテキストとして取り扱う方法(公式)
https://www.sidefx.com/ja/docs/houdini/assets/textfiles.html
https://www.sidefx.com/docs/houdini/assets/textfiles.html
* hip ascii and diff(サルにもわかるHoudini)
https://ikatnek.blogspot.com/2018/02/hip-ascii-and-diff.html

### Git管理
