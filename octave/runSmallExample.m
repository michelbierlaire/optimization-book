%> \file
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Fri Oct 20 15:01:01 2017

A = [1 -1 1 0 ; -1 -1 0 -1] ;
b = [ 2 ; 6] ;
c = [-1 ; -1 ; 0 ; 0 ] ;
[x,copt,finaltableau,feasible,bounded] = a1705twophases(A,b,c)


