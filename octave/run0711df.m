%> \file
%> Runs example 7.11 with Newton's method with finite differences (Tables 8.4 and 8.5), n variables
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Sat Apr  5 20:05:14 2014

x0 = [1 ; 1] ;
tau = 1.0e-7 ;
root = a0803newtondfn('ex0711',x0,tau,1.0e-15)

tau = 0.1 ;
root = a0803newtondfn('ex0711',x0,tau,1.0e-15)


