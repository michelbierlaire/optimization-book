%> \file 
%> \f$F(x)=((x_1+1)^2+ x_2^2 - 2, e^{x_1} + x_2^3 - 2)\f$
%> @author Michel Bierlaire
%> @date Sat Apr  5 19:59:20 2014
%> @ingroup Examples

%> Example 7.11 in \cite Bier06-book
function [F,J] = ex0711(x)
     F = [ (x(1) + 1) * (x(1) + 1) + x(2) * x(2) - 2 ; exp(x(1)) + x(2) * x(2) * x(2) - 2] ;
     J = [ 2 * (x(1) + 1) , 2 * x(2) ; exp(x(1)) , 3 * x(2) * x(2) ];
endfunction
