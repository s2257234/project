import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure(figsize=(10, 6))
plt.subplots_adjust(left = 0.11, right = 0.97, bottom = 0.11, top = 0.92)
plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['font.size'] = 16
plt.rcParams['mathtext.fontset'] = 'cm'

colors = plt.rcParams['axes.prop_cycle'].by_key()['color'] #カラーリストの取得

#描画範囲
x_min = -20.0
x_max = 20.0

#描画区間数
N = 300


def sinc(x):
    return np.sin(x) / x

#リストの生成
xl = []
yl = []


#データの生成
for i in range(N+1):
    x = x_min + (x_max - x_min) * i / N
    if(x == 0):continue
    y = sinc(x)
    xl.append(x)
    yl.append(y)
    
    

#グラフタイトルと軸ラベル
plt.title(r"$ {\rm sinc}(x) \equiv \frac{\sin x}{x} $", fontname="Yu Gothic", fontsize=16, fontweight=1000)
plt.xlabel(r"$x$" + " 軸", fontname="Yu Gothic", fontsize=16, fontweight=500)
plt.ylabel(r"${\rm sinc}(x) $", fontname="Yu Gothic", fontsize=22, fontweight=500)

plt.grid(which = "major", axis = "x", alpha = 0.7, linewidth = 1)
plt.grid(which = "major", axis = "y", alpha = 0.7, linewidth = 1)

plt.xlim([x_min, x_max])
plt.ylim([-0.25, 1.25])

#グラフの描画
plt.plot(xl, yl, linestyle='solid', linewidth = 5)

plt.show()