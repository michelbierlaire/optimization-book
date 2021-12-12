"""
Example 11.2, p. 249

Michel Bierlaire
Fri Dec 10 12:16:35 2021
"""
import numpy as np


def ex1102(x):
    """Example function

    :param x: variable
    :type x: np.array[2]

    :return: value of the function and the gradient
    :rtype: float, np.array[2]

    """
    f = 0.5 * x[0] * x[0] + 4.5 * x[1] * x[1]
    g = np.array([x[0], 9 * x[1]])
    return f, g

