"""
Algorithm 7.2: Newton's method: several variables
Example 7.12

Michel Bierlaire
Fri Dec 10 12:12:32 2021
"""
import numpy as np


def ex0712(x):
    """Example function

    :param x: variable
    :type x: float

    :return: F(x) and J(x)
    :rtype: np.array, np.array
    """
    f = np.array(
        [
            x[0] ** 3 - 3 * x[0] * x[1] ** 2 - 1.0,
            x[1] ** 3 - 3 * x[0] ** 2 * x[1],
        ]
    )
    J = np.array(
        [
            [3 * x[0] ** 2 - 3 * x[1] ** 2, -6 * x[0] * x[1]],
            [-6 * x[0] * x[1], 3 * x[1] ** 2 - 3 * x[0] ** 2],
        ]
    )
    return f, J
