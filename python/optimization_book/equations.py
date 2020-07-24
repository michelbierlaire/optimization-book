"""
Algorithms from Part III of the book
Bierlaire (2015) Optimization: Principles and Algorithms. EPFL Press.
"""

# pylint: disable=invalid-name

import numpy as np

def machineEpsilon():
    """
    Algorithm 7.1: Machine epsilon
    """
    eps = 1.0
    while eps + 1.0 != 1.0:
        eps /= 2.0
    return eps

def newtonEquationOneVariable(fct, x0, eps, maxiters=100):
    """Algorithm 7.2: Newton's method: one variable

    :param fct: function that returns the value of the function and its derivative
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: numpy.array

    :param eps: precision to reach.
    :type eps: float.

    :param maxiters: maximum number of iterations. Default: 100.
    :type maxiters: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, the value of f and
                         the value of g,
                 - status constains a message describing the reason why the algorithm stopped.
    :rtype: float, list(int, float, float, float), str

    """
    k = 0
    x = x0
    f, g = fct(x)
    iters = list()
    iters.append([k, x, f, g])
    while np.abs(f) > eps and k <= maxiters:
        k += 1
        # The method fails if the derivative is too close to zero
        if g == 0.0:
            return None, iters, 'Division by zero'
        try:
            x = x - f / g
        except ZeroDivisionError:
            message = f'Numerical issue encountered in iteration {k}'
            return x, iters, message
        f, g = fct(x)
        iters.append([k, x, f, g])

    if np.abs(f) <= eps:
        return x, iters, f'Required precision has been reached: {np.abs(f)} <= {eps}'

    return None, iters, f'Maximum number of iterations reached: {maxiters}'

def newtonSeveralVariables(fct, x0, eps, maxiters=100):
    """Algorithm 7.3: Newton's method: n variables
    
    :param fct: function that returns the value of the function and its Jacobian
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: numpy.array

    :param eps: precision to reach.
    :type eps: float.

    :param maxiters: maximum number of iterations. Default: 100.
    :type maxiters: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, the value of f and
                         the value of g,
                 - status constains a message describing the reason why the algorithm stopped.
    :rtype: float, list(int, np.array 1D, np.array 1D, np.array 2D), str
    """
    k = 0
    x = x0
    f, J = fct(x)
    iters = list()
    iters.append([k, x, f, J])
    while np.linalg.norm(f) > eps and k <= maxiters:
        k += 1
        try:
            d = np.linalg.solve(J, -f)
            x = x + d
        except np.linalg.LinAlgError as e:
            message = f'Numerical issue encountered in iteration {k}: {e}'
            return None, message
        f, J = fct(x)
        iters.append([k, x, f, J])

    if np.linalg.norm(f) <= eps:
        return x, iters, f'Required precision has been reached: {np.linalg.norm(f)} <= {eps}'

    return None, iters, f'Maximum number of iterations reached: {maxiters}'
