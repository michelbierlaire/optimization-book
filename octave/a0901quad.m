%> \file
%> Direct resolution of quadratic problems. Implementation of algorithm 9.1 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Sun Apr  6 11:22:05 2014
%> @ingroup Algorithms



%> Applies the direct resolution method to solve  \f[\min_x \frac{1}{2} x^T Q x + b^T x\f] where \f$Q \in \mathbb{R}^n\times\mathbb{R}^n \f$ and \f$b \in \mathbb{R}^n\f$.
%> @param Q matrix of size \f$n \times n \f$.
%> @param b vector of size \f$n\f$.
%> @return solution: optimal solution
function solution = a0901quad(Q,b)
  L = chol(Q)' ;
  y = L \ (-b) ;
  solution = L' \ y ;
endfunction
