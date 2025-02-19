# Quaternion

## ベクトルをクォータニオンを用いて回転させる
### クォータニオン構造体
```
struct Quaternion {
    double w, x, y, z;

    // 共役を求める
    Quaternion conjugate() const {
        return {w, -x, -y, -z};
    }

    // クォータニオンの乗算
    Quaternion operator*(const Quaternion& q) const {
        return {
            w * q.w - x * q.x - y * q.y - z * q.z,
            w * q.x + x * q.w + y * q.z - z * q.y,
            w * q.y - x * q.z + y * q.w + z * q.x,
            w * q.z + x * q.y - y * q.x + z * q.w
        };
    }

    // ベクトルをクォータニオンとして回転させる
    std::array<double, 3> rotateVector(const std::array<double, 3>& v) const {
        Quaternion vec = {0, v[0], v[1], v[2]};
        //クォータニオンを用いた回転: v' = q * v * q⁻¹
        Quaternion result = (*this) * vec * this->conjugate();
        return {result.x, result.y, result.z};
    }
};
```

### ベクトルの回転処理
```
// 回転軸 (0,1,0) の周りに 90 度回転させるクォータニオンを作成
double angle = M_PI / 2;
Quaternion q = {std::cos(angle / 2), 0, std::sin(angle / 2), 0};

// 回転させるベクトル
std::array<double, 3> vec = {1, 0, 0};

// 回転処理
std::array<double, 3> rotatedVec = q.rotateVector(vec);
```

## 参考資料
* ゲームを動かす技術と発想 R  
https://www.borndigital.co.jp/book/16550/