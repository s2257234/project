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

ims = []

#描画区間数
AN = 300

t =0
dt = 0.01

r = np.array([-0.8, -0.8, 0])

v = np.array([0.0, 2.8, 0])

a = np.array([1.0, -2.8, 0])

r_trajectory = []

for an in range(AN):
    t += dt
    #位置の更新
    r = r + v * dt

    v = v + a * dt
    
    r_trajectory.append(r)


    xl = []
    yl = []
    for _r in r_trajectory:
        xl.append(_r[0])
        yl.append(_r[1])

    #各コマのグラフの描画
    img = plt.plot(r[0], r[1] ,color=colors[0], marker = 'o', markersize = 20)
    img += plt.plot(xl, yl ,color=colors[0], linestyle = 'solid', linewidth = 1)
    ims.append(img)

    time = plt.text(0.78, 1.02, "t = " + str("{:.2f}".format(t)), fontsize = 18)
    img.append(time)
    

#グラフタイトルと軸ラベル
plt.title("質点の等速度運動", fontname="Yu Gothic", fontsize=20, fontweight=1000)
plt.xlabel(r"$x$" + "軸", fontname="Yu Gothic", fontsize=16, fontweight=500)
plt.ylabel(r"$y$" + "軸", fontname="Yu Gothic", fontsize=16, fontweight=500)

plt.grid(which = "major", axis = "x", alpha = 0.7, linewidth = 1)
plt.grid(which = "major", axis = "y", alpha = 0.7, linewidth = 1)

plt.xlim([-1.0, 1.0])
plt.ylim([-1.0, 1.0])

ani = animation.ArtistAnimation(fig, ims, interval=50)

#ani.save("output.html", writer=animation.HTMLWriter())
#ani.save("output.gif", writer="imagemagick")
#ani.save("output.gif", writer="ffmpeg", dpi = 300)

#グラフの表示
plt.show()