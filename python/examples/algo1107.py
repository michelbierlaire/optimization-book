"""
 Algorithm 11.7: Modified Cholesky factorization

Michel Bierlaire
Fri Dec 10 13:09:47 2021
"""
import optimization_book.unconstrained as unc
from ex11xx import A


(L, tau) = unc.modifiedCholesky(A)
print(f'{tau=}')
print('L=')
print(f'{L}')
print("We show that LL' - A = tau * I")
print("LL'-A =")
print(f'{L @ L.T - A}')
