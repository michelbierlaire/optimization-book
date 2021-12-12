"""
 Algorithm 12.1: Intersection with the trust region

Michel Bierlaire
Fri Dec 10 14:03:22 2021
"""

import matplotlib.pyplot as plt
import numpy as np
import optimization_book.unconstrained as unc
from ex12xx import xhat, delta, xc, xd

dc = xc - xhat
dd = xd - xhat
lbd = unc.trustRegionIntersection(dc, dd - dc, delta)
print(f'lambda={lbd}')
print(f'We verify that it lies on the trus region of radius {delta}')
print(f'{np.linalg.norm(dc + lbd *(dd - dc))}')
xborder = xc + lbd * (xd - xc)
print(f'The point on the border is {xborder}')


def myplot(the_ax, x, name, shift=0.05):
    """Insert a point with a label in the plot

    :param the_ax: handle of the plot
    :type the_ax: matplotlib.axes._subplots.AxesSubplot

    :param x: coordinates of the point
    :type x: np.array

    :param name: label for the point
    :type name: str

    :param shift: shift both in x and y for the label
    :type shift: float
    """
    the_ax.plot(x.item(0), x.item(1), marker='.')
    the_ax.annotate(
        name,
        xy=(x.item(0), x.item(1)),
        xytext=(x.item(0) + shift, x.item(1) + shift),
    )


if __name__ == '__main__':
    plt.rcParams["figure.figsize"] = [3, 6]
    circle = plt.Circle((1, 1), 1.0, fill=False)
    ax = plt.gca()
    ax.set_xlim((0, 3))
    ax.set_ylim((0, 6))
    ax.add_artist(circle)

    myplot(ax, xhat, 'xhat')
    myplot(ax, xc, 'xc')
    myplot(ax, xd, 'xd')
    myplot(ax, xborder, 'xborder')

    # Plot the line
    plt.title('Illustration of Algorithm 12.1')
    plt.plot([xc.item(0), xd.item(0)], [xc.item(1), xd.item(1)])

    plt.show()
