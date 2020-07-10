%> \file 
%> \f$f(x)=\left\{  \begin{array}{ll} 360  x_1^2 + x_2 + x_2^2&\text{if } x_1 \leq 0 \\ 6x_1^2 + x_2 + x_2^2 & \text{if } x_1 \geq 0.  \end{array}\right.\f$
%> @author Michel Bierlaire
%> @date Mon May 12 11:37:09 2014
%> @ingroup Examples

%> Example 16.3 in \cite Bier06-book
function f = ex1603mcKinnon(x)
  if (x(1) <= 0)
    f = 360.0 * x(1) * x(1) + x(2) + x(2) * x(2) ;
  else
    f = 6 * x(1) * x(1) + x(2) + x(2) * x(2) ;
  endif
  return
endfunction
