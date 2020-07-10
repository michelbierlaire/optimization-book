%> \file
%> Runs example 5.7 with Newton's method with linesearch (Table 11.5)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Apr  9 16:39:40 2014

x0 = [1 ; 1] ;
[solution,iteres,niter] =  a1105newton('ex0507',x0,1.0e-15)


