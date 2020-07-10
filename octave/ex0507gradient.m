%> @file 
%> \f$F(x_1,x_2)=(x_1 + \cos(x_2) ; -x_1 \sin(x_2))\f$
%> @author Michel Bierlaire
%> @date Sat Apr  5 23:44:09 2014
%> @ingroup Examples

%> Gradient of example 5.7 in \cite Bier06-book
function [F,J] = ex0507gradient(x)
     F = [ x(1) + cos(x(2)) ; -x(1) * sin(x(2)) ] ;
     J = [ 1 , -sin(x(2)) ; -sin(x(2)),-x(1)*cos(x(2))] ;
endfunction
