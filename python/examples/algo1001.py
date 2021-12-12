"""
 Algorithm 10.1: Newton's local method

Michel Bierlaire
Fri Dec 10 12:13:26 2021
"""

import numpy as np
import matplotlib.pyplot as plt
import optimization_book.unconstrained as unc
from ex0508 import ex0508, theFunctionToPlot


x0 = np.array([1, 1])
sol, iters, diagnostic = unc.newtonLocal(ex0508, x0, 1e-15)
print(f'Diagnostic: {diagnostic}')
print(f'Solution: {sol}')

# Table 10.1, page 237
title = 'k                  xk        Grad(xk)    ||Grad(xk)||           f(xk)'
print(title)
print(len(title) * '-')
for it in iters:
    print(
        f'{it[0]}\t'
        f'{it[1][0]:+E}\t'
        f'{it[3][0]:+E}\t'
        f'{np.linalg.norm(it[3]):+E}\t'
        f'{it[2]:+E}'
    )
    print(f'\t{it[1][1]:+E}\t' f'{it[3][1]:+E}')

plt.title('Figure 10.1 (a), page 238')
xlist = np.linspace(-2.0, 2.0, 1000)
ylist = np.linspace(-6.0, 6.0, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)
xiter = [it[1][0] for it in iters]
yiter = [it[1][1] for it in iters]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.xlim(-2, 2)
plt.ylim(-6, 6)
plt.show()

plt.title('Figure 10.1 (b), page 238')
plt.contour(X, Y, Z, 50)
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.xlim(-0.5, 1.1)
plt.ylim(0.9, 2)
plt.show()
