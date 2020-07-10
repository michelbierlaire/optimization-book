%> \file
%> Run to illustrate algorithm 12.1
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Apr  9 17:26:56 2014

delta = 2.0 ;
x = [ 1 ; 0 ] ;
d = [0 ; 1];
lambda = a1201inter(x,d,delta)

d = [1 ; 0];
lambda = a1201inter(x,d,delta)

x = [0 ; 0] ;
d = [12.34 ; -23.4] ;
lambda = a1201inter(x,d,delta)
2/norm(d)