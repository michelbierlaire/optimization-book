"""
Algorithm 7.3: Newton's method: several variables
Examples 7.11 and 7.12

Michel Bierlaire
Fri Dec 10 12:13:44 2021
"""
import numpy as np
import optimization_book.equations as eq
import matplotlib.pyplot as plt
from ex0711 import ex0711
from ex0712 import ex0712

eps = 1.0e-15

print('--- Example 7.11 ---')
x0 = np.array([1, 1])
xstar, iters, message = eq.newtonSeveralVariables(ex0711, x0, eps)

print(f'Solution: {xstar}')
print(f'Diagnostic: {message}')

print('Table 7.4, p. 195')
print("k\txk\t\tF(xk)\t\t||F(xk)||")
for k in iters:
    print(f'{k[0]}\t{k[1][0]:+E}\t{k[2][0]:+E}\t{np.linalg.norm(k[2]):+E}')
    print(f'  \t{k[1][1]:+E}\t{k[2][1]:+E}')

# We plot the norm of the function as the iterations progress
norm = [np.linalg.norm(k[2]) for k in iters]
plt.title('Algorithm 7.3 with example 7.11')
plt.xlabel('Iteration')
plt.ylabel('||F(x)||')
plt.plot(norm)
plt.show()

print('--- Example 7.12 ---')

x0 = np.array([1, 1])
xfirst, _, message = eq.newtonSeveralVariables(ex0712, x0, eps)

print(f'Starting from {x0}. Solution: {xfirst}')
print(f'Diagnostic: {message}')

x0 = np.array([-1, -1])
xsecond, _, message = eq.newtonSeveralVariables(ex0712, x0, eps)

print(f'Starting from {x0}. Solution: {xsecond}')
print(f'Diagnostic: {message}')

x0 = np.array([0, 1])
xthird, _, message = eq.newtonSeveralVariables(ex0712, x0, eps)

print(f'Starting from {x0}. Solution: {xthird}')
print(f'Diagnostic: {message}')

# Prepare the fractal
resolution = 400


def runalgo(x, y):
    """Run Newton's method for two variables from a given starting point,
       and returns the id of the root that has been reached.

    :param x: starting value of the first variable
    :type x: float

    :param y: starting value of the second variable
    :type y: float

    :return:
       - 0 if the algorithm converges to the first root
       - 1 if the algorithm converges to the second root
       - 2 if the algorithm converges to the third root
       - 3 if the algorithm does not converge
    :rtype: int

    """
    root, _, _ = eq.newtonSeveralVariables(ex0712, np.array([x, y]), 1.0e-7)
    if np.linalg.norm(root - xfirst) < 1.0e-7:
        return 0
    if np.linalg.norm(root - xsecond) < 1.0e-7:
        return 1
    if np.linalg.norm(root - xthird) < 1.0e-7:
        return 2
    return 3


def fractal(xmin, xmax, ymin, ymax):
    """Calculate the fractal

    :param xmin: minimum value for the first variable.
    :type xmin: float

    :param xmax: maximum value for the first variable.
    :type xmax: float

    :param ymin: minimum value for the second variable.
    :type ymin: float

    :param ymax: maximum value for the second variable.
    :type ymax: float

    :return: 2D array containing, for each entry, the id of the solution found.
    :rtype: 2D np.array
    """
    nx, ny = resolution, resolution
    x = np.linspace(xmin, xmax, nx)
    y = np.linspace(ymin, ymax, ny)
    xv, yv = np.meshgrid(x, y)
    return np.vectorize(runalgo)(xv, yv)


# Display fractal
plt.title('Figure 7.7(a), p. 196')
result = fractal(-2, 2, -2, 2)
plt.imshow(result, interpolation='nearest')
plt.show()

# Zoom
result = fractal(-0.001, 0.001, -0.001, 0.001)
plt.title('Figure 7.7(b), p. 196')
plt.imshow(result, interpolation='nearest')
plt.show()
