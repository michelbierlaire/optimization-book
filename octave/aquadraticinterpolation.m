%> \file
%> Exact line search using quadratic interpolation
%> 
%> @author Michel Bierlaire
%> @date Sat Apr 26 11:49:41 2014
%> @ingroup Algorithms

%> Find a local minimum of the problem \f$\min_{x \geq 0} h(x)\f$, where \f$h:\mathbb{R}\to\mathbb{R}\f$. 
%> @param obj the name of the Octave function defining h(x) 
%> @param delta the parameter to initialize the line search. Must be such that \f$ h(\delta) < h(0)\f$. 
%> @param eps tolerance. 
%> @return xstar the local minimum
function xstar = aquadraticinterpolation(obj,delta,eps)
  [a,ha,b,hb,c,hc] = ainitlinesearch(obj,delta) ;
  k = 1 ;
  do
    beta1 = ((b-c)*ha+(c-a)*hb+(a-b)*hc)/((a-b)*(c-a)*(c-b)) ;
    beta2 = hb / (b-a) ;
    beta3 = ha / (a-b) ;
    xplus = (beta1 * (a+b) - beta2 - beta3) / (2 * beta1) ;
    if (xplus == b)
      if ((b-a) < (c-b))
        xplus =  b + eps / 2.0 ;
      else 
        xplus =  b - eps / 2.0 ;
      endif
    endif
    hxplus = feval(obj,xplus) ;
    printf("%d\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\n",k,a,b,c,xplus,ha,hb,hc,hxplus)
    if (xplus > b)
      if (hxplus > hb)
        c = xplus ;
        hc = hxplus;
      else
        a = b ;
        ha = hb ;
        b = xplus ;
        hb = hxplus ;
      endif
    else
      if (hxplus > hb)
        a = xplus ;
        ha = hxplus ;
      else
        c = b ;
        hc = hb ;
        b = xplus ;
        hb = hxplus ;
      endif
    endif
    s1 = max(ha,hc)-hb ;
    s2 = c-a ;
    k = k + 1;
  until (s1 <= eps || s2 <= eps)
  xstar = b ;
    printf("%d\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\t%.6g\n",k,a,b,c,xplus,ha,hb,hc,hxplus)
  endfunction

