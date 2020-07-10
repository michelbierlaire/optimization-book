%> \file
%> Runs example 12.3 for the truncated conjugate gradients method
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Apr  9 18:21:33 2014

xcurrent = [ 9 ;  1] ;
[f,g,H] = ex1101(xcurrent) ;

delta = 4 ;
[dstar,type] = a1203trunccg(g,H,delta) 
printf("Norm of dstar: %15.8f\n",norm(dstar)) ;
printf("Next iterate: (%15.8f, %15.8f)'\n",xcurrent + dstar) ;



delta = 12  ;
[dstar,type] = a1203trunccg(g,H,delta) 
printf("Norm of dstar: %15.8f\n",norm(dstar)) ;
printf("Next iterate: (%15.8f, %15.8f)'\n",xcurrent + dstar) ;


