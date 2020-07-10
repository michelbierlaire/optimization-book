%> \file
%> Runs example 12.3 for the dogleg method
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Apr  9 17:53:59 2014

xcurrent = [ 9 ;  1] ;
[f,g,H] = ex1101(xcurrent) ;

delta = 1 ;
[dstar,type] = a1202dogleg(g,H,delta) ;
xcurrent + dstar
delta = 4  ;
[dstar,type] = a1202dogleg(g,H,delta) ;
xcurrent + dstar
delta = 8  ;
[dstar,type] = a1202dogleg(g,H,delta) ;
xcurrent + dstar


