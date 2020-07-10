%> \file
%> Runs example 5.7 with BFGS method with linesearch (Tables 13.1 and 13.2)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Mon Apr 14 14:48:18 2014

x0 = [1 ; 1] ;
[solution,iteres,niter] =  a1301bfgs('ex0507',x0,1.0e-15) ;


