%> @file 
%> \f$f(x_1,x_2)=\frac{1}{2} x_1^2 + x_1 \cos(x_2)\f$
%> @author Michel Bierlaire
%> @date Sat Apr  5 19:18:51 2014
%> @ingroup Examples

%> Example 5.7 in \cite Bier06-book
function [f,g,H] = ex0507(x)
     f = 0.5 * x(1) * x(1) + x(1) * cos(x(2)) ;
     g = [ x(1) + cos(x(2)) ; -x(1) * sin(x(2)) ] ;
     H = [ 1 , -sin(x(2)) ; -sin(x(2)),-x(1)*cos(x(2))] ;
endfunction
