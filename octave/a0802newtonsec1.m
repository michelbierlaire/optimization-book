%> \file
%> Newton's secant method. one variable. Implementation of algorithm 8.2 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Sat Apr  5 21:31:17 2014
%> @ingroup Algorithms

%> Applies Newton's secant algorithm  to solve \f$F(x)=0\f$ where \f$F:\mathbb{R}\to\mathbb{R} \f$
%> @param obj the name of the Octave function defining F(x)
%> @param x0 the starting point
%> @param a0 the first approximation of the derivative
%> @param eps  algorithm stops if \f$|F(x)| \leq \varepsilon \f$. 
%> @param maxiter maximum number of iterations (Default: 100)
%> @return root of the function
function solution = a0802newtonsec1(obj,x0,a0,eps,maxiter=100)
  xk = x0 ;
  ak = a0 ;
  f = feval(obj,xk)  ;
  k = 0 ;
  printf("%d %15.8e %15.8e %15.8e\n",k,xk,f,ak) ;
  do
    xold = xk ;
    xk = xk - f / ak ; 
    fold = f ;
    f = feval(obj,xk)  ;
    ak = (fold - f) / (xold - xk) ;
    k=k+1; 
    printf("%d %15.8e %15.8e %15.8e\n",k,xk,f,ak) ;
  until (abs(f) <= eps || k >= maxiter)
  solution = xk ;
endfunction
