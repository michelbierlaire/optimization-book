%> \file
%> Runs example 5.7 with Newton's method with trust region (Tables 12.1, 12.2, 12.3)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date 

x0 = [1 ; 1] ;
delta0 = 10 ;
[solution,iteres,niter] =  a1204newton('ex0507',x0,delta0,1.0e-15)

delta0 = 1 ;
[solution,iteres,niter] =  a1204newton('ex0507',x0,delta0,1.0e-15)

delta0 = 10 ;
[solution,iteres,niter] =  a1204newton('ex0507',x0,delta0,1.0e-15,1)


