%> \file
%> Runs example 11.1. It is a specific implementation of the steepest descent algortihm, illustrating the high sensitivity of the method to ill-conditioning.
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Tue Apr  8 22:17:57 2014

%>
function [f,g] = ex1101(x)
  f = 0.5 * x(1) * x(1) + 4.5 * x(2) * x(2);
  g = [ x(1) ; 9.0 * x(2)]  ;
endfunction

maxiter = 100 ;
eps = 1.0e-15 ;
xk = [ 9.0 ; 1.0] ;
[f,g] = ex1101(xk) ;
k = 0 ;
do
  dk = -g ;
  alphak = (xk(1) * xk(1) + 81.0 * xk(2) * xk(2)) / (xk(1) * xk(1) + 729.0 * xk(2) * xk(2)) ;
  printf("%d %15.8e %15.8e %15.8e %15.8e %3.1f %15.8e \n",k,xk(1),xk(2),g(1),g(2),alphak,f) ;
  xk = xk + alphak * dk;
 [f,g] = ex1101(xk) ;
  k = k + 1 ;
until (norm(g) <= eps || k >= maxiter)


