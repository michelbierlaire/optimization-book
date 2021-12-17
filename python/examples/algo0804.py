"""
Algorithm 8.4: secant method: several variables
Example 7.11

Michel Bierlaire
Fri Dec 17 07:52:01 2021
"""

import numpy as np
import optimization_book.equations as eq
import matplotlib.pyplot as plt
from ex0711 import ex0711_only_f as ex0711
from ex0711 import ex0711 as ex0711_with_J

x0 = np.array([1, 1])
root, iters, status = eq.secantNVariables(ex0711, x0, 1.0e-15)
print(status)
print('Value at the solution')
f = ex0711(root)
print(f'x= ({root[0]}, {root[1]}) F(x)=({f[0]}, {f[1]})')

print('Table 8.6, page 215')

print('k\txk\t\tF(xk)\t\t||F(xk)||')
for it in iters:
    print(
        f'{it[0]}\t'
        f'{it[1][0]:+E}\t'
        f'{it[2][0]:+E}\t'
        f'{np.linalg.norm(it[2]):+E}'
    )
    print(f'  \t' f'{it[1][1]:+E}' f'\t{it[2][1]:+E}')

plt.title('Algorithm 8.4: illustration of the iterations')
norm = [np.linalg.norm(it[2]) for it in iters]
plt.xlabel('Iteration')
plt.ylabel('||F(x)||')
plt.plot(norm)
plt.show()

print('Table 8.7, page 215.')

for k, it in enumerate(iters):
    x = it[1]
    A = it[3]
    J = ex0711_with_J(x)[1]
    print(
        f'{k}\t'
        f'{J[0,0]:+E}\t'
        f'{J[0,1]:+E}\t'
        f'{A[0,0]:+E}\t'
        f'{A[0,1]:+E}'
    )

    print(
        f'  \t'
        f'{J[1,0]:+E}\t'
        f'{J[1,1]:+E}\t'
        f'{A[1,0]:+E}\t'
        f'{A[1,1]:+E}'
    )
