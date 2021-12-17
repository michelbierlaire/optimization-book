"""
Algorithm 8.1: Finite difference Newton’s method: one variable
Example 7.3

Michel Bierlaire
Sun Dec 12 14:08:45 2021
"""

import numpy as np
import optimization_book.equations as eq
import matplotlib.pyplot as plt
from ex0703 import ex0703_only_f as ex0703

eps = 1.0e-15

x0 = 2
tau = 1.0e-7
print(f'Run with x0={x0} and tau={tau}')
root, iters, status = eq.newtonFinDiffOneVariable(ex0703, x0, eps, tau)
print(status)
print(f'x= {root} F(x)={ex0703(root)}')

print('Table 8.1, page 204')

print('k\txk\t\tF(xk)')
for k in iters:
    print(f'{k[0]}\t{k[1]:+E}\t{k[2]:+E}')

plt.title('Illustration of the iterations')
table = np.array(iters)
plt.xlabel('Iteration')
plt.ylabel('F(x)')
plt.plot(table[1:, 2])
plt.show()


x0 = 2
tau = 0.1
print(f'Run with x0{x0} and tau={tau}')
root, iters = eq.newtonFinDiffOneVariable(ex0703, x0, eps, tau)
print(f'x= {root} F(x)={ex0703(root)}')

print('Table 8.2, page 205')

print('k\txk\t\tF(xk)')
for k in iters:
    print(f'{k[0]}\t{k[1]:+E}\t{k[2]:+E}')

plt.title('Illustration of the iterations')
table = np.array(iters)
plt.xlabel('Iteration')
plt.ylabel('F(x)')
plt.plot(table[1:, 2])
plt.show()
