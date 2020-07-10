%> \file
%> Runs example 11.1 with the steepest descent algorithm with line search
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Apr  9 14:02:56 2014

x0 = [9 ; 1] ;
[solution, iteres, niter] = a1103steepest('ex1101',x0,1.0e-15) ;
solution
niter


