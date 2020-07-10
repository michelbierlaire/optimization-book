%> \file
%> Runs example 7.12 with Newton's method, n variables
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Sat Apr  5 20:08:35 2014

x0 = [1 ; 1] ;
root = a0702newtonn('ex0712',x0,1.0e-15)

x0 = [-1 ; -1] ;
root = a0702newtonn('ex0712',x0,1.0e-15)

x0 = [0 ; 1] ;
root = a0702newtonn('ex0712',x0,1.0e-15)


