"""
Example not in the book, with a matrix that is not definite positive

Michel Bierlaire
Fri Dec 10 12:12:16 2021
"""
import numpy as np

Q = np.array(
    [[1, 2, 3, 4],
     [5, 6, 7, 8],
     [9, 10, 11, 12],
     [13, 14, 15, 16]]
)
b = np.array([-4, -7, -9, -10])
