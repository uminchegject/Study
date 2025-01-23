# FlatBuffers



## Tutorial
FlatBuffersのプロジェクトソースの中にTutorial用のサンプルソースがあるためそちらを参考に挙動確認を行います。

### 検証環境
* Visual Studio 2022
* CMake 3.25.3

### Tutorialソース

#### fbsへの情報の設定
``` 情報の設定
  // Build up a serialized buffer algorithmically:
  flatbuffers::FlatBufferBuilder builder;

  // First, lets serialize some weapons for the Monster: A 'sword' and an 'axe'.
  auto weapon_one_name = builder.CreateString("Sword");
  short weapon_one_damage = 3;

  auto weapon_two_name = builder.CreateString("Axe");
  short weapon_two_damage = 5;

  // Use the `CreateWeapon` shortcut to create Weapons with all fields set.
  auto sword = CreateWeapon(builder, weapon_one_name, weapon_one_damage);
  auto axe = CreateWeapon(builder, weapon_two_name, weapon_two_damage);

  // Create a FlatBuffer's `vector` from the `std::vector`.
  std::vector<flatbuffers::Offset<Weapon>> weapons_vector;
  weapons_vector.push_back(sword);
  weapons_vector.push_back(axe);
  auto weapons = builder.CreateVector(weapons_vector);

  // Second, serialize the rest of the objects needed by the Monster.
  auto position = Vec3(1.0f, 2.0f, 3.0f);

  auto name = builder.CreateString("MyMonster");

  unsigned char inv_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
  auto inventory = builder.CreateVector(inv_data, 10);

  // Shortcut for creating monster with all fields set:
  auto orc = CreateMonster(builder, &position, 150, 80, name, inventory, Color_Red, weapons, Equipment_Weapon, axe.Union());

  builder.Finish(orc);  // Serialize the root of the object.
```

#### fbsからの情報の取得
``` 情報の取得
  // Get access to the root:
  auto monster = GetMonster(builder.GetBufferPointer());

  // Get and test some scalar types from the FlatBuffer.
  assert(monster->hp() == 80);
  assert(monster->mana() == 150);  // default
  assert(monster->name()->str() == "MyMonster");

  // Get and test a field of the FlatBuffer's `struct`.
  auto pos = monster->pos();
  assert(pos);
  assert(pos->z() == 3.0f);
  (void)pos;

  // Get a test an element from the `inventory` FlatBuffer's `vector`.
  auto inv = monster->inventory();
  assert(inv);
  assert(inv->Get(9) == 9);
  (void)inv;

  // Get and test the `weapons` FlatBuffers's `vector`.
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

## バイナリ

### ソース

#### エンコード
``` エンコード
    uint8_t* buf = builder.GetBufferPointer();
    size_t size = builder.GetSize();

    // ファイルに書き込み
    ofstream fout;
    fout.open("monster.bin", ios::out | ios::binary | ios::trunc);
    if (!fout) {
        return 1;
    }
    fout.write((char*)buf, size);
    fout.close();
```

#### デコード
``` デコード
    ifstream fin("monster.bin", ios::in | ios::binary);
    if (!fin) {
        return 1;
    }
    auto begin = fin.tellg();
    fin.seekg(0, fin.end);
    auto end = fin.tellg();
    fin.clear();
    fin.seekg(0, fin.beg);
    auto len = end - begin;
    auto buf_decode = new char[len + 1];
    fin.read(buf_decode, len);
    fin.close();

    // バッファ設定
    auto monster_decode = GetMonster((uint8_t*)buf_decode);

    // hp, mana, name
    printf("hp: %d\n", monster_decode->hp());
    printf("mana: %d\n", monster_decode->mana());
    printf("name: %s\n", monster_decode->name()->c_str());
```


## Schema

## 参考資料
### Tutorial
* 公式Tutorial  
https://flatbuffers.dev/tutorial/

### バイナリ
* FlatBuffersのチュートリアルやってみた (C++, Windows)  
https://zenn.dev/hikarin/articles/3346f9bb2ae2302a1a80
### Schema
* Schema  
https://flatbuffers.dev/schema/
* Language Guide: C++  
https://flatbuffers.dev/languages/cpp/