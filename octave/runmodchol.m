%> \file
%> Example of the modified Cholesky factorization.
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Apr  9 16:03:00 2014

A = [   1.0    3.5    6.0    8.5 ;
    3.5    6.0    8.5   11.0 ;
    6.0    8.5   11.0   13.5 ;
    8.5   11.0   13.5   16.0 ]

[L, tau] = a1104modchol(A) 
L*L' - A


