%> \file
%> Newton's method, n variables. Implementation of algorithm 7.2 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Sat Apr  5 20:02:21 2014
%> @ingroup Algorithms
%> @ingroup Chapter_7

%> Applies Newton's algorithm to solve \f$F(x)=0\f$ where \f$F:\mathbb{R}^n\to\mathbb{R}^n \f$
%> @param obj the name of the Octave function defining F(x) and its Jacobian
%> @param x0 the starting point
%> @param eps  algorithm stops if \f$\|F(x)\| \leq \varepsilon \f$. 
%> @param maxiter maximum number of iterations (Default: 100)
%> @return [solution,f] solution: root of the function, f: value of F at the solution
function [solution,f] = a0702newtonn(obj,x0,eps,maxiter=100)
  xk = x0 ;
  [f,J] = feval(obj,xk)  ;
  k = 0 ;
  printf("%d %15.8e %15.8e %15.8e\n",k,xk(1),f(1),norm(f)) ;
  printf("  %15.8e %15.8e\n",xk(2),f(2)) ;
  do
    xk = xk - J \ f  ;
    [f,J] = feval(obj,xk)  ;
    k=k+1; 
    printf("%d %15.8e %15.8e %15.8e\n",k,xk(1),f(1),norm(f)) ;
    printf("  %15.8e %15.8e\n",xk(2),f(2)) ;
  until (norm(f) <= eps || k >= maxiter)
  solution = xk ;
endfunction
