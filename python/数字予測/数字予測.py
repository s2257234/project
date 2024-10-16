import sklearn.datasets
import sklearn.svm
from PIL import Image
import numpy

def imageToData(filename):
    # 画像を読み込み、前処理を行う
    grayImage = Image.open(filename).convert("L")
    grayImage = grayImage.resize((8, 8), Image.LANCZOS)

    # 画像データを配列に変換
    numImage = numpy.asarray(grayImage, dtype=float)
    numImage = 16 - numpy.floor(17 * numImage / 256)
    numImage = numImage.flatten()

    return numImage

def predictDigits(data):
    digits = sklearn.datasets.load_digits()

    clf = sklearn.svm.SVC(gamma=0.001)
    clf.fit(digits.data, digits.target)

    # 画像データを予測
    n = clf.predict([data])
    print("予測 = ", n)

# 画像を読み込む
data = imageToData("7.png")

# 予測を行う
predictDigits(data)
