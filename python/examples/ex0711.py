"""
Example 7.11, p. 194

Michel Bierlaire
Fri Dec 10 12:12:37 2021
"""
import numpy as np


def ex0711(x):
    """Example function

    :param x: variable
    :type x: float

    :return: F(x) and J(x)
    :rtype: np.array, np.array
    """
    f1 = (x[0] + 1) * (x[0] + 1) + x[1] * x[1] - 2
    f2 = np.exp(x[0]) + x[1] * x[1] * x[1] - 2
    f = np.array([f1, f2])
    J11 = 2 * (x[0] + 1)
    J12 = 2 * x[1]
    J21 = np.exp(x[0])
    J22 = 3 * x[1] * x[1]
    J = np.array([[J11, J12], [J21, J22]])
    return f, J
