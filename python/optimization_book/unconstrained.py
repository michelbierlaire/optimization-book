"""
Algorithms from Part IV of the book
Bierlaire (2015) Optimization: Principles and Algorithms. EPFL Press.

Michel Bierlaire
Fri Dec 10 12:14:28 2021
"""

# pylint: disable=invalid-name

import numpy as np
import scipy.linalg as la

import optimization_book.exceptions as excep


def quadraticDirect(Q, b):
    """Algorithm 9.1: quadratic problems: direct solution

    :param Q: symmetric and positive definite matrix n x n
    :type Q: np.array 2D

    :param b: vector of size n
    :type b: np.array 1D

    :return: minimum of the quadratic function
    :rtype: np.array 1D

    :raise optimizationError: if the matrix is not positive definite.
    """
    try:
        L = la.cholesky(Q).T
    except np.linalg.LinAlgError as e:
        raise excep.optimizationError(
            'The matrix must be positive definite'
        ) from e

    y = la.solve_triangular(L, -b, lower=True)
    solution = la.solve_triangular(L.T, y, lower=False)
    return solution


def conjugateGradient(Q, b, x0):
    """Algorithm 9.2: conjugate gradient method to solve the problem

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

    :rtype: np.array 1D,
            list([np.array 1D, np.array 1D, np.array 1D, float, float])

    :raise optimizationError: if the matrix is not positive definite.
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
            raise excep.optimizationError(
                'The matrix must be positive definite'
            )
        alphak = -np.asscalar(dk.T @ gk) / denom
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

    :param fct: function that returns the value of the function, its
        gradient and hessian
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
                 - status constains a message describing the reason
                   why the algorithm stopped.
    :rtype: float,
            list(int, np.array 1D, float, np.array 1D, np.array 2D),
            str

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
        return (
            x,
            iters,
            {
                f'Required precision has been reached: '
                f'{np.linalg.norm(g)} <= {eps}'
            },
        )

    return None, iters, f'Maximum number of iterations reached: {maxiter}'


def newtonLocalQuadratic(fct, x0, eps, cg=False, maxiter=100):
    """Algorithm 10.2: Newton's local method by quadratic modeling

    :param fct: function that returns the value of the function, its
        gradient and hessian
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
                 - status constains a message describing the reason
                   why the algorithm stopped.

    :rtype: float,
            list(int, np.array 1D, float, np.array 1D, np.array 2D),
            str

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
        return (
            xk,
            iters,
            (
                f'Required precision has been reached: '
                f'{np.linalg.norm(g)} <= {eps}'
            ),
        )

    return None, iters, f'Maximum number of iterations reached: {maxiter}'


def preconditionedSteepestDescent(fct, x0, D, eps, maxiter=100):
    """Algorithm 11.1: preconditioned steepest descent

    :param fct: function that returns the value of the function, its
        gradient and hessian
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

                 - status constains a message describing the reason
                   why the algorithm stopped.
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
        d = -D @ g
        alpha = -np.inner(d, g) / np.inner(d, H @ d)
        xplus = x + alpha * d
        x = xplus
        f, g, H = fct(x)
        iters.append([k, x, f, g, H])
    if np.linalg.norm(g) <= eps:
        return (
            x,
            iters,
            (
                f'Required precision has been reached: '
                f'{np.linalg.norm(g)} <= {eps}'
            ),
        )

    return None, iters, f'Maximum number of iterations reached: {maxiter}'


def initQuadraticLineSearch(h, delta, maxiter=100):
    """Algorithm 11.2: initialization of the exact line search.

    :param h: function that returns the value of h
    :type h: fct f = h(x)

    :param delta: value such that h(delta) < h(0)
    :type delta: float.

    :param maxiter: maximum number of iterations. Default: 100.
    :type maxiter: int

    :return: a, h(a), b, h(b), c, h(c)
    :rtype: list(float*6)

    :raise ValueError: if the condition hMiddle < {hLeft} is not verified.

    :raise RuntimeError: if the algorithm has not converged.
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
            raise RuntimeError(
                f'No suitable values have been found after {k} '
                f'iterations. The function may not be bounded from below'
            )
        left = middle
        hLeft = hMiddle
        middle = right
        hMiddle = hRight
        right = 2.0 * right
        hRight = h(right)
    return (left, hLeft, middle, hMiddle, right, hRight)


def quadraticInterpolation(h, delta, eps):
    """Algorithm 11.3: exact line search: quadratic interpolation

    :param h: function that returns the value of h
    :type h: fct f = h(x)

    :param delta: value such that h(delta) < h(0)
    :type delta: float.

    :param eps: requested precision
    :type eps: float.

    :return: the solution of the linear search, and the details about
        the iterations.
    :rtype: float, list(float*8)

    :raise ValueError: if h(delta) >= h(0)

    """
    if h(delta) >= h(0):
        raise ValueError(
            f'Inappropriate choice of delta: ' f'{h(delta)} >= {h(0)}'
        )
    (a, ha, b, hb, c, hc) = initQuadraticLineSearch(h, delta)
    k = 1
    # We store the iterates for future display.
    iters = list()
    s1 = max(ha, hc) - hb
    s2 = c - a
    while s1 > eps and s2 > eps:
        numerator = (
            ha * (b * b - c * c) + hb * (c * c - a * a) + hc * (a * a - b * b)
        )
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
    """Algorithm 11.4: exact line search: golden section

    :param h: function that returns the value of h
    :type h: f = h(x)

    :param l: lower bound of the interval
    :type l: float

    :param u: upper bound of the interval
    :type u: float

    :param eps: required precision
    :type eps: float

    :return: alphastar, iters, where alphastar is the global optimum
             if h is strictly unimodal and a local optimum otherwise,
             and iters contains the detsails of each iteration.
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

    :param obj: function returning the value of the objective function
        and its gradient.

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

    :return: step found, and, for each iteration:

        - alpha,
        - the lower bound,
        - the upperbound,
        - the reason why the step has been updated.

    :rtype: float, list([tuple(float, float, float, str])

    :raise optimizationError: if lbd <= 1
    :raise optimizationError: if alpha0 <= 0
    :raise optimizationError: if beta1 <= 0 or beta1 >= 1
    :raise optimizationError: if beta2 >= 1
    :raise optimizationError: if beta1 >= beta2
    :raise optimizationError: if d is not a descent direction

    """
    if lbd <= 1:
        raise excep.optimizationError(f'lambda is {lbd} and must be > 1')
    if alpha0 <= 0:
        raise excep.optimizationError(f'alpha0 is {alpha0} and must be > 0')
    if beta1 <= 0 or beta1 >= 1:
        raise excep.optimizationError(
            f'beta1 = {beta1} must be strictly between 0 and 1'
        )
    if beta2 >= 1:
        raise excep.optimizationError(
            f'beta2 = {beta2} must be strictly lesser than 1'
        )
    if beta1 >= beta2:
        raise excep.optimizationError(
            f'Incompatible Wolfe cond. parameters: beta1={beta1} '
            f'is greater or equal than beta2={beta2}'
        )

    f, g = obj(x)
    deriv = np.inner(g, d)
    if deriv >= 0:
        raise excep.optimizationError(
            f'd is not a descent direction: {deriv} >= 0'
        )
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

    :param obj: function returning the value of the objective function
        and its gradient.
    :type obj: f, g = fct(x)

    :param x0: starting point
    :type x0: numpy array

    :param eps: requested precision
    :type eps: float

    :param maxiter: maximum number of iterations
    :type maxiter: int

    :return: solution, and information about each iteration:

        - current iterate,
        - value of the function,
        - norm of the gradient

    :rtype: tuple(np.array, list(tuple(np.array, float, float))

    """
    xk = x0
    f, g = obj(xk)
    iters = list()
    iters.append([xk, f, np.linalg.norm(g)])
    k = 0
    while np.linalg.norm(g) > eps and k < maxiter:
        alpha, _ = lineSearch(
            obj, xk, -g, alpha0=1.0, beta1=1.0e-4, beta2=0.99
        )
        xk = xk - alpha * g
        f, g = obj(xk)
        k += 1
        iters.append([xk, f, np.linalg.norm(g)])
    return xk, iters


def modifiedCholesky(H):
    """Algorithm 11.7: modified Cholesky factorization

    :param H: a square symmetric matrix
    :type H: np.array 2D

    :return: Cholesky factor of H + tau * I, and tau
    :rtype: tuple(np.array, float)

    :raise optimizationError: if the matrix is not square and symmetric
    """
    tau = 0.0
    m, n = H.shape
    if m != n:
        raise excep.optimizationError(
            f'The matrix must be square and not {m}x{n}.'
        )
    if not (H.transpose() == H).all():
        raise excep.optimizationError('The matrix must be symmetric.')

    frobeniusNorm = max(np.linalg.norm(H), 1e-06)

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

    :param obj: function returning the value of the objective
        function, its gradient and hessian.
    :type obj: f, g, H = fct(x)

    :param x0: starting point
    :type x0: numpy array

    :param eps: requested precision
    :type eps: float

    :param maxiter: maximum number of iterations
    :type maxiter: int

    :return: optimal solution, and the following information about
        each iteration:

        - iterate,
        - direction,
        - tau, from the modified Cholesky,
        - alpha, the step size.

    :rtype: np.array, list(tuple(np.array, np.array, float, float))

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
        alpha, _ = lineSearch(
            objls, xk, d, alpha0=1.0, beta1=1.0e-4, beta2=0.99
        )
        xk = xk + alpha * d
        k = k + 1
        iters.append([xk, d, tau, alpha])
    opt = xk
    if k == maxiter:
        print(f'Maximum number of iteration {maxiter} reached')
    return opt, iters


def trustRegionIntersection(dc, d, delta):
    """Algorithm 12.1: Intersection with the trust region

    - Center of the trust region: :math:`\hat{x}`
    - Radius of the trust region: :math:`\Delta`
    - Point inside the trust region: :math:`x_c`
    - Direction: :math:`d_c = x_c - \hat{x}`
    - Point outside the trust region: :math:`x_d`
    - Direction: :math:`d_d = x_d - \hat{x}`

    We calculate :math:`\lambda` such that :math:`\|d_c + \lambda(d_c
    - d_c)\|_2 = \Delta`.
    See Lemma 12.4.

    :param dc: :math:`d_c`
    :type dc: np.array

    :param d: :math:`d_d-d_c`
    :type d: np.array

    :param delta: :math:`\Delta`
    :type delta: float

    :return: :math:`\lambda`
    :rtype: float
    """
    a = np.inner(d, d)
    b = 2 * np.inner(dc, d)
    c = np.inner(dc, dc) - delta ** 2
    discriminant = b * b - 4.0 * a * c
    return (-b + np.sqrt(discriminant)) / (2 * a)


def cauchyNewtonDogleg(g, H):
    """
    Calculates the Cauchy point, the Newton point, and the Dogleg point

    :param g: gradient
    :type g: np.array([n])

    :param H: hessian
    :type H: np.array([n*n])

    :return: the Cauchy point, the Newton point, and the Dogleg point
    :rtype: tuple(np.array, np.array, np.array)
    """
    alpha = np.inner(g, g)
    beta = np.inner(g, H @ g)
    dc = -(alpha / beta) * g
    dn = np.linalg.solve(H, -g)
    eta = 0.2 + (0.8 * alpha * alpha / (beta * abs(np.inner(g, dn))))
    return dc, dn, eta * dn


def dogleg(g, H, delta):
    """Find an approximate solution to the trust region subproblem.

    :param g: gradient
    :type g: np.array([n])

    :param H: hessian
    :type H: np.array([n*n])

    :param delta: radius of the trust region
    :type delta: float

    :return: approximate solution, and the diagnostic, using the
        following code:

        - type -2: negative curvature along Newton's direction
        - type -1: negative curvature along Cauchy's direction
                   (i.e. along the gradient)
        - type  1: Partial Cauchy step
        - type  2: Newton step
        - type  3: Partial Newton step
        - type  4: Dogleg

    :rtype: tuple(np.array, int)

    """

    dc, dn, dl = cauchyNewtonDogleg(g, H)

    # Check if the model is convex along the gradient direction

    alpha = np.inner(g, g)
    beta = np.inner(g, H @ g)
    if beta <= 0:
        dstar = -delta * g / np.sqrt(alpha)
        return dstar, -1

    # Compute the Cauchy point

    normdc = alpha * np.sqrt(alpha) / beta
    if normdc >= delta:
        # The Cauchy point is outside the trust
        # region. We move along the Cauchy
        # direction until the border of the trut
        # region.

        dstar = (delta / normdc) * dc
        return dstar, 1

    # Compute Newton's point

    normdn = np.linalg.norm(dn)

    # Check the convexity of the model along Newton's direction

    if np.inner(dn, H @ dn) <= 0.0:
        # Return the Cauchy point
        return dc, -2

    if normdn <= delta:
        # Newton's point is inside the trust region
        return dn, 2

    # Compute the dogleg point

    eta = 0.2 + (0.8 * alpha * alpha / (beta * abs(np.inner(g, dn))))

    partieldn = eta * np.linalg.norm(dn)

    if partieldn <= delta:
        # Dogleg point is inside the trust region
        dstar = (delta / normdn) * dn
        return dstar, 3

    # Between Cauchy and dogleg
    nu = dl - dc
    lbd = trustRegionIntersection(dc, nu, delta)
    dstar = dc + lbd * nu
    return dstar, 4


def truncatedConjugateGradient(g, H, delta):
    """Find an approximate solution to the trust region subproblem.

    :param g: gradient
    :type g: np.array([n])

    :param H: hessian
    :type H: np.array([n*n])

    :param delta: radius of the trust region
    :type delta: float

    :return: approximate solution, and the diagnostic, using the
        following code:
        - type 1: convergence
        - type 2: out of the trust region
        - type 3: negative curvature detected

    :rtype: tuple(np.array, int)
    """
    tol = 1.0e-6
    n = len(g)
    xk = np.zeros(n)
    gk = g
    dk = -gk
    for _ in range(n):
        curv = np.inner(dk, H @ dk)
        if curv <= 0:
            # Negative curvature has been detected
            diag = 3
            a = np.inner(dk, dk)
            b = 2 * np.inner(xk, dk)
            c = np.inner(xk, xk) - delta * delta
            rho = b * b - 4 * a * c
            step = xk + ((-b + np.sqrt(rho)) / (2 * a)) * dk
            return step, diag
        alphak = -np.inner(dk, gk) / curv
        xkp1 = xk + alphak * dk
        if np.linalg.norm(xkp1) > delta:
            # Out of the trust region
            diag = 2
            a = np.inner(dk, dk)
            b = 2 * np.inner(xk, dk)
            c = np.inner(xk, xk) - delta * delta
            rho = b * b - 4 * a * c
            step = xk + ((-b + np.sqrt(rho)) / (2 * a)) * dk
            return step, diag
        xk = xkp1
        gkp1 = H @ xk + g
        betak = np.inner(gkp1, gkp1) / np.inner(gk, gk)
        dk = -gkp1 + betak * dk
        gk = gkp1
        if np.linalg.norm(gkp1) <= tol:
            diag = 1
            step = xk
            return step, diag
    diag = 1
    step = xk
    return step, diag


def newtonTrustRegion(obj, x0, delta0=10, eps=1.0e-6, dl=True, maxiter=1000):
    """Newton's method with trust region

    :param obj: function calculating the objective function, and its
        first and second derivatives.
    :type obj: float, np.array, 2D np.array = fct(np.array)

    :param x0: starting point
    :type x0: np.array

    :param delta0: initial radius of the trus region
    :type delta0: float

    :param eps: required precision
    :type eps: float

    :param dl: if True, the Dogleg method is used to solve the trust
        region subproblem. If False, the truncated conjugate gradient
        method is used.
    :type dl: bool

    :param maxiter: maximum number of iterations
    :type maxiter: int

    :return: the approximate of the optimal solution and, for each
       iteration, the folloiwng information:

        - the current iterate
        - the value of the objective function
        - the norm of the gradient
        - the radius of the trust region,
        - the type of solution found for the trust region subproblem,
        - the success status of the iteration.

    :rtype: np.array, list(tuple(np.array, float, float, float, int, str))

    """
    eta1 = 0.01
    eta2 = 0.9
    k = 0
    xk = x0
    f, g, H = obj(xk)
    iters = list()
    delta = delta0
    iters.append([xk, f, np.linalg.norm(g), delta, 0.0, '', ''])
    while np.linalg.norm(g) > eps and k < maxiter:
        k = k + 1
        if dl:
            step, tr_type = dogleg(g, H, delta)
        else:
            step, tr_type = truncatedConjugateGradient(g, H, delta)
        fc, gc, Hc = obj(xk + step)

        num = f - fc
        denom = -np.inner(step, g) - 0.5 * np.inner(step, H.dot(step))
        rho = num / denom
        if rho < eta1:
            # Failure: reduce the trust region
            delta = np.linalg.norm(step) / 2.0
            status = "- "
        else:
            # Candidate accepted
            xk = xk + step
            f = fc
            g = gc
            H = Hc
            if rho >= eta2:
                # Enlarge the trust region
                delta = 2 * delta
                status = "++"
            else:
                status = "+ "
        iters.append([xk, f, np.linalg.norm(g), delta, rho, tr_type, status])
    return xk, iters
