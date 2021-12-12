"""
Example 11.3, p. 255

Michel Bierlaire
Fri Dec 10 12:16:35 2021
"""
import numpy as np

def h(x):
    """Example function

    :param x: variable
    :type x: float

    :return: value of the function
    :rtype: float

    """
    return (2.0 + x) * np.cos(2.0 + x)
