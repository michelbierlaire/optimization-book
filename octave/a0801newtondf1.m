%> \file
%> Newton's method with finite differences, one variable. Implementation of algorithm 8.1 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Sat Apr  5 20:22:41 2014
%> @ingroup Algorithms

%> Applies Newton's algorithm with finite differences to solve \f$F(x)=0\f$ where \f$F:\mathbb{R}\to\mathbb{R} \f$
%> @param obj the name of the Octave function defining F(x)
%> @param x0 the starting point
%> @param eps  algorithm stops if \f$|F(x)| \leq \varepsilon \f$. 
%> @param tau step for the finite difference approximation
%> @param maxiter maximum number of iterations (Default: 100)
%> @return root of the function
function solution = a0801newtondf1(obj,x0,eps,tau,maxiter = 100)
  xk = x0 ;
  f = feval(obj,xk)  ;
  k = 0 ;
  printf("%d %15.8e %15.8e\n",k,xk,f) ;
  do
    if (abs(xk)>= 1) 
      s = tau * xk ;
    else
      s = tau ;
    endif
    fs = feval(obj,xk+s)  ;
    xk = xk - s * f / (fs - f) ;
    f = feval(obj,xk)  ;
    k=k+1; 
    printf("%d %15.8e %15.8e\n",k,xk,f) ;
    until (abs(f) <= eps || k >= maxiter)
  solution = xk ;
endfunction
