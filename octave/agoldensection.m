%> \file
%> Exact line search using golden section
%> 
%> @author Michel Bierlaire
%> @date Sat Apr 26 20:14:41 2014
%> @ingroup Algorithms

%> Find the global minimum of \f$h(\alpha)\f$ on \f$[\ell,u]\f$, where \f$h:\mathbb{R}\to\mathbb{R}\f$ is strictly unimodular on \f$[\ell,u]\f$.
%> @param obj the name of the Octave function defining h(x) 
%> @param l the lower bound of the interval
%> @param u the upper bound of the interval
%> @param eps tolerance. 
%> @return xstar the local minimum
function xstar = agoldensection(obj,l,u,eps)
  rho = (3.0 - sqrt(5.0)) / 2.0 ;
  alpha1 = l + rho * (u - l) ;
  h1 = feval(obj,alpha1) ;
  alpha2 = u - rho * (u - l) ;
  h2 = feval(obj,alpha2) ;
  k = 1 ;
  do
    printf("%d\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\n",k,l,alpha1,alpha2,u,h1,h2)
    if (h1 == h2)
      l = alpha1 ; 
      u = alpha2 ; 
      alpha1 = l + rho * (u - l) ;
      h1 = feval(obj,alpha1) ;
      alpha2 = u - rho * (u - l) ;
      h2 = feval(obj,alpha2) ;
    elseif (h1 > h2)
      l = alpha1 ;
      alpha1 = alpha2 ;
      h1 = h2 ;
      alpha2 = u - rho * (u - l) ;
      h2 = feval(obj,alpha2) ;
    else
      u = alpha2 ;
      alpha2 = alpha1 ;
      h2 = h1 ; 
      alpha1 = l + rho * (u - l) ;
      h1 = feval(obj,alpha1) ;
    endif
    k = k + 1 ;
  until((u - l) <= eps)
  printf("%d\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\n",k,l,alpha1,alpha2,u,h1,h2)
  xstar = (l+u)/2.0 ;
endfunction

