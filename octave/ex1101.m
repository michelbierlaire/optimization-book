%> \file 
%> \f$f(x)=\frac{1}{2} x_1^2 + \frac{9}{2} x_2^2\f$
%> @author Michel Bierlaire
%> @date Sun Apr  6 00:10:51 2014
%> @ingroup Examples

%> Example11.1 in \cite Bier06-book
function [f,g,H] = ex1101(x)
     f = 0.5 * x(1) * x(1) + 4.5 * x(2) * x(2);
     g = [ x(1) ; 9 * x(2) ] ;
     H = [1 0 ; 0 9] ;
endfunction
