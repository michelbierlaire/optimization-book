%> \file 
%> \f$F(x)=x - \sin(x)\f$
%> @author Michel Bierlaire
%> @date Sat Apr  5 19:37:40 2014
%> @ingroup Examples

%> @defgroup Examples 
%> List of examples presented in the book \cite Bier06-book.

%> Example 7.4 in \cite Bier06-book
function [f,g] = ex0704(x)
     f = x - sin(x) ;
     g = 1 - cos(x) ;
endfunction
