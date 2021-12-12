"""
 Algorithm 12.2: Dogleg method

Michel Bierlaire
Fri Dec 10 17:37:28 2021
"""

import matplotlib.pyplot as plt
import numpy as np
import optimization_book.unconstrained as unc
from algo1201 import myplot
from ex1203 import xhat, g, H, theFunctionToPlot

delta = 1
dstar1, type1 = unc.dogleg(g, H, delta)
x1 = xhat + dstar1
print(f'Delta: {delta} Type: {type1}\nx={x1}')
delta = 4
dstar4, type4 = unc.dogleg(g, H, delta)
x4 = xhat + dstar4
print(f'Delta: {delta} Type: {type4}\nx={x4}')
delta = 8
dstar8, type8 = unc.dogleg(g, H, delta)
x8 = xhat + dstar8
print(f'Delta: {delta} Type: {type8}\nx={x8}'.format(delta, type8, x8))

# Figure 12.2 (a) p. 296
plt.title('Figure 12.2 (a) p. 296')
plt.rcParams["figure.figsize"] = [6, 6]


xlist = np.linspace(-1.0, 10.0, 1000)
ylist = np.linspace(-5.0, 5.0, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)

ax = plt.gca()
ax.set_xlim((-1, 10))
ax.set_ylim((-5, 5))
(dc, dn, dl) = unc.cauchyNewtonDogleg(g, H)
myplot(ax, xhat, 'xhat')
xc = xhat + dc
myplot(ax, xc, 'xC')
xn = xhat + dn
myplot(ax, xn, 'xN')
xd = xhat + dl
myplot(ax, xhat + dl, 'xd')
x_points = [xhat.item(0), xc.item(0), xd.item(0), xn.item(0)]
y_points = [xhat.item(1), xc.item(1), xd.item(1), xn.item(1)]
plt.plot(x_points, y_points)
plt.show()

plt.rcParams["figure.figsize"] = [6, 6]

xlist = np.linspace(-1.0, 10.0, 1000)
ylist = np.linspace(-5.0, 5.0, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)


# Figure 12.2 (b) p. 296
plt.title('Figure 12.2 (b) p. 296')
circle1 = plt.Circle((9, 1), 1.0, fill=False)
circle4 = plt.Circle((9, 1), 4.0, fill=False)
circle8 = plt.Circle((9, 1), 8.0, fill=False)
ax = plt.gca()
ax.set_xlim((-1, 10))
ax.set_ylim((-5, 5))
ax.add_artist(circle1)
ax.add_artist(circle4)
ax.add_artist(circle8)
myplot(ax, x1, 'x1')
myplot(ax, x4, 'x4')
myplot(ax, x8, 'x8')
x_points = [xhat.item(0), xc.item(0), xd.item(0), xn.item(0)]
y_points = [xhat.item(1), xc.item(1), xd.item(1), xn.item(1)]
plt.plot(x_points, y_points)
plt.show()
