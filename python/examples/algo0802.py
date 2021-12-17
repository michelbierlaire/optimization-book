"""
Algorithm 8.2: secant method: one variable
Example 7.3

Michel Bierlaire
Fri Dec 17 07:09:29 2021
"""

import numpy as np
import optimization_book.equations as eq
import matplotlib.pyplot as plt
from ex0703 import ex0703_only_f as ex0703

eps = 1.0e-15

x0 = 2
a0 = 1
root, iters, status = eq.secantOneVariable(ex0703, x0, a0, eps)
print(status)
print(f'x= {root} F(x)={ex0703(root)}')

print('Table 8.3, page 207')

print('k\txk\t\tF(xk)\t\tak')
for k in iters:
    print('{0}\t{1:+E}\t{2:+E}\t{3:+E}'.format(*k))

table = np.array(iters)
plt.title('Algorithm 8.2: illustration of the iterations')
plt.xlabel('Iteration')
plt.ylabel('F(x)')
plt.plot(table[1:, 2])
plt.show()
