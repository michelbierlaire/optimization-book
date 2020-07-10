%> \file
%> Local Newton for optimization using the quadratic model. Implementation of algorithm 10.2 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Sun Apr  6 11:39:15 2014
%> @ingroup Algorithms

%> Applies local Newton algorithm to solve \f$\nabla f(x)=0\f$ where \f$\nabla f:\mathbb{R}^n\to\mathbb{R}^n \f$ is the gradient of the objective function.
%> @param obj the name of the Octave function defining \f$\nabla f(x)\f$ and the hessian  \f$\nabla^2 f(x)\f$
%> @param x0 the starting point
%> @param eps  algorithm stops if \f$\|F(x)\| \leq \varepsilon \f$. 
%> @param maxiter maximum number of iterations (Default: 100)
%> @return [solution,f] solution: root of the function, f: value of F at the solution
function [solution,g] = a1002newtonquad(obj,x0,eps,maxiter=100)
  xk = x0 ;
  [g,H] = feval(obj,xk)  ;
  k = 0 ;
  do
    d = a0901quad(H,g) ;
    xk = xk + d  ;
    [g,H] = feval(obj,xk)  ;
    k=k+1; 
  until (norm(g) <= eps || k >= maxiter)
  solution = xk ;
endfunction
