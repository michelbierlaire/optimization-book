"""
 Algorithm 12.4:  Newton's method with trust region

Michel Bierlaire
Sun Dec 12 11:59:02 2021
"""

import inspect
import matplotlib.pyplot as plt
import numpy as np
import optimization_book.unconstrained as unc

from ex0508 import ex0508, theFunctionToPlot


def tr_method(the_dl):
    """Describe the method used to solve the TR subproblem

    :param the_dl: if True, the Dogleg method is used to solve the trust
        region subproblem. If False, the truncated conjugate gradient
        method is used.
    :type the_dl: bool

    :return: name of the method
    :rtype: str
    """
    return 'Dogleg' if the_dl else 'Trunc. CG'


signature = inspect.signature(unc.newtonTrustRegion)
delta0 = signature.parameters['delta0'].default
dl = signature.parameters['dl'].default

print(f'*** Initial radius of the TR: {delta0}, with {tr_method(dl)}')
x0 = np.array([1, 1])
sol, iters = unc.newtonTrustRegion(ex0508, x0)
print(f'Solution found: {sol}')

print('Table 12.1, page 304')

print("k\txk\t\t\t\tf(xk)\t\t||Grad(xk)||\tDeltak\t\tRho\t\tStatus")
for k, the_iter in enumerate(iters):
    print(
        "{}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{}\t{}".format(
            k,
            the_iter[0][0],
            the_iter[0][1],
            the_iter[1],
            the_iter[2],
            the_iter[3],
            the_iter[4],
            the_iter[5],
            the_iter[6],
        )
    )

plt.title('Figure 12.3 (a) p. 303')
xlist = np.linspace(-2.0, 2.0, 1000)
ylist = np.linspace(-6.0, 6.0, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)
xiter = [the_iter[0][0] for the_iter in iters]
yiter = [the_iter[0][1] for the_iter in iters]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.show()

plt.title('Figure 12.3 (b) p. 303')

xlist = np.linspace(-1.3, 1.1, 1000)
ylist = np.linspace(-1, 2, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)
xiter = [the_iter[0][0] for the_iter in iters]
yiter = [the_iter[0][1] for the_iter in iters]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.show()


delta0 = 1
dl = signature.parameters['dl'].default
print(f'*** Initial radius of the TR: {delta0}, with {tr_method(dl)}')
x0 = np.array([1, 1])
sol, iters = unc.newtonTrustRegion(ex0508, x0, delta0=delta0)
print(f'Solution found: {sol}')

print('Table 12.2, page 305')

print("k\txk\t\t\t\tf(xk)\t\t||Grad(xk)||\tDeltak\t\tRho\t\tStatus")
for k, the_iter in enumerate(iters):
    print(
        "{}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{}\t{}".format(
            k,
            the_iter[0][0],
            the_iter[0][1],
            the_iter[1],
            the_iter[2],
            the_iter[3],
            the_iter[4],
            the_iter[5],
            the_iter[6],
        )
    )

plt.title('Figure 12.4 (a), page 307')
xlist = np.linspace(-2.0, 2.0, 1000)
ylist = np.linspace(-6.0, 6.0, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)
xiter = [the_iter[0][0] for the_iter in iters]
yiter = [the_iter[0][1] for the_iter in iters]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.show()

plt.title('Figure 12.4 (b), page 307')
xlist = np.linspace(-1.3, 1.1, 1000)
ylist = np.linspace(-1, 2, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)
xiter = [iters[k][0].item(0) for k in range(len(iters))]
yiter = [iters[k][0].item(1) for k in range(len(iters))]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.show()


delta0 = signature.parameters['delta0'].default
dl = False
print(f'*** Initial radius of the TR: {delta0}, with {tr_method(dl)}')
x0 = np.array([1, 1])
sol, iters = unc.newtonTrustRegion(ex0508, x0, dl=False)
print(f'Solution found: {sol}')


print('Table 12.3, page 306')

print("k\txk\t\t\t\tf(xk)\t\t||Grad(xk)||\tDeltak\t\tRho\t\tStatus")
for k, the_iter in enumerate(iters):
    print(
        "{}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{:+E}\t{}\t{}".format(
            k,
            the_iter[0][0],
            the_iter[0][1],
            the_iter[1],
            the_iter[2],
            the_iter[3],
            the_iter[4],
            the_iter[5],
            the_iter[6],
        )
    )


plt.title('Figure 12.5 (a), page 307')
xlist = np.linspace(-2.0, 2.0, 1000)
ylist = np.linspace(-6.0, 6.0, 1000)
X, Y = np.meshgrid(xlist, ylist)
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)
xiter = [the_iter[0][0] for the_iter in iters]
yiter = [the_iter[0][1] for the_iter in iters]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.show()

plt.title('Figure 12.5 (b), page 307')
xlist = np.linspace(0.5, 1.2, 1000)
ylist = np.linspace(0.5, 4, 1000)
X, Y = np.meshgrid(xlist, ylist) 
Z = theFunctionToPlot(X, Y)
plt.contour(X, Y, Z, 15)
xiter = [iters[k][0].item(0) for k in range(len(iters))]
yiter = [iters[k][0].item(1) for k in range(len(iters))]
plt.plot(xiter, yiter, linewidth=5, color='r')
plt.show()
