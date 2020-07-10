%> \file
%> Newton's secant method, n variables. Implementation of algorithm 8.4 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Sat Apr  5 23:27:30 2014
%> @ingroup Algorithms

%> Applies Newton's secant algorithm to solve \f$F(x)=0\f$ where \f$F:\mathbb{R}^n\to\mathbb{R}^n \f$
%> @param obj the name of the Octave function defining F(x) and its Jacobian
%> @param x0 the starting point
%> @param eps  algorithm stops if \f$\|F(x)\| \leq \varepsilon \f$. 
%> @param maxiter maximum number of iterations (Default: 100)
%> @return root of the system
function solution = a0804newtonsecn(obj,x0,eps,maxiter=100)
  xk = x0 ;
  f = feval(obj,xk)  ;
  k = 0 ;
  printf("%2d %+15.8e %+15.8e %+15.8e\n",k,xk(1),f(1),norm(f)) ;
  printf("   %+15.8e %+15.8e\n",xk(2),f(2)) ;
  n = size(x0,1) ;
  A = eye(n,n) ;
  do
  xold = xk ;
  xk = xk - A \ f  ;
  fold = f ;
  f = feval(obj,xk)  ;
  y = fold - f ;
  d = xold - xk ;
  A = A + ((y- A*d) * d') / (d' * d) ;
  k=k+1; 
#  printf("%2d %+15.8e\n",k,norm(f)) ;
  printf("%2d %+15.8e %+15.8e %+15.8e\n",k,xk(1),f(1),norm(f)) ;
  printf("   %+15.8e %+15.8e\n",xk(2),f(2)) ;
  until (norm(f) <= eps || k >= maxiter)
  solution = xk ;
endfunction
