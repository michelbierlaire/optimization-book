%> \file
%> Runs example 9.8 for the conjugate gradient algorithm (Table 9.1).
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Sat Apr  5 23:36:20 2014

Q = [1 1 1 1 ; 1 2 2 2 ; 1 2 3 3 ; 1 2 3 4] ;
b = [-4 ; -7 ; -9 ; -10 ] ;
x0 = [5 ; 5 ; 5 ; 5] ;
[D,solution] = a0902gc(Q,b,x0) 


