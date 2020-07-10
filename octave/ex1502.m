%> @file
%> Neural network
%> \f[g(x_1,x_2)= \left( \begin{array}{c}
    1 - \phi( 1.165 x_1 + x_2)  \\
    -1 - \phi( 0.626 x_1 + x_2)  \\
    -1 - \phi( 0.075 x_1+ x_2)  \\
    1 - \phi( 0.351 x_1+ x_2)  \\
    1 - \phi(-0.696 x_1+ x_2) \\
\end{array} \right) \f]
%> @author Michel Bierlaire
%> @date Wed Apr 16 23:05:19 2014
%> @ingroup Examples

%> Example 15.2 in \cite Bier06-book
function r = phi(x)
  r = (exp(x) - exp(-x)) / (exp(x) + exp(-x)) ;
endfunction 

function [g, gradg] = ex1502(x);
  g= [  1 - phi(  1.165 * x(1) + x(2)) ,
       -1 - phi(  0.626 * x(1) + x(2)) ,
       -1 - phi(  0.075 * x(1) + x(2)) ,
        1 - phi(  0.351 * x(1) + x(2)) ,
        1 - phi( -0.696 * x(1) + x(2)) ] ;

endfunction
