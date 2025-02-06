# FlatBuffers

## FlatBuffersとは
## Tutorial
Tutorialのサンプルソースです。
Monsterのステータスをテーブルで定義しそれぞれの値を設定、取得する流れを実装しています。

### Table
``` Table

```

### fbsへの情報の設定
``` 情報の設定

  flatbuffers::FlatBufferBuilder builder;

  //Swordのステータス情報を定義
  auto weapon_one_name = builder.CreateString("Sword");
  short weapon_one_damage = 3;
  auto sword = CreateWeapon(builder, weapon_one_name, weapon_one_damage);

  //Axeのステータス情報を定義
  auto weapon_two_name = builder.CreateString("Axe");
  short weapon_two_damage = 5;
  auto axe = CreateWeapon(builder, weapon_two_name, weapon_two_damage);

  // 定義した武器情報をVectorに保有させる
  std::vector<flatbuffers::Offset<Weapon>> weapons_vector;
  weapons_vector.push_back(sword);
  weapons_vector.push_back(axe);
  auto weapons = builder.CreateVector(weapons_vector);

  // 座標情報を定義
  auto position = Vec3(1.0f, 2.0f, 3.0f);

  // 名前を定義
  auto name = builder.CreateString("MyMonster");

  // インベントリを定義
  unsigned char inv_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
  auto inventory = builder.CreateVector(inv_data, 10);

  // 定義した情報をbuilderに設定
  auto orc = CreateMonster(builder, &position, 150, 80, name, inventory,
                           Color_Red, weapons, Equipment_Weapon, axe.Union());

  builder.Finish(orc);
```

### fbsからの情報の取得
``` 情報の取得
  //エンコードソースにある
  auto monster = GetMonster(builder.GetBufferPointer());

  assert(monster->hp() == 80);
  assert(monster->mana() == 150);  // default
  assert(monster->name()->str() == "MyMonster");

  auto pos = monster->pos();
  assert(pos);
  assert(pos->z() == 3.0f);
  (void)pos;

  auto inv = monster->inventory();
  assert(inv);
  assert(inv->Get(9) == 9);
  (void)inv;

  std::string expected_weapon_names[] = { "Sword", "Axe" };
  short expected_weapon_damages[] = { 3, 5 };
  auto weps = monster->weapons();
  for (unsigned int i = 0; i < weps->size(); i++) {
    assert(weps->Get(i)->name()->str() == expected_weapon_names[i]);
    assert(weps->Get(i)->damage() == expected_weapon_damages[i]);
  }
  (void)expected_weapon_names;
  (void)expected_weapon_damages;

  // Get and test the `Equipment` union (`equipped` field).
  assert(monster->equipped_type() == Equipment_Weapon);
  auto equipped = static_cast<const Weapon *>(monster->equipped());
  assert(equipped->name()->str() == "Axe");
  assert(equipped->damage() == 5);
  (void)equipped;
```

## エンコード・デコード
バイナリへのエンコード、デコードを行うためのソースです

### エンコード
``` エンコード
  uint8_t *buf = builder.GetBufferPointer();
  size_t size = builder.GetSize();

  ofstream fout;
  fout.open("monster.bin", ios::out | ios::binary | ios::trunc);
  if (!fout) { return 1; }
  fout.write((char *)buf, size);
  fout.close();
```
### デコード
``` デコード
  ifstream fin("monster.bin", ios::in | ios::binary);
  if (!fin) { return 1; }
  auto begin = fin.tellg();
  fin.seekg(0, fin.end);
  auto end = fin.tellg();
  fin.clear();
  fin.seekg(0, fin.beg);
  auto len = end - begin;
  auto buf = new char[len + 1];
  fin.read(buf, len);
  fin.close();

  auto monster = GetMonster((uint8_t *)buf);
```
## バイト型による管理
情報をバイト型でデコードし、基の型にエンコードするための処理です。

### FBSのテーブル
``` テーブル
table Byte
{
	data:[ubyte] (force_align:4);
}
``` 

### エンコード
``` エンコード
void EncodeByte(flatbuffers::FlatBufferBuilder& builder) {

  // バイトデータを作成
  std::vector<uint8_t> data = { 10, 20, 30, 40, 50 };

  // バイト配列をFlatBufferに格納
  auto data_vector = builder.CreateVector(data);

  // Byteテーブルのオブジェクトを作成
  ByteBuilder Byte_builder(builder);
  Byte_builder.add_data(data_vector);  // dataフィールドにバイトデータを設定

  // ByteオブジェクトをFlatBufferに追加
  auto Byte = Byte_builder.Finish();

  // 完成したFlatBufferをビルド
  builder.Finish(Byte);

  // バイナリデータを取得
  uint8_t *buf = builder.GetBufferPointer();
  int size = builder.GetSize();

  std::cout << "Encoded Byte Data Size: " << size << std::endl;

}
```

### デコード
``` エンコード
void DecodeByte(const uint8_t *buf) {
  // FlatBufferデータからByteを取得
  auto Byte = flatbuffers::GetRoot<Byte>(buf);

  // デコードしたデータを表示
  std::cout << "Decoded Byte Data: ";
  for (auto byte : *Byte->data()) {
    std::cout << (int)byte << " ";  // バイトを整数として表示
  }
  std::cout << std::endl;
}
```


## 参考資料
### Tutorial
* 公式Tutorial  
https://flatbuffers.dev/tutorial/

### バイナリ
* FlatBuffersのチュートリアルやってみた (C++, Windows)  
https://zenn.dev/hikarin/articles/3346f9bb2ae2302a1a80