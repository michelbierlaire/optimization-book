"""
Example 5.8, p. 121

Michel Bierlaire
Fri Dec 10 12:13:15 2021
"""
import numpy as np


def ex0508(x):
    """Example function

    :param x: variable
    :type x: np.array[2]

    :return: the value of the function, of the gradient abd of the hessian.
    :rtype: np.array[2], np.array[2], np.array[2x2]
    """

    f = 0.5 * x[0] * x[0] + x[0] * np.cos(x[1])
    g = np.array([x[0] + np.cos(x[1]), -x[0] * np.sin(x[1])])
    H = np.array([[1, -np.sin(x[1])], [-np.sin(x[1]), -x[0] * np.cos(x[1])]])
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

    return 0.5 * x * x + x * np.cos(y)
