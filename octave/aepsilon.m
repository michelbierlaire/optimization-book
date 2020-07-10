%> \file
%> Algorithm to compute the machine epsilon.
%> 
%> @author Michel Bierlaire
%> @date Fri Apr 18 17:34:35 2014
%> @ingroup Algorithms

%> @param s If s = 0, the epsilon is computed for double precision. If S is different from 0, it is computed for single precision.
%> @return eps is the first power of 0.5 such that \f$\varepsilon = \varepsilon + 1\f$.
function eps = aepsilon(s = 0)
   if (s != 0)
     eps = single(1.0) ;
   else 
     eps = 1.0 ;
   endif
   while (eps + 1.0 != 1.0)
     eps /= 2.0 ;
   endwhile
endfunction
