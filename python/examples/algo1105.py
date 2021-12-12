"""
 Algorithm 11.5: Inexact line search

Michel Bierlaire
Fri Dec 10 13:04:33 2021
"""
import numpy as np
import optimization_book.unconstrained as unc
from ex1102 import ex1102

x = np.array([10, 1])
d = np.array([-2 / np.sqrt(5), 1 / np.sqrt(5)])
alpha0 = 1.0e-3
beta1 = 0.3
beta2 = 0.7
ell = 20

alpha, iters = unc.lineSearch(ex1102, x, d, alpha0, beta1, beta2, ell)
print(f'{alpha=}')

print('Table 11.6')

print(" k   alphai  alpha_ell    alpha_r")
print(50 * '-')
for k, it in enumerate(iters):
    print(
        f'{k+1:2} '
        f'{it[0]:9.5f} '
        f'{it[1]:9.5f} '
        f'{it[2]:10.3E} '
        f'{it[3]} '
    )
