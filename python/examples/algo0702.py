"""
Algorithm 7.2: Newton's method: one variable
Examples 7.3, 7.4 and 7.5.

Michel Bierlaire
Fri Dec 10 12:13:48 2021
"""
import numpy as np
import optimization_book.equations as eq
import matplotlib.pyplot as plt
from ex0703 import ex0703
from ex0704 import ex0704
from ex0705 import ex0705

print('--- Example 7.3 ---')
x0 = 2
eps = 1.0e-15
xstar, iters, message = eq.newtonEquationOneVariable(ex0703, x0, eps)
print(f'Solution: {xstar}')
print(f'Diagnostic: {message}')

print('Table 7.1, p. 186')
print("k\txk\t\tF(xk)\t\tF'(xk)")
for k in iters:
    print(f'{k[0]}\t{k[1]:+E}\t{k[2]:+E}\t{k[3]:+E}')

# We plot the value of the iterate and the function as the iterations
# progress.

plt.title('Algorithm 7.2 on example 7.3: solution')
plt.xlabel('Iteration')
plt.ylabel('x')
plt.plot(np.array(iters)[:, 1])
plt.show()

plt.title('Algorithm 7.2 on example 7.3: value of the function')
plt.xlabel('Iteration')
plt.ylabel('F(x)')
plt.plot(np.array(iters)[:, 2])
plt.show()

print('--- Example 7.4 ---')
x0 = 1
eps = 1.0e-15
xstar, iters, message = eq.newtonEquationOneVariable(ex0704, x0, eps)
print(f'Solution: {xstar}')
print(f'Diagnostic: {message}')

print('Table 7.2, p. 187')
print("k\txk\t\tF(xk)\t\tF'(xk)")
for k in iters:
    print(f'{k[0]}\t{k[1]:+E}\t{k[2]:+E}\t{k[3]:+E}')

# We plot the value of the iterate and the function as the iterations
# progress.

plt.title('Algorithm 7.2 on example 7.4: solution')
plt.xlabel('Iteration')
plt.ylabel('x')
plt.plot(np.array(iters)[:, 1])
plt.show()

plt.title('Algorithm 7.2 on example 7.4: value of the function')
plt.xlabel('Iteration')
plt.ylabel('F(x)')
plt.plot(np.array(iters)[:, 2])
plt.show()

print('--- Example 7.5 ---')
x0 = 1.5
eps = 1.0e-15
xstar, iters, message = eq.newtonEquationOneVariable(ex0705, x0, eps)
print(f'Solution: {xstar}')
print(f'Diagnostic: {message}')

print('Table 7.3, p. 188')
print("k\txk\t\tF(xk)\t\tF'(xk)")
for k in iters:
    print(f'{k[0]}\t{k[1]:+E}\t{k[2]:+E}\t{k[3]:+E}')

# We plot the value of the iterate for the first five iterations
plt.title('Algorithm 7.2 on example 7.5: solution')
plt.xlabel('Iteration')
plt.ylabel('x')
plt.plot(np.array(iters)[:5, 1])
plt.show()

# We plot the value of the function as the iterations progress
plt.title('Algorithm 7.2 on example 7.5: value of the function')
plt.xlabel('Iteration')
plt.ylabel('F(x)')
plt.plot(np.array(iters)[:, 2])
plt.show()

print('--- Example 7.11 ---')
