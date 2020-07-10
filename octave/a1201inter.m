%> \file
%> Calculation of the intersection with the trust region. Implementation of algorithm 12.1 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Wed Apr  9 16:46:14 2014
%> @ingroup Algorithms

%> Calculate the step along a direction that is on the border of the trust region centered at 0
%> @param x a point within the trust region , that is such that \f$ \|x\| \leq \Delta \|\f$.
%> @param d the direction 
%> @param delta the radius \f$ \Delta\f$ of the trust region
%> @return lambda The step \f$ \lambda\f$ such that \f$ \|x + \lambda d\|_2 = \Delta\f$.
function lambda = a1201inter(x,d,delta)
   a = d' * d ;
   b = 2.0 * x' * d ;
   c = x' * x - delta * delta ;
   d = b * b - 4.0 * a * c  ;
   lambda = (- b + sqrt(d) ) / (2.0 * a) ;
endfunction
