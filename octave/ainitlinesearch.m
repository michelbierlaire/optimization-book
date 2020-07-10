%> \file
%> Initialization of the exact line search
%> 
%> @author Michel Bierlaire
%> @date Fri Apr 25 23:13:58 2014
%> @ingroup Algorithms

%> Calculate \f$a\f$, \f$b\f$ and \f$c\f$ such that \f$a < b < c\f$, \f$h(a) > h(b)\f$ and \f$h(c) > h(b)\f$
%> @param obj the name of the Octave function defining h(x)
%> @param delta value such that \f$h(\delta) < h(0)\f$.
%> @return [a,b,c]
function [a,ha,b,hb,c,hc] = ainitlinesearch(obj,delta)
  xkm1 = 0 ;
  hxkm1 = feval(obj,xkm1) ;
  xk = delta ; 
  hxk = feval(obj,xk) ;
  do 
   xkm2 = xkm1 ;
   hxkm2 = hxkm1 ;
   xkm1 = xk ; 
   hxkm1 = hxk ; 
   xk = 2.0 * xk ;
   hxk = feval(obj,xk) ;
  until(hxk > hxkm1)
  a = xkm2 ;
  ha = hxkm2 ;
  b = xkm1 ; 
  hb = hxkm1 ; 
  c = xk ;       
  hc = hxk ;       
endfunction