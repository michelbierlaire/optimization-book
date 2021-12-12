"""
 Algorithm 9.1: quadratic problems: direct solution

Michel Bierlaire
Fri Dec 10 12:13:37 2021
"""

import optimization_book.unconstrained as unc
from ex0908 import Q, b

s = unc.quadraticDirect(Q, b)
print(s)
