import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig = plt.figure(figsize=(10, 6))
plt.subplots_adjust(left=0.11, right=0.97, bottom=0.12, top=0.90)
plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['font.size'] = 16
plt.rcParams['mathtext.fontset'] = 'cm'

colors = plt.rcParams['axes.prop_cycle'].by_key()['color']  # カラーリストの取得

ims = []

# 描画区間数
AN = 200

thetas = [15, 30, 45, 60, 75, 90]

r_trajectory = [0] * len(thetas)

for n in range(len(thetas)):
    theta = thetas[n]
    r_trajectory[n] = []

    t = 0
    dt = 0.01

    g = 10.0

    v0 = 10

    m = 1.0

    vx0 = v0 * np.cos(np.pi * theta / 180)
    vz0 = v0 * np.sin(np.pi * theta / 180)

    r = np.array([0, 0, 0])

    v = np.array([vx0, 0, vz0])

    a = np.array([0, 0, -g])

    r_trajectory[n].append(r)

    for an in range(AN):
        t += dt
        # 位置の更新
        r = r + v * dt

        v = v + a * dt

        r_trajectory[n].append(r)

t = 0
for an in range(AN):
    t += dt

    if (an % 3 != 0):
        continue

    for n in range(len(thetas)):

        _img = plt.plot([r_trajectory[n][an][0]], [r_trajectory[n][an][2]], color=colors[n], marker='o',
                        markersize=20)

        if (n == 0):
            img = _img
        else:
            img += _img

        xl = []
        yl = []
        for _an in range(an + 1):
            xl.append(r_trajectory[n][_an][0])
            yl.append(r_trajectory[n][_an][2])

        # 各コマのグラフの描画

        img += plt.plot(xl, yl, color=colors[n], linestyle='solid', linewidth=1)
        ims.append(img)

        time = plt.text(9.0, 5.1, "t = " + str("{:.2f}".format(t)), fontsize=18)
        img.append(time)

# グラフタイトルと軸ラベル
plt.title("重力による運動", fontname="Yu Gothic", fontsize=20, fontweight=1000)
plt.xlabel(r"$x$" + " [m]", fontname="Yu Gothic", fontsize=16, fontweight=500)
plt.ylabel(r"$z$" + " [m]", fontname="Yu Gothic", fontsize=16, fontweight=500)

plt.grid(which="major", axis="x", alpha=0.7, linewidth=1)
plt.grid(which="major", axis="y", alpha=0.7, linewidth=1)

plt.xlim([0, 10.0])
plt.ylim([0, 5.0])

ani = animation.ArtistAnimation(fig, ims, interval=50)

ani.save("output.html", writer=animation.HTMLWriter())
# ani.save("output.gif", writer="imagemagick")
# ani.save("output.gif", writer="ffmpeg", dpi=300)

# グラフの表示
plt.show()
