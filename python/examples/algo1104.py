"""
 Algorithm 11.4: Exact line search: golden section

Michel Bierlaire
Fri Dec 10 13:02:03 2021
"""
import matplotlib.pyplot as plt

import optimization_book.unconstrained as unc
from ex1103 import h

xstar, iters = unc.goldenSection(h, 5, 10, 1.0e-3)
print(f'xstar: {xstar}')
print('Table 11.3, page 261')
title = ' k      ell   alpha1   alpha2        u       h1       h2'
print(title)
print(len(title) * '-')
for k, it in enumerate(iters):
    print(
        f'{k+1:2} '
        f'{it[0]:8.5f} '
        f'{it[1]:8.5f} '
        f'{it[2]:8.5f} '
        f'{it[3]:8.5f} '
        f'{it[4]:8.5f} '
        f'{it[5]:8.5f} '
    )

nbr = 10
plt.xlim(5, 10)
for k in range(nbr):
    l = iters[k][0]
    u = iters[k][3]
    plt.plot([l, u], [nbr - k / 2, nbr - k / 2])
plt.tick_params(axis='y', left=False, labelleft=False)
plt.title('Figure 11.8, page 261')
plt.show()
