import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure(figsize=(10, 6))
plt.subplots_adjust(left = 0.11, right = 0.97, bottom = 0.11, top = 0.92)
plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['font.size'] = 16
plt.rcParams['mathtext.fontset'] = 'cm'

colors = plt.rcParams['axes.prop_cycle'].by_key()['color'] #カラーリストの取得

#描画範囲
x_min = -2.0
x_max = 2.0

#描画区間数
N = 100

#べき関数の定義
def f(x):
    return x**3

#導関数の定義
def dfdt(x):
    return 3 * x**2

#指数関数の底
x1 = -1.5
x2 = 1.0

#リストの生成
xl = []
y1l = []
y2l = []
y3l = []

#データの生成
for i in range(N+1):
    x = x_min + (x_max - x_min) * i / N
    y1 = f(x)
    y2 = dfdt(x1) * (x - x1) + f(x1)
    y3 = dfdt(x2) * (x - x2) + f(x2)
    xl.append(x)
    y1l.append(y1)
    y2l.append(y2)
    y3l.append(y3)
    

#グラフタイトルと軸ラベル
plt.title("べき関数の接線", fontname="Yu Gothic", fontsize=20, fontweight=1000)
plt.xlabel(r"$t$" + " 軸", fontname="Yu Gothic", fontsize=16, fontweight=500)
plt.ylabel(r"$f(t)$", fontname="Yu Gothic", fontsize=22, fontweight=500)

plt.grid(which = "major", axis = "x", alpha = 0.7, linewidth = 1)
plt.grid(which = "major", axis = "x", alpha = 0.7, linewidth = 1)

plt.xlim([x_min, x_max])
plt.ylim([-8.0, 8.0])

#グラフの描画
plt.plot(xl, y1l, linestyle='solid', linewidth = 5)
plt.plot(xl, y2l, linestyle='solid', linewidth = 5)
plt.plot(xl, y3l, linestyle='solid', linewidth = 5)

plt.plot([x1], [f(x1)], color = colors[3], marker ='o', markersize = 20)
plt.plot([x2], [f(x2)], color = colors[3], marker ='o', markersize = 20)

plt.show()