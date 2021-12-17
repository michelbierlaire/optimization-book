"""
Algorithm 8.3: Finite difference Newton’s method: several variables
Example 7.11

Michel Bierlaire
Fri Dec 17 07:22:24 2021
"""

import numpy as np
import optimization_book.equations as eq
import matplotlib.pyplot as plt
from ex0711 import ex0711_only_f as ex0711

eps = 1.0e-15
x0 = np.array([1, 1])
tau = 1.0e-7
print(f'*** {x0=} {tau=}')
root, iters, status = eq.newtonFinDiffNVariables(ex0711, x0, tau, eps)
print(status)
print('Value at the solution')
f = ex0711(root)
print(f'x= ({root[0]},{root[1]}) F(x)=({f[0]},{f[1]})')

print('Table 8.4, page 209')

print("k\txk\t\tF(xk)\t\t||F(xk)||")
for it in iters:
    print(
        f'{it[0]}\t'
        f'{it[1][0]:+E}\t'
        f'{it[2][0]:+E}\t'
        f'{np.linalg.norm(it[2]):+E}'
    )
    print(f'  \t{it[1][1]:+E}\t' f'{it[2][1]:+E}')

norm = [np.linalg.norm(iters[k][2]) for k in range(len(iters))]
plt.title(f'Algorithm 8.3: illustration of the iterations with {tau=}')
plt.xlabel('Iteration')
plt.ylabel('||F(x)||')
plt.plot(norm)
plt.show()

tau = 0.1
print(f'*** {x0=} {tau=}')
root, iters, status = eq.newtonFinDiffNVariables(ex0711, x0, tau, eps)
print(status)
print('Value at the solution')
f = ex0711(root)
print(f'x= ({root[0]},{root[1]}) F(x)=({f[0]},{f[1]})')

print('Table 8.5, page 210')

print("k\txk\t\tF(xk)\t\t||F(xk)||")
for it in iters:
    print(
        f'{it[0]}\t'
        f'{it[1][0]:+E}\t'
        f'{it[2][0]:+E}\t'
        f'{np.linalg.norm(it[2]):+E}'
    )
    print(f'  \t{it[1][1]:+E}\t' f'{it[2][1]:+E}')

norm = [np.linalg.norm(iters[k][2]) for k in range(len(iters))]
plt.title(f'Algorithm 8.3: illustration of the iterations with {tau=}')
plt.xlabel('Iteration')
plt.ylabel('||F(x)||')
plt.plot(norm)
plt.show()
