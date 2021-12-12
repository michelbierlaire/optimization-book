"""
Example 11.1, p. 246

Michel Bierlaire
Fri Dec 10 17:42:31 2021
"""
import numpy as np


def ex1101(x):
    """Example function

    :param x: variable
    :type x: np.array[2]

    :return: value of the function, the gradient and the hessian
    :rtype: float, np.array[2], np.array[2*2]

    """
    f = 0.5 * x[0] * x[0] + 4.5 * x[1] * x[1]
    g = np.array([x[0], 9 * x[1]])
    h = np.array([[1, 0], [0, 9]])
    return f, g, h

def theFunctionToPlot(x,y):
    return(0.5 * x * x + 4.5 * y * y)
