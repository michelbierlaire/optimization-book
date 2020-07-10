%> \file
%> Newton's method, one variable. Implementation of algorithm 7.1 of \cite Bier06-book
%> 
%> @defgroup Chapter_7 List of algorithms presented in Chapter 7 of \cite Bier06-book.
%>
%> @author Michel Bierlaire
%> @date Sat Apr  5 12:07:00 2014
%> @ingroup Algorithms
%> @ingroup Chapter_7

%> @defgroup Algorithms List of algorithms presented in the book \cite Bier06-book.



%> Applies Newton's algorithm to solve \f$F(x)=0\f$ where \f$F:\mathbb{R}\to\mathbb{R} \f$
%> @param obj the name of the Octave function defining F(x) and its derivative
%> @param x0 the starting point
%> @param eps  algorithm stops if \f$|F(x)| \leq \varepsilon \f$. 
%> @param maxiter maximum number of iterations (Default: 100)
%> @return root of the function
function solution = a0701newton1(obj,x0,eps,maxiter=100)

  xk = x0 ;
  [f,g] = feval(obj,xk)  ;
  k = 0 ;
  printf("%d %15.8e %15.8e %15.8e\n",k,xk,f,g) ;
  do
    xk = xk - f / g  ;
    [f,g] = feval(obj,xk)  ;
    k=k+1; 
    printf("%d %15.8e %15.8e %15.8e\n",k,xk,f,g) ;
  until (abs(f) <= eps || k >= maxiter)
  solution = xk ;
endfunction
