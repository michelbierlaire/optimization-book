"""
Example 7.3, p. 185

Michel Bierlaire
Fri Dec 10 12:12:54 2021
"""


def ex0703(x):
    """Example function

    :param x: variable
    :type x: float

    :return: F(x) and F'(x)
    :rtype: float, float
    """
    return x ** 2 - 2, 2 * x

def ex0703_only_f(x):
    """Example function

    :param x: variable
    :type x: float

    :return: F(x)
    :rtype: float
    """
    f, _ = ex0703(x)
    return f
