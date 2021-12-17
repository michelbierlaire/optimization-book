"""
Algorithms from Part III of the book
Bierlaire (2015) Optimization: Principles and Algorithms. EPFL Press.

Michel Bierlaire
Fri Dec 10 12:14:54 2021
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


def newtonEquationOneVariable(fct, x0, eps, maxiter=100):
    """Algorithm 7.2: Newton's method: one variable

    :param fct: function that returns the value of the function and
        its derivative
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: float

    :param eps: precision to reach.
    :type eps: float.

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, the value of f and
                         the value of g,
                 - status constains a message describing the reason
                       why the algorithm stopped.

    :rtype: float, list(int, float, float, float), str

    """
    k = 0
    x = x0
    f, g = fct(x)
    iters = [[k, x, f, g]]
    while np.abs(f) > eps and k <= maxiter:
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
        return (
            x,
            iters,
            f'Required precision has been reached: {np.abs(f)} <= {eps}',
        )

    return None, iters, f'Maximum number of iterations reached: {maxiter}'


def newtonSeveralVariables(fct, x0, eps, maxiter=100):
    """Algorithm 7.3: Newton's method: n variables

    :param fct: function that returns the value of the function and
        its Jacobian
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: numpy.array

    :param eps: precision to reach.
    :type eps: float.

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, the value of f and
                         the value of g,
                 - status constains a message describing the reason
                   why the algorithm stopped.

    :rtype: float, list(int, np.array 1D, np.array 1D, np.array 2D), str

    """
    k = 0
    x = x0
    f, J = fct(x)
    iters = [[k, x, f, J]]
    while np.linalg.norm(f) > eps and k <= maxiter:
        k += 1
        try:
            d = np.linalg.solve(J, -f)
            x = x + d
        except np.linalg.LinAlgError as e:
            message = f'Numerical issue encountered in iteration {k}: {e}'
            return None, iters, message
        f, J = fct(x)
        iters.append([k, x, f, J])

    if np.linalg.norm(f) <= eps:
        return (
            x,
            iters,
            (
                f'Required precision has been reached: '
                f'{np.linalg.norm(f)} <= {eps}'
            ),
        )

    return None, iters, f'Maximum number of iterations reached: {maxiter}'


def newtonFinDiffOneVariable(fct, x0, eps, tau, maxiter=100):
    """Algorithm 8.1:  finite difference Newtons' method: one variable

    :param fct: function that returns the value of the function
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: float

    :param eps: precision to reach.
    :type eps: float.

    :param tau: step for the finite difference
    :type tau: float

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, and the value of f.

    :rtype: float, list(int, float, float, float), str


    """

    xk = x0
    f = fct(xk)
    k = 0
    iters = [[k, xk, f]]
    while np.abs(f) > eps and k < maxiter:
        s = tau * xk if np.abs(xk) >= 1 else tau
        fs = fct(xk + s)
        xk = xk - s * f / (fs - f)
        f = fct(xk)
        k += 1
        iters.append([k, xk, f])
    if np.abs(f) <= eps:
        status = f'Required precision has been reached: {np.abs(f)} <= {eps}'
    else:
        status = f'Maximum number of iterations reached: {maxiter}'
    return xk, iters, status


def secantOneVariable(fct, x0, a0, eps, maxiter=100):
    """Algorithm 8.2:  secant method: one variable

    :param fct: function that returns the value of the function
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: float

    :param a0: initial value for the slope of the secant
    :type a0: float

    :param eps: precision to reach.
    :type eps: float.

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, the value of f and
                         the value of ak.

    :rtype: float, list(int, float, float, float), str

    """
    xk = x0
    ak = a0
    f = fct(xk)
    k = 0
    iters = [[k, xk, f, ak]]
    while np.abs(f) > eps and k < maxiter:
        xold = xk
        xk = xk - f / ak
        fold = f
        f = fct(xk)
        ak = (fold - f) / (xold - xk)
        k += 1
        iters.append([k, xk, f, ak])
    if np.abs(f) <= eps:
        status = f'Required precision has been reached: {np.abs(f)} <= {eps}'
    else:
        status = f'Maximum number of iterations reached: {maxiter}'
    return xk, iters, status


def newtonFinDiffNVariables(fct, x0, tau, eps, maxiter=100):
    """Algorithm 8.3:  finite difference Newtons' method: several variables

    :param fct: function that returns the value of the function
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: numpy.array

    :param eps: precision to reach.
    :type eps: float.

    :param tau: step for the finite difference
    :type tau: float

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, and the value of f.

    :rtype: float, list(int, float, float, float), str


    """
    n = len(x0)
    xk = x0
    f = fct(xk)
    k = 0
    iters = [[k, xk, f]]
    I = np.eye(n)
    while np.linalg.norm(f) > eps and k < maxiter:
        A = np.empty([n, n])
        for col, xi in enumerate(xk):
            if np.abs(xi) >= 1:
                s = tau * xi
            elif xi >= 0:
                s = tau
            else:
                s = -tau
            ei = I[col]
            fp = fct(xk + s * ei)
            A[:, col] = (fp - f) / s
        d = np.linalg.solve(A, -f)
        xk = xk + d
        f = fct(xk)
        k += 1
        iters.append([k, xk, f])
    if np.linalg.norm(f) <= eps:
        status = f'Required precision has been reached: {np.linalg.norm(f)} <= {eps}'
    else:
        status = f'Maximum number of iterations reached: {maxiter}'
    return xk, iters, status


def secantNVariables(fct, x0, eps, maxiter=100):
    """Algorithm 8.4:  secant method: several variables

    :param fct: function that returns the value of the function
    :type fct: function

    :param x0: starting point for the algorithm.
    :type x0: numpy.array

    :param eps: precision to reach.
    :type eps: float.

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, the value of f and
                         the value of Ak.

    :rtype: np.array, list(int, np.array, np.array, np.array), str

    """
    n = len(x0)
    xk = x0
    f = fct(xk)
    k = 0
    A = np.eye(n)
    iters = [[k, xk, f, A]]
    while np.linalg.norm(f) > eps and k < maxiter:
        d = np.linalg.solve(A, -f)
        xk = xk + d
        fold = f
        f = fct(xk)
        y = f - fold
        update = np.outer(y - A @ d, d) / np.inner(d, d)
        A = np.add(A, update)
        k += 1
        iters.append([k, xk, f, A])
    if np.linalg.norm(f) <= eps:
        status = f'Required precision has been reached: {np.linalg.norm(f)} <= {eps}'
    else:
        status = f'Maximum number of iterations reached: {maxiter}'
    return xk, iters, status
