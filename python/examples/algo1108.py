"""
 Algorithm 11.8: Newton algorithm with line search

Michel Bierlaire
Fri Dec 10 13:16:49 2021
"""
import numpy as np
import optimization_book.unconstrained as unc
from ex0508 import ex0508

x0 = np.array([1, 1])
sol, iters = unc.newtonLineSearch(ex0508, x0, 1.0e-7)
print(f'Solution: {sol}')
print('Iterations')
for row in iters:
    print(f'{row[0][0]:10.6f}, {row[0][1]:10.6f}')
print('Table 11.7, page 281')
title = ' k        f(xk) ||Grad(xk)|| alpha         tau'
print(title)
print(len(title) * '-')
for k, it in enumerate(iters):
    f, g, _ = ex0508(it[0])
    ff = f'{f:11.5f} '
    gf = f'{np.linalg.norm(g):11.5e} '
    alpha = f'{it[3]} ' if it[3] is not None else ''
    tau = f'{it[2]:11.5f} ' if it[3] is not None else ''
    print(f'{k+1:2} ', ff, gf, alpha, tau)
