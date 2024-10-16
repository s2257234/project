import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure(figsize=(10, 6))
plt.subplots_adjust(left = 0.11, right = 0.97, bottom = 0.11, top = 0.92)
plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['font.size'] = 16
plt.rcParams['mathtext.fontset'] = 'cm'

colors = plt.rcParams['axes.prop_cycle'].by_key()['color']

x_min = -3.0
x_max = 3.0
#2次関数の定義
N = 100
def f(x, a):
    return a ** x
#極値

#係数
a1 = 1.0 / 2.0
a2 = 1.0
a3 = 2.0
a4 = 3.0

xl = []
y1l = []
y2l = []
y3l = []
y4l = []

for i in range(N+1):
    x = x_min + (x_max - x_min) * i / N
    y1 = f(x, a1)
    y2 = f(x, a2)
    y3 = f(x, a3)
    y4 = f(x, a4)
    xl.append(x)
    y1l.append(y1)
    y2l.append(y2)
    y3l.append(y3)
    y4l.append(y4)
    
    

plt.title(r"$f(x) = a^x$", fontname="Yu Gothic", fontsize=20, fontweight=1000)
plt.xlabel(r"$x$" + " 軸", fontname="Yu Gothic", fontsize=16, fontweight=500)
plt.ylabel(r"$f(x)$", fontname="Yu Gothic", fontsize=22, fontweight=500)

plt.grid(which = "major", axis = "x", alpha = 0.7, linewidth = 1)
plt.grid(which = "major", axis = "y", alpha = 0.7, linewidth = 1)

plt.xlim([x_min, x_max])
plt.ylim([0.0, 8.0])

plt.plot(xl, y1l, linestyle='solid', linewidth = 5)
plt.plot(xl, y2l, linestyle='solid', linewidth = 5)
plt.plot(xl, y3l, linestyle='solid', linewidth = 5)
plt.plot(xl, y4l, linestyle='solid', linewidth = 5)


plt.show()
