"""
 Algorithm 9.2: conjugate gradient method

Michel Bierlaire
Fri Dec 10 12:13:32 2021
"""

import numpy as np
import optimization_book.unconstrained as unc
import optimization_book.exceptions as excep
import ex0908
import ex09xx

Q = ex0908.Q
b = ex0908.b

x0 = np.array([5.0, 5.0, 5.0, 5.0])
x, iters = unc.conjugateGradient(Q, b, x0)
print(f'Solution: {x}')
print(f'Gradient: {Q @ x + b}')

# Table 9.1, page 231.
def oneIter(k, iter):
    """Print the information about one iteration

    :param k: iteration number
    :type k: int

    :param iter: information about the iteration: xk, gk, dk, alphak, betak
    :type iter: tuple(np.array, np.array, np.array, float, float)
    """
    for i in range(4):
        if i == 0:
            print(
                f'{k}\t'
                f'{iter[0][i]:+E}\t'
                f'{iter[1][i]:+E}\t'
                f'{iter[2][i]:+E}\t'
                f'{iter[3]:+E}\t'
                f'{iter[4]:+E}'
            )
        else:
            print(
                f'\t'
                f'{iter[0][i]:+E}\t'
                f'{iter[1][i]:+E}\t'
                f'{iter[2][i]:+E}'
            )


print('k\txk\t\tgk\t\tdk\t\talphak\t\tbetak')
for k, it in enumerate(iters):
    print(85 * '-')
    oneIter(k, it)

print('Show that an error is triggered if the matrix is not definite positive')
Q = ex09xx.Q
b = ex09xx.b

x0 = np.array([5.0, 5.0, 5.0, 5.0])
try:
    x, iters = unc.conjugateGradient(Q, b, x0)
except excep.optimizationError as e:
    print(f'Exception raised: {e}')
