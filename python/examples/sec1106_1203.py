"""
 Rosenbrock example from Sections 11.6 and 12.3

Michel Bierlaire
Sun Dec 12 13:49:38 2021
"""
import numpy as np
import matplotlib.pyplot as plt
import optimization_book.unconstrained as unc
from exRosenbrock import exRosenbrock, theFunctionToPlot

# Plot the function

xmin = -2
xmax = 2
xlist = np.linspace(xmin, xmax, 1000)
ymin = -4
ymax = 4
ylist = np.linspace(ymin, ymax, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = np.vectorize(theFunctionToPlot)(X, Y)
plt.figure(figsize=(15, 10))
ax = plt.axes(projection='3d')
# plt.contour(X,Y,Z,20)
ax.plot_surface(X, Y, Z, cmap='terrain')
ax.view_init(elev=10, azim=150)
ax.set(xlabel='x1', ylabel='x2')
plt.show()

# Steepest descent
x0 = np.array([-1.5, 1.5])
eps = 1.0e-7


def functionToMinimize(x):
    """The steepest descent algorithm only needs the function and the
    gradient. This function is just a wrapper.

    :param x: vector of variables
    :type x: np.array(2)

    :return: value of the function, and the gradient
    :rtype: float, np.array(n)

    """
    f, g, _ = exRosenbrock(x)
    return f, g


sol, iters = unc.steepestDescent(functionToMinimize, x0, eps, 10000)
print(f'Steepest descent: solution: {sol}')
print(f'Steepest descent: number of iterations: {len(iters)}')


def plotRosenbrockIters(title, iters, xmin, xmax, ymin, ymax):
    """Plots iterations on the contours of the function

    :param title: plot title
    :type title: str

    :param xmin: lower bound for the x axis
    :type xmin: float

    :param xmax: upper bound for the x axis
    :type xmax: float

    :param ymin: lower bound for the y axis
    :type ymin: float

    :param ymax: upper bound for the y axis
    :type ymax: float

    :param iters: list of information about each iteration. The
        iterate is stored at position 0.
    :type iters: list(tuple)

    """
    xlist = np.linspace(xmin, xmax, 1000)
    ylist = np.linspace(ymin, ymax, 1000)
    X, Y = np.meshgrid(xlist, ylist)
    Z = theFunctionToPlot(X, Y)
    plt.rcParams['figure.figsize'] = [15, 10]
    plt.contour(X, Y, Z, 20)
    xiter = [iters[k][0][0] for k in range(len(iters))]
    yiter = [iters[k][0][1] for k in range(len(iters))]
    plt.title(title)
    plt.xlim([xmin, xmax])
    plt.ylim([ymin, ymax])
    plt.plot(xiter, yiter, linewidth=1, color='r', marker="o", mfc='blue')
    plt.plot(1, 1, marker='*')
    plt.show()


plotRosenbrockIters(
    'Figure 11.19 (a): steepest descent', iters, -1.6, 1.1, -1, 2
)
plotRosenbrockIters(
    'Figure 11.19 (b): steepest descent', iters, 0.71, 0.81, 0.5, 0.67
)


# Solving Rosenbrock with Newton and linesearch.

x0 = np.array([-1.5, 1.5])
sol, iters = unc.newtonLineSearch(exRosenbrock, x0, eps=1.0e-7)
print(f'Newton and linesearch: solution: {sol}')
print(f'Newton and linesearch: number of iterations: {len(iters)}')

plotRosenbrockIters(
    'Figure 11.20 (a): Newton and linesearch', iters, -1.6, 1.1, -1, 2
)
plotRosenbrockIters(
    'Figure 11.20 (b): Newton and linesearch', iters, -0.5, 1.1, -0.1, 1.1
)

# Solving Rosenbrock with Newton and trust region

x0 = np.array([-1.5, 1.5])
sol, iters = unc.newtonTrustRegion(exRosenbrock, x0, eps=1.0e-7)
print(f'Newton and trus region: solution: {sol}')
print(f'Newton and trus region: number of iterations: {len(iters)}')

plotRosenbrockIters(
    'Figure 12.6 (a): Newton and trust region', iters, -1.6, 1.1, -1, 2.22
)
plotRosenbrockIters(
    'Figure 12.6 (b): Newton and trust region', iters, -0.5, 1.1, -0.1, 1.1
)
