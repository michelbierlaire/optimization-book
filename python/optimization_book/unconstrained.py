"""
Algorithms from Part IV of the book
Bierlaire (2015) Optimization: Principles and Algorithms. EPFL Press.
"""

# pylint: disable=invalid-name

import numpy as np
import scipy.linalg as la

def quadraticDirect(Q, b):
    """ Algorithm 9.1: quadratic problems: direct solution

    :param Q: symmetric and positive definite matrix n x n
    :type Q: np.array 2D

    :param b: vector of size n
    :type b: np.array 1D

    :return: minimum of the quadratic function
    :rtype: np.array 1D
    """
    L = la.cholesky(Q).T
    y = la.solve_triangular(L, -b, lower=True)
    solution = la.solve_triangular(L.T, y, lower=False)
    return solution

def conjugateGradient(Q, b, x0):
    """ Algorithm 9.2: conjugate gradient method to solve the problem

    .. math:: \\min_x \\frac{1}{2} x^T Q x + b^T x.

    :param Q: symmetric and positive definite matrix n x n
    :type Q: np.array 2D

    :param b: vector of size n
    :type b: np.array 1D

    :param x0: starting point for the iterations.
    :type x0: np.array 1D

    :return: minimum of the quadratic function, and details of the iterations:

           - the current iterate xk
           - the gradient gk
           - the direction dk
           - the step alphak
           - the step betak

    :rtype: np.array 1D, list([np.array 1D, np.array 1D, np.array 1D, float, float])
    """
    n = len(x0)
    xk = x0
    gk = Q @ xk + b
    iters = list()
    dk = -gk
    betak = 0
    for _ in range(n):
        denom = np.inner(dk, Q @ dk)
        if denom <= 0:
            raise ValueError('The matrix must be positive definite')
        alphak = - np.asscalar(dk.T @ gk) / denom
        iters.append([xk, gk, dk, alphak, betak])
        xk = xk + alphak * dk
        gkp1 = Q @ xk + b
        betak = np.inner(gkp1, gkp1) / np.inner(gk, gk)
        dk = -gkp1 + betak * dk
        gk = gkp1
    iters.append([xk, gk, dk, alphak, betak])
    return xk, iters


def newtonLocal(fct, x0, eps, maxiter=100):
    """Algorithm 10.1: Newton's local method

    :param fct: function that returns the value of the function, its gradient and hessian
    :type fct: f, g, h = fct(x)

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
                         the value of g, and the value of H
                 - status constains a message describing the reason why the algorithm stopped.
    :rtype: float, list(int, np.array 1D, float, np.array 1D, np.array 2D), str
    """
    k = 0
    x = x0
    f, g, H = fct(x)
    iters = list()
    iters.append([k, x, f, g, H])
    while np.linalg.norm(g) > eps and k <= maxiter:
        k += 1
        try:
            d = np.linalg.solve(H, -g)
            x = x + d
        except np.linalg.LinAlgError as e:
            message = f'Numerical issue encountered in iteration {k}: {e}'
            return None, iters, message
        f, g, H = fct(x)
        iters.append([k, x, f, g, H])

    if np.linalg.norm(g) <= eps:
        return x, iters, f'Required precision has been reached: {np.linalg.norm(g)} <= {eps}'

    return None, iters, f'Maximum number of iterations reached: {maxiter}'

def newtonLocalQuadratic(fct, x0, eps, cg=False, maxiter=100):
    """Algorithm 10.2: Newton's local method by quadratic modeling

    :param fct: function that returns the value of the function, its gradient and hessian
    :type fct: f, g, h = fct(x)

    :param x0: starting point for the algorithm.
    :type x0: numpy.array

    :param eps: precision to reach.
    :type eps: float.

    :param cg: if True, use the conjugate gradient algorithm
    :type cg: bool

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: x, iters, status where

                 - x is solution found, or None is
                         unsuccessful,
                 - iters contains a list of
                         tuple. For each iteration, the number of the
                         iteration, the value of x, the value of f and
                         the value of g, and the value of H
                 - status constains a message describing the reason why the algorithm stopped.
    :rtype: float, list(int, np.array 1D, float, np.array 1D, np.array 2D), str
    """
    n = len(x0)
    xk = x0
    iters = list()
    f, g, H = fct(xk)
    iters.append([xk, f, g, H])
    k = 0
    while np.linalg.norm(g) > eps and k < maxiter:
        if cg:
            d, _ = conjugateGradient(H, g, np.zeros(n))
        else:
            d = quadraticDirect(H, g)
        xk = xk + d
        f, g, H = fct(xk)
        iters.append([xk, f, g, H])
        k += 1

    if np.linalg.norm(g) <= eps:
        return xk, iters, f'Required precision has been reached: {np.linalg.norm(g)} <= {eps}'

    return None, iters, f'Maximum number of iterations reached: {maxiter}'


def preconditionedSteepestDescent(fct, x0, D, eps, maxiter=100):
    """Algorithm 11.1: preconditioned steepest descent

    :param fct: function that returns the value of the function, its gradient and hessian
    :type fct: f, g, H = fct(x)

    :param x0: starting point for the algorithm.
    :type x0: 1D numpy.array

    :param D: preconditioner
    :type D: 2D numpy.array

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
                         the value of g, and the value of H
                 - status constains a message describing the reason why the algorithm stopped.
    :rtype: float, list(int, np.array 1D, float, np.array 1D, np.array 2D), str
    """

    # All the iterates are stored for future display.
    k = 0
    x = x0
    f, g, H = fct(x)
    iters = list()
    iters.append([k, x, f, g, H])
    while np.linalg.norm(g) > eps and k <= maxiter:
        k = k + 1
        d = - D @ g
        alpha = - np.inner(d, g) / np.inner(d, H @ d)
        xplus = x + alpha * d
        x = xplus
        f, g, H = fct(x)
        iters.append([k, x, f, g, H])
    if np.linalg.norm(g) <= eps:
        return x, iters, f'Required precision has been reached: {np.linalg.norm(g)} <= {eps}'

    return None, iters, f'Maximum number of iterations reached: {maxiter}'


def initQuadraticLineSearch(h, delta, maxiter=100):
    """ Algorithm 11.2: initialization of the exact line search.

    :param h: function that returns the value of h
    :type fct: f = h(x)

    :param delta: value such that h(delta) < h(0)
    :param delta: float.

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int
    """

    left = 0
    hLeft = h(left)
    middle = delta
    hMiddle = h(middle)

    if hMiddle >= hLeft:
        raise ValueError(f'The condition {hMiddle} < {hLeft} is not verified.')
    right = 2 * delta
    hRight = h(right)
    k = 0
    while hRight <= hMiddle:
        k += 1
        if k >= maxiter:
            raise RuntimeError(f'No suitable values have been found after {k} '
                               f'iterations. The function may not be bounded from below')
        left = middle
        hLeft = hMiddle
        middle = right
        hMiddle = hRight
        right = 2.0 * right
        hRight = h(right)
    return(left, hLeft, middle, hMiddle, right, hRight)

def quadraticInterpolation(h, delta, eps):
    """ Algorithm 11.3: exact line search: quadratic interpolation

    :param h: function that returns the value of h
    :type fct: f = h(x)

    :param delta: value such that h(delta) < h(0)
    :type delta: float.

    :param eps: requested precision
    :type eps: float.
    """
    if h(delta) >= h(0):
        raise Exception(f'Inappropriate choice of delta: {h(delta)} >= {h(0)}')
    (a, ha, b, hb, c, hc) = initQuadraticLineSearch(h, delta)
    k = 1
    # We store the iterates for future display.
    iters = list()
    s1 = max(ha, hc) - hb
    s2 = c - a
    while s1 > eps and s2 > eps:
        numerator = ha * (b * b - c * c) + hb * (c * c - a * a) + hc * (a * a - b * b)
        denominator = ha * (b - c) + hb * (c - a) + hc * (a - b)
        xplus = 0.5 * numerator / denominator
        if xplus == b:
            # We introduce a perturbation to guarantee the property a < b < c
            if (b - a) < (c - b):
                xplus = b + eps / 2.0
            else:
                xplus = b - eps / 2.0
        hxplus = h(xplus)
        iters.append([a, b, c, xplus, ha, hb, hc, hxplus])
        if xplus > b:
            if hxplus > hb:
                # The new triplet is a, b, x+
                c = xplus
                hc = hxplus
            else:
                # The new triplet is b, x+, c
                a = b
                ha = hb
                b = xplus
                hb = hxplus
        else:
            if hxplus > hb:
                # The new triplet is x+, b c
                a = xplus
                ha = hxplus
            else:
                # The new triplet is a, x+, b
                c = b
                hc = hb
                b = xplus
                hb = hxplus
        s1 = max(ha, hc) - hb
        s2 = c - a
        k = k + 1
    iters.append([a, b, c, xplus, ha, hb, hc, hxplus])
    return b, iters

def goldenSection(h, l, u, eps):
    """ Algorithm 11.4: exact line search: golden section

    :param h: function that returns the value of h
    :type fct: f = h(x)

    :param l: lower bound of the interval
    :type l: float

    :param u: upper bound of the interval
    :type u: float

    :param eps: required precision
    :type eps: float

    :return: alphastar, iters, where alphastar is the global optimum if h is strictly unimodal and a
             local optimum otherwise, and iters contains the detsails of each iteration.
    :rtype: float
    """

    rho = (3.0 - np.sqrt(5.0)) / 2.0
    alpha1 = l + rho * (u - l)
    alpha2 = u - rho * (u - l)
    h1 = h(alpha1)
    h2 = h(alpha2)
    iters = list()
    iters.append([l, alpha1, alpha2, u, h1, h2])
    k = 1
    while (u - l) > eps:
        if h1 == h2:
            l = alpha1
            u = alpha2
            alpha1 = l + rho * (u - l)
            h1 = h(alpha1)
            alpha2 = u - rho * (u - l)
            h2 = h(alpha2)
        elif h1 > h2:
            l = alpha1
            alpha1 = alpha2
            h1 = h2
            alpha2 = u - rho * (u - l)
            h2 = h(alpha2)
        else:
            u = alpha2
            alpha2 = alpha1
            h2 = h1
            alpha1 = l + rho * (u - l)
            h1 = h(alpha1)
        k += 1
        iters.append([l, alpha1, alpha2, u, h1, h2])
    xstar = (l + u) / 2.0
    return xstar, iters

def lineSearch(obj, x, d, alpha0, beta1, beta2, lbd=3):
    """Algorithm 11.5: line search

    :param obj: function returning the value of the objective function and its gradient.
    :type obj: f, g = fct(x)

    :param x: point where the line search starts.
    :type x: numpy array

    :param d: direction along which the line search is performed.
    :type d: numpy array (size dimension as x)

    :param alpha0: first trial for the step
    :type alpha0: float. Must be positive.

    :param beta1: parameter for the first Wolfe condition.
    :type beta1: float. Must be strictly between 0 and 1.

    :param beta2: parameter for the second Wolfe condition.
    :type beta2: float. Must be strictly between 0 and 1,
                 and beta2 > beta1.

    :param lbd: extension factor. Must be > 1. Default: 2.0
    :type lbd: float.

    """
    if  lbd <= 1:
        raise Exception(f'lambda is {lbd} and must be > 1')
    if  alpha0 <= 0:
        raise Exception(f'alpha0 is {alpha0} and must be > 0')
    if beta1 <= 0 or beta1 >= 1:
        raise Exception(f'beta1 = {beta1} must be strictly between 0 and 1')
    if beta2 >= 1:
        raise Exception(f'beta2 = {beta2} must be strictly lesser than 1')
    if  beta1 >= beta2:
        raise Exception(f'Incompatible Wolfe cond. parameters: beta1={beta1} '
                        f'is greater or equal than beta2={beta2}')

    f, g = obj(x)
    deriv = np.inner(g, d)
    if deriv >= 0:
        raise Exception(f'd is not a descent direction: {deriv} >= 0')
    alpha = alpha0
    # The lower bound alphal is initialized to 0.
    alphal = 0
    # The upper bound alphar is initialized to "infinity", that is,
    # the largest floating point number representable in the machine.
    alphar = np.finfo(np.float64).max
    finished = False
    iters = [(alpha, alphal, alphar, '')]
    while not finished:
        xnew = x + alpha * d
        fnew, gnew = obj(xnew)
        # First Wolfe condition
        if fnew > f + alpha * beta1 * deriv:
            reason = "too long"
            alphar = alpha
            alpha = (alphal + alphar) / 2.0
        # Second Wolfe condition
        elif np.inner(gnew, d) < beta2 * deriv:
            reason = "too short"
            alphal = alpha
            if alphar == np.finfo(np.float64).max:
                alpha = lbd * alpha
            else:
                alpha = (alphal + alphar) / 2.0
        else:
            reason = "ok"
            finished = True
        iters.append([alpha, alphal, alphar, reason])
    return alpha, iters

def steepestDescent(obj, x0, eps, maxiter=100):
    """Algorithm 11.6: steepest descent

    :param obj: function returning the value of the objective function and its gradient.
    :type obj: f, g = fct(x)

    :param x0: starting point
    :type x: numpy array

    :param eps: requested precision
    :type eps: float

    :param maxiter: maximum number of iterations
    :type maxiter: int
    """
    xk = x0
    f, g = obj(xk)
    iters = list()
    iters.append([xk, f, np.linalg.norm(g)])
    k = 0
    while np.linalg.norm(g) > eps and k < maxiter:
        alpha, _ = lineSearch(obj, xk, -g, alpha0=1.0, beta1=1.0e-4, beta2=0.99)
        xk = xk - alpha * g
        f, g = obj(xk)
        k += 1
        iters.append([xk, f, np.linalg.norm(g)])
    return xk, iters

def modifiedCholesky(H):
    """ Algorithm 11.7: modified Cholesky factorization

    :param H: a square symmetric matrix
    :type H: np.array 2D
    """
    tau = 0.0
    m, n = H.shape
    if m != n:
        raise Exception('The matrix must be square and not {m}x{n}.')
    if not (H.transpose() == H).all():
        raise Exception('The matrix must be symmetric.')

    frobeniusNorm = np.linalg.norm(H)
    if frobeniusNorm <= 1.0e-6:
        frobeniusNorm = 1.0e-6
    # Identify the smallest diagonal element
    mindiag = min(H.diagonal())
    if mindiag >= 0:
        # If non negative, we try tau = 0
        tau = 0
        R = H
    else:
        # If negative, we try tau = ||H||
        tau = frobeniusNorm
        R = H + tau * np.eye(n)
    # We check if the matrix is positive definite using its eigen values.
    mineig = min(np.linalg.eigvalsh(R))
    while mineig <= 0:
        # If it is not positive definite, we update tau
        tau = max(2 * tau, 0.5 * frobeniusNorm)
        R = H + tau * np.eye(n)
        mineig = min(np.linalg.eigvalsh(R))
    return np.linalg.cholesky(R), tau

def newtonLineSearch(obj, x0, eps, maxiter=10000):
    """Algorithm 11.8: Newton algorithm with line search
    :param obj: function returning the value of the objective function, its gradient and hessian.
    :type obj: f, g, H = fct(x)

    :param x0: starting point
    :type x: numpy array

    :param eps: requested precision
    :type eps: float
    """
    # First, we need a wrapper that returns only f and g for the line search
    def objls(x):
        f, g, _ = obj(x)
        return f, g

    xk = x0
    _, g, H = obj(xk)
    k = 0
    iters = [[xk, None, None, None]]
    while np.linalg.norm(g) > eps and k <= maxiter:
        _, g, H = obj(xk)
        L, tau = modifiedCholesky(H)
        z = la.solve_triangular(L, g, lower=True)
        d = la.solve_triangular(L.transpose(), -z)
        alpha, _ = lineSearch(objls, xk, d, alpha0=1.0, beta1=1.0e-4, beta2=0.99)
        xk = xk + alpha * d
        k = k + 1
        iters.append([xk, d, tau, alpha])
    opt = xk
    if k == maxiter:
        print(f'Maximum number of iteration {maxiter} reached')
    return opt, iters

def trustRegionIntersection(dc, d, delta):
    """Find the intersection with the trust region of radius
    :math:`\delta`, centered at :math:`\hat{x}`, along direction
    :math:`d`.

    :param dc: :math:
    Trust region of radius delta, centered at xhat
    xc in in the trust region. 
    Define dc = xc - xhat. We have ||dc|| <= delta
    Consider xd outside of the trust region. 
    Define dd = xd - xhat. We have ||dd|| > delta
    Find lbd such that || dc + lbd (dd - dc)|| = delta
    
    a = np.inner(d,d)
    b = 2 * np.inner(dc,d)
    c = np.inner(dc,dc) - delta ** 2
    discriminant = b * b - 4.0 * a * c
    return (- b + np.sqrt(discriminant) ) / (2 * a)
