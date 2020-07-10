%> \file
%> Runs example 5.7 with SR1 method with trust region (Tables 13.3 et 13.4)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Mon Apr 14 14:48:18 2014

x0 = [1 ; 1] ;
delta0 = 10 ;
[solution,iteres,niter] =  a1302sr1('ex0507',x0,delta0,1.0e-15) 


