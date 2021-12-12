"""
 Algorithm 11.3: Exact line search: quadratic interpolation

Michel Bierlaire
Fri Dec 10 12:20:33 2021
"""
import numpy as np
import matplotlib.pyplot as plt

import optimization_book.unconstrained as unc
from ex1103 import h

xstar, iters = unc.quadraticInterpolation(h, 6, 1.0e-3)
print(f'xstar: {xstar}')

print('Table 11.2, p.256')
header = (
    'k   a        b       c         x*      '
    'h(a)     h(b)     h(c)     h(x^*)  '
)
print(header)
print(len(header) * '-')
for k, it in enumerate(iters):
    print(
        f'{k+1:2} '
        f'{it[0]:8.5f} '
        f'{it[1]:8.5f} '
        f'{it[2]:8.5f} '
        f'{it[3]:8.5f} '
        f'{it[4]:8.5f} '
        f'{it[5]:8.5f} '
        f'{it[6]:8.5f} '
        f'{it[7]:8.5f}'
    )


def interpolant(a, b, c, ha, hb, hc):
    """Quadratic interpolant for the figures. See pp. 252-253

    :param a: first interpolation point
    :type a: float

    :param b: second interpolation point
    :type b: float

    :param c: third interpolation point
    :type c: float

    :param ha: value of the function at the first interpolation point
    :type ha: float

    :param hb: value of the function at the second interpolation point
    :type hb: float

    :param hc: value of the function at the third interpolation point
    :type hc: float

    :return: the function to plot
    :rtype: float = fct(float)
    """
    b3 = ha / (a - b)
    b2 = hb / (b - a)
    b1num = (b - c) * ha + (c - a) * hb + (a - b) * hc
    b1denom = (a - b) * (c - a) * (c - b)
    b1 = b1num / b1denom

    def q(x):
        return b1 * (x - a) * (x - b) + b2 * (x - a) + b3 * (x - b)

    return q


def plotIteration(title, iteration, xlow=0, xhigh=13):
    """Illutration a specific iteration

    :param title: title of the figure
    :type title: str

    :param iteration: for each iteration, the following information:
        - first interpolation point
        - second interpolation point
        - third interpolation point
        - minimum of the parabola
        - value of the function at the first interpolation point
        - value of the function at the second interpolation point
        - value of the function at the third interpolation point
        - value of the function at the minimum of the parabola
    :type iteration: list(tuple(float*8))

    :param xlow: lower bound on the x axis
    :type xlow: float

    :param xhigh: upper bound on the x axis
    :type xhigh: float
    """
    a, b, c, x, ha, hb, hc, hx = tuple(iters[iteration])
    q = interpolant(a, b, c, ha, hb, hc)
    xrange = np.arange(0.0, 13.0, 0.001)
    plt.title(title)
    plt.plot(xrange, h(xrange), '-', xrange, q(xrange), '--')
    shift = 0.2
    plt.annotate('a', xy=(a, ha), xytext=(a + shift, ha + 2 * shift))
    plt.annotate('b', xy=(b, hb), xytext=(b + shift, hb + 2 * shift))
    plt.annotate('c', xy=(c, hc), xytext=(c + shift, hc + 2 * shift))
    plt.annotate('x', xy=(x, hx), xytext=(x + shift, hx + 2 * shift))
    xopt, yopt = [x, x], [q(x), h(x)]
    plt.xlim(xlow, xhigh)
    plt.ylim(-20, 20)
    plt.plot(xopt, yopt)
    plt.show()


plotIteration('Figure 11.2, page 255.', 0)
plotIteration('Figure 11.3, page 255', 1)
plotIteration('Figure 11.4, page 257', 2, xlow=4)
plotIteration('Figure 11.5, page 257', 3, xlow=4)
