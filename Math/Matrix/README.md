# Matrix

## ゲーム内の行列を使用した座標計算
下記の座標系のマトリクスを乗算して二次元投影を行うための座標を求める処理を実装する
1. ローカル座標系
2. ワールド座標系
3. ビュー座標系
4. パースペクティブ座標系

### 座標を表す行列の構造体
```
struct Vec4 {
    float x, y, z, w;

    Vec4 operator*(float scalar) const {
        return {x * scalar, y * scalar, z * scalar, w * scalar};
    }

    Vec4 operator+(const Vec4& other) const {
        return {x + other.x, y + other.y, z + other.z, w + other.w};
    }
};
```

### マトリクス構造体
```
#define M_PI 3.14159265358979323846
#define DEG2RAD(angle) ((angle) * M_PI / 180.0f)

struct Mat4 {
    float m[4][4];

    // 単位行列を生成
    static Mat4 identity() {
        Mat4 mat = {};
        for (int i = 0; i < 4; i++)
            mat.m[i][i] = 1.0f;
        return mat;
    }

    // 行列とベクトルの掛け算
    Vec4 operator*(const Vec4& v) const {
        return {
            m[0][0] * v.x + m[0][1] * v.y + m[0][2] * v.z + m[0][3] * v.w,
            m[1][0] * v.x + m[1][1] * v.y + m[1][2] * v.z + m[1][3] * v.w,
            m[2][0] * v.x + m[2][1] * v.y + m[2][2] * v.z + m[2][3] * v.w,
            m[3][0] * v.x + m[3][1] * v.y + m[3][2] * v.z + m[3][3] * v.w
        };
    }

    // 行列同士の掛け算
    Mat4 operator*(const Mat4& other) const {
        Mat4 result = {};
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                result.m[i][j] = 
                    m[i][0] * other.m[0][j] +
                    m[i][1] * other.m[1][j] +
                    m[i][2] * other.m[2][j] +
                    m[i][3] * other.m[3][j];
            }
        }
        return result;
    }

    // 平行移動行列
    static Mat4 translate(float x, float y, float z) {
        Mat4 mat = identity();
        mat.m[0][3] = x;
        mat.m[1][3] = y;
        mat.m[2][3] = z;
        return mat;
    }

    // 透視投影行列
    static Mat4 perspective(float fov, float aspect, float near, float far) {
        Mat4 mat = {};
        float tanHalfFov = tan(DEG2RAD(fov) / 2.0f);
        mat.m[0][0] = 1.0f / (aspect * tanHalfFov);
        mat.m[1][1] = 1.0f / tanHalfFov;
        mat.m[2][2] = -(far + near) / (far - near);
        mat.m[2][3] = -2.0f * far * near / (far - near);
        mat.m[3][2] = -1.0f;
        return mat;
    }
};
```

### 実際の処理
```
//ローカル座標
Vec4 localPos = {1.0f, 1.0f, 1.0f, 1.0f};

//ワールド変換
Mat4 worldMatrix = Mat4::translate(2.0f, 3.0f, 4.0f);
Vec4 worldPos = worldMatrix * localPos;

//ビュー変換
Mat4 viewMatrix = Mat4::translate(0.0f, 0.0f, -5.0f);
Vec4 viewPos = viewMatrix * worldPos;

//透視投影変換
Mat4 perspectiveMatrix = Mat4::perspective(90.0f, 16.0f / 9.0f, 0.1f, 100.0f);
Vec4 clipPos = perspectiveMatrix * viewPos;
```

## 参考資料
* ゲームを動かす技術と発想 R  
https://www.borndigital.co.jp/book/16550/