import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig = plt.figure(figsize=(10, 6))
plt.subplots_adjust(left = 0.11, right = 0.97, bottom = 0.11, top = 0.92)
plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['font.size'] = 16
plt.rcParams['mathtext.fontset'] = 'cm'

colors = plt.rcParams['axes.prop_cycle'].by_key()['color'] #カラーリストの取得

#描画範囲
x_min = -1.0
x_max = 1.0

#アニメーション作成用
ims = []

#描画区間数
N = 100

#アニメーション分割
AN = 30

for an in range(AN):
    phi = 2.0 * np.pi * an / AN

#リストの生成
    xl = []
    yl = []

#データの生成
    for i in range(N+1):
        x = x_min + (x_max - x_min) * i / N
        y = np.sin(np.pi * x + phi)
        xl.append(x)
        yl.append(y)

#各コマのグラフの描画
    img = plt.plot(xl, yl, color=colors[0], linewidth=3.0, linestyle="solid")
    str_phi = plt.text(0.65, 1.03, r"$\phi = 2 \pi \times$" + str("{:.2f}".format(an / AN)), fontsize=18)

    img.append(str_phi)
    ims.append(img)

#グラフタイトルと軸ラベル
plt.title("$\sin(\pi x + \phi)$", fontname="Yu Gothic", fontsize=20, fontweight=1000)
plt.xlabel(r"$x$" + " 軸", fontname="Yu Gothic", fontsize=16, fontweight=500)
plt.ylabel(r"$y$" + "軸", fontname="Yu Gothic", fontsize=16, fontweight=500)

plt.grid(which = "major", axis = "x", alpha = 0.7, linewidth = 1)
plt.grid(which = "major", axis = "y", alpha = 0.7, linewidth = 1)

plt.xlim([-1.0, 1.0])
plt.ylim([-1.0, 1.0])

ani = animation.ArtistAnimation(fig, ims, interval=10)

#ani.save("output.html", writer=animation.HTMLWriter())
#ani.save("output.gif", writer="imagemagick")
#ani.save("output.gif", writer="ffmpeg", dpi = 300)

#グラフの表示
plt.show()