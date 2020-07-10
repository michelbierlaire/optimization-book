%> \file 
%> \f$F(x)=\arctan(x)\f$
%> @author Michel Bierlaire
%> @date Sat Apr  5 19:41:12 2014
%> @ingroup Examples

%> @defgroup Examples 
%> List of examples presented in the book \cite Bier06-book.

%> Example 7.5 in \cite Bier06-book
function [f,g] = ex0705(x)
     f = atan(x) ;
     g = 1.0 / (1.0 + x * x) ;
endfunction
