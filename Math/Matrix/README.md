# Matrix

## Studyとは

## Matrixクラス
``` Class Matrix
class Matrix {
private:
    double data[4][4];

public:
    Matrix() {
        for (int i = 0; i < 4; ++i)
            for (int j = 0; j < 4; ++j)
                data[i][j] = 0.0;
    }

    // 単位行列を生成
    static Matrix identity() {
        Matrix I;
        for (int i = 0; i < 4; ++i)
            I.data[i][i] = 1.0;
        return I;
    }

    // 要素の取得・設定
    double& operator()(int row, int col) {
        if (row < 0 || row >= 4 || col < 0 || col >= 4)
            throw std::out_of_range("Index out of range");
        return data[row][col];
    }

    double operator()(int row, int col) const {
        if (row < 0 || row >= 4 || col < 0 || col >= 4)
            throw std::out_of_range("Index out of range");
        return data[row][col];
    }

    // 行列の加算
    Matrix operator+(const Matrix& other) const {
        Matrix result;
        for (int i = 0; i < 4; ++i)
            for (int j = 0; j < 4; ++j)
                result.data[i][j] = data[i][j] + other.data[i][j];
        return result;
    }

    // 行列の減算
    Matrix operator-(const Matrix& other) const {
        Matrix result;
        for (int i = 0; i < 4; ++i)
            for (int j = 0; j < 4; ++j)
                result.data[i][j] = data[i][j] - other.data[i][j];
        return result;
    }

    // 行列の乗算
    Matrix operator*(const Matrix& other) const {
        Matrix result;
        for (int i = 0; i < 4; ++i)
            for (int j = 0; j < 4; ++j)
                for (int k = 0; k < 4; ++k)
                    result.data[i][j] += data[i][k] * other.data[k][j];
        return result;
    }

    //転置行列
    Matrix4x4 transpose() const {
        Matrix4x4 result;
        for (int i = 0; i < 4; ++i)
            for (int j = 0; j < 4; ++j)
                result.data[j][i] = data[i][j];
        return result;
    }

    //逆行列
    Matrix4x4 inverse() const {
        Matrix4x4 result;
        std::array<std::array<float, 4>, 4> temp = data;
        std::array<std::array<float, 4>, 4> identity = {{{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}};
        
        for (int i = 0; i < 4; ++i) {
            float diag = temp[i][i];
            if (std::fabs(diag) < 1e-6) {
                std::cerr << "Matrix is singular and cannot be inverted." << std::endl;
                return Matrix4x4();
            }
            for (int j = 0; j < 4; ++j) {
                temp[i][j] /= diag;
                identity[i][j] /= diag;
            }
            for (int k = 0; k < 4; ++k) {
                if (k == i) continue;
                float factor = temp[k][i];
                for (int j = 0; j < 4; ++j) {
                    temp[k][j] -= factor * temp[i][j];
                    identity[k][j] -= factor * identity[i][j];
                }
            }
        }
        return Matrix4x4(identity);
    }

    void print() const {
        for (const auto& row : data) {
            for (float value : row)
                std::cout << value << " ";
            std::cout << std::endl;
        }
    }
};    
}
```

## 参考資料
* ゲームを動かす技術と発想 R  
https://www.borndigital.co.jp/book/16550/