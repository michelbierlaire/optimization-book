"""
Example 7.4, p. 186

Michel Bierlaire
Fri Dec 10 12:12:49 2021
"""
import numpy as np


def ex0704(x):
    """Example function

    :param x: variable
    :type x: float

    :return: F(x) and F'(x)
    :rtype: float, float
    """
    f = x - np.sin(x)
    g = 1 - np.cos(x)
    return f, g
