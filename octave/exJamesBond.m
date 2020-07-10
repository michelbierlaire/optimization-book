%> @file 
%> \f$f(x)= \frac{18}{100}x + 0.6\, \sqrt{100^2+(80-x)^2}\f$
%> @author Michel Bierlaire
%> @date Mon Nov 24 20:32:02 2014
%> @ingroup Examples

%> Example James Bond in \cite Bier06-book
function [f,g,H] = exJamesBond(x)
     f = 18 * x / 100 + 0.6 * sqrt(100*100+(80-x)*(80-x)) ;
     g = 0 ;
     H = 0 ;
endfunction
