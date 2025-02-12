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
}
```

## 参考資料
* ゲームを動かす技術と発想 R  
https://www.borndigital.co.jp/book/16550/