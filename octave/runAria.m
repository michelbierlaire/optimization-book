%> \file
%> Runs exercice 22.4 
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Mar 18 11:30:11 2015

A = [-1 -1 -1 0 0  ; 
      1  0  0 1 0  ;
      0  0 1 -1 1  ;
      0  1 0  0 -1 ] ;
b = [ -30 ; 26 ; 12 ; -8 ] ;
c = [1 ; 1 ; 1 ; 1 ; 1 ] ;
[x,copt,finaltableau,feasible,bounded] = a1705twophases(A,b,c)


