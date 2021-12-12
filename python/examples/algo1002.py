"""
 Algorithm 10.2: Newton's local method by quadratic modeling

Michel Bierlaire
Fri Dec 10 12:13:20 2021
"""

import numpy as np
import matplotlib.pyplot as plt
import optimization_book.unconstrained as unc
import optimization_book.exceptions as excep
from exRosenbrock import exRosenbrock, theFunctionToPlot
from ex0508 import ex0508


x0 = np.array([-1.5, 2])
sol, iters, diagnostic = unc.newtonLocalQuadratic(exRosenbrock, x0, 1e-15)
print(f'Diagnostic: {diagnostic}')
print(f'Solution: {sol}')

plt.title('Algorithm 10.2 with Rosenbrock')
xlist = np.linspace(-3.0, 3.0, 1000)
ylist = np.linspace(-3.0, 3.0, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 20)
xiter = [it[0][0] for it in iters]
yiter = [it[0][1] for it in iters]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.show()

# We now apply the algorithm on example 5.8. In this case, the
# algorithm fails to converge, as one hessian is not positive
# definite. We try first using the direct method to solve the quadratic
# problem. An exception is triggered.

x0 = np.array([1.1, 1.1])

try:
    sol, iters, diagnostic = unc.newtonLocalQuadratic(ex0508, x0, 1e-15)
except excep.optimizationError as e:
    print(f'Exception raised: {e}')

# If we try with the conjugate gradient method, an error is also triggered.
try:
    sol, iters, diagnostic = unc.newtonLocalQuadratic(ex0508, x0, 1e-15, True)
except excep.optimizationError as e:
    print(f'Exception raised: {e}')
