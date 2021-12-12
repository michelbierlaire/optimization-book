"""
Algorithm 7.2: Newton's method: one variable
Example 7.5, p. 188.

Michel Bierlaire
Fri Dec 10 12:12:43 2021
"""
import numpy as np


def ex0705(x):
    """Example function

    :param x: variable
    :type x: float

    :return: F(x) and F'(x)
    :rtype: float, float
    """
    f = np.arctan(x)
    g = 1.0 / (1.0 + x * x)
    return f, g
