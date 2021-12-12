"""
 Algorithm 11.2: Initialization of the exact line search

Michel Bierlaire
Fri Dec 10 12:15:47 2021
"""

import optimization_book.unconstrained as unc
from ex1103 import h

delta = 6
result = unc.initQuadraticLineSearch(h, delta)
print(result)
