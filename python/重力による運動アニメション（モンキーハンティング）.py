import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig = plt.figure(figsize=(10, 6))
plt.subplots_adjust(left = 0.11, right = 0.97, bottom = 0.12, top = 0.90)
plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['font.size'] = 16
plt.rcParams['mathtext.fontset'] = 'cm'

colors = plt.rcParams['axes.prop_cycle'].by_key()['color'] #カラーリストの取得


ims = []

#描画区間数
AN = 2000

t =0
dt = 0.01

g = 10.0

v0 = 10

theta = 50.0

vx0 =v0 * np.cos(np.pi * theta/180)
vz0 =v0 * np.sin(np.pi * theta/180)

r = np.array([0, 0, 0])
r_m = np.array([5, 0, 5])

v = np.array([vx0, 0, vz0])
v_m = np.array([0, 0, 0])

a = np.array([0, 0, -g])

r_trajectory = []
r_m_trajectory = []

r_trajectory.append(r)
r_m_trajectory.append(r_m)

for an in range(AN):
    t += dt
    #位置の更新
    r = r + v * dt
    r_m = r_m + v_m * dt

    v = v + a * dt
    v_m = v_m + a * dt
    
    r_trajectory.append(r)
    r_trajectory.append(r_m)


    xl = []
    yl = []
    for _r in r_trajectory:
        xl.append(_r[0])
        yl.append(_r[2])
    xl_m = []
    yl_m = []
    for _r in r_m_trajectory:
        xl_m.append(_r[0])
        yl_m.append(_r[2])

    #各コマのグラフの描画
    img = plt.plot([r[0]], [r[2]] ,color=colors[0], marker = 'o', markersize = 20)
    img += plt.plot([r_m[0]], [r_m[2]] ,color=colors[1], marker = 's', markersize = 30)
    img += plt.plot(xl, yl ,color=colors[0], linestyle = 'solid', linewidth = 1)
    img += plt.plot(xl_m, yl_m ,color=colors[1], linestyle = 'solid', linewidth = 1)
    ims.append(img)

    time = plt.text(9.0, 5.1, "t = " + str("{:.2f}".format(t)), fontsize = 18)
    img.append(time)

    if(r[2] < -1):break
    

#グラフタイトルと軸ラベル
plt.title("重力による運動(モンキーハンティング)", fontname="Yu Gothic", fontsize=20, fontweight=1000)
plt.xlabel(r"$x$" + " [m]", fontname="Yu Gothic", fontsize=16, fontweight=500)
plt.ylabel(r"$z$" + " [m]", fontname="Yu Gothic", fontsize=16, fontweight=500)

plt.grid(which = "major", axis = "x", alpha = 0.7, linewidth = 1)
plt.grid(which = "major", axis = "y", alpha = 0.7, linewidth = 1)

plt.xlim([0,10.0])
plt.ylim([0, 5.0])

ani = animation.ArtistAnimation(fig, ims, interval=50)

#ani.save("output.html", writer=animation.HTMLWriter())
#ani.save("output.gif", writer="imagemagick")
#ani.save("output.gif", writer="ffmpeg", dpi = 300)

#グラフの表示
plt.show()