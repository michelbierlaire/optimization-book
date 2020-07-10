%> \file
%> Runs example 17.16  of \cite Bier06-book
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Jul 23 10:45:38 2014

A = [3 2   1 0 0 0 0 0 ; 
     4 -5  0 1 0 0 0 0 ; 
     -7 -5 0 0 1 0 0 0 ; 
     -1 2  0 0 0 1 0 0 ; 
     1  0  0 0 0 0 1 0 ; 
     0  1  0 0 0 0 0 1 ] ;
b = [76 ; 40 ; -70 ; 28 ; 20 ; 20  ] ;
c = [0 ; 1 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ] ;
[x,copt,finaltableau,feasible,bounded] = a1705twophases(A,b,c)


