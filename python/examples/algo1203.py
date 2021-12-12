"""
 Algorithm 12.3: Steiheug-Toint truncated conjugate method

Michel Bierlaire
Fri Dec 10 18:16:17 2021
"""

import matplotlib.pyplot as plt
import numpy as np
import optimization_book.unconstrained as unc
from algo1201 import myplot
from ex1203 import xhat, g, H, theFunctionToPlot

# We illustrate the method on the same example as for Algorithm 12.2. This is not
# reported in the book. Note that there is no negative curvature
# here. Also, we have a large trust region ($\Delta=10$) to illustrate
# the case when the CG algorithm converges without hitting the trust
# region boundaries.

delta = 1
(step1,type1) = unc.truncatedConjugateGradient(g,H,delta)
x1 = xhat + step1
print(f'Delta: {delta} Type: {type1}\nx={x1}')

delta = 4
(step4,type4) = unc.truncatedConjugateGradient(g,H,delta)
x4 = xhat + step4
print(f'Delta: {delta} Type: {type4}\nx={x4}')

delta = 8
(step8,type8) = unc.truncatedConjugateGradient(g,H,delta)
x8 = xhat + step8
print(f'Delta: {delta} Type: {type8}\nx={x8}')

delta = 10
(step10,type10) = unc.truncatedConjugateGradient(g,H,delta)
x10 = xhat + step10
print(f'Delta: {delta} Type: {type10}\nx={x10}')

plt.title('Illustration of the example')
plt.rcParams["figure.figsize"] = [6,6]

xlist = np.linspace(-1.0,10.0,1000)
ylist = np.linspace(-5.0,5.0,1000)
X,Y = np.meshgrid(xlist,ylist)
Z = theFunctionToPlot(X,Y)
plt.contour(X,Y,Z,15)


circle1 = plt.Circle((9,1),1.0,fill=False)
circle4 = plt.Circle((9,1),4.0,fill=False)
circle8 = plt.Circle((9,1),8.0,fill=False)
circle10 = plt.Circle((9,1),10.0,fill=False)
ax = plt.gca()
ax.set_xlim((-1, 10))
ax.set_ylim((-5, 5))
ax.add_artist(circle1)
ax.add_artist(circle4)
ax.add_artist(circle8)
ax.add_artist(circle10)
myplot(ax,x1,'x1')
myplot(ax,x4,'x4')
myplot(ax,x8,'x8')
myplot(ax,x10,'x10')
plt.show()
