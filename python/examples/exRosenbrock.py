"""Rosenbrock function. It is described in Section 11.6 of the book
 for two variables.  The implementation below involves n variables

Michel Bierlaire
Fri Dec 10 12:12:07 2021
"""
import numpy as np


def exRosenbrock(x, derivatives=True):
    """Implementation of the Rosenbrock function

    :param x: vector of variables
    :type x: np.array(n)

    :param derivatives: if True, the gradient and hessian are calculated
    :type derivatives: bool

    :return: value of the function, the gradient (or None) and the
             hessian (or None)
    :rtype: float, np.array(n), np.array(n*n)

    """
    n = len(x)
    f = sum(
        100.0 * (x[i + 1] - x[i] ** 2) ** 2 + (1.0 - x[i]) ** 2
        for i in range(n - 1)
    )
    if not derivatives:
        return f, None, None
    g = np.zeros(n)
    for i in range(n - 1):
        g[i] = g[i] - 400 * x[i] * (x[i + 1] - x[i] ** 2) - 2 * (1 - x[i])
        g[i + 1] = g[i + 1] + 200 * (x[i + 1] - x[i] ** 2)
    H = np.zeros((n, n))
    for i in range(n - 1):
        H[[i], [i]] = H[[i], [i]] - 400 * x[i + 1] + 1200 * x[i] ** 2 + 2
        H[[i + 1], [i]] = H[[i + 1], [i]] - 400 * x[i]
        H[[i], [i + 1]] = H[[i], [i + 1]] - 400 * x[i]
        H[[i + 1], [i + 1]] = H[[i + 1], [i + 1]] + 200
    return f, g, H


def theFunctionToPlot(x, y):
    """Funtion to be plotted

    :param x: first variable
    :type x: float
    :param y: second variable
    :type y: float

    :return: value of the function
    :rtype: float
    """
    return 100 * (y - x * x) ** 2 + (1 - x) ** 2
