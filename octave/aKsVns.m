%> \file
%> Apply VNS to the knapsack problem
%> 
%> @author Michel Bierlaire
%> @date Mon Sep  8 10:00:45 2014
%> @ingroup Algorithms
%> 
%> @param u utility of each item 
%> @param w weight of each item 
%> @param c capacity of the knapsack
%> @param x0 current solution
%> @return x local optimum

function best = aKsVns(u,w,c,x0)
  [fff,msg] = fopen("ksIters.dat","w") 
  fprintf(fff,"Neighborhood\Candidate\tBest\n") ;
  n = size(u,1) 
  if (size(w) != n)
    error("Vectors of incompatible sizes: %d and %d\n",n,size(w))
  endif
  best = x0 ;
  s = 1 ;
  while (s <= n)
    candidate = aKsLocalSearch(u,w,c,best,s) ;
    fprintf(fff,"%d\t%f\t%f\n",s,u'*candidate,u'*best) ;
    if (u'*candidate > u'*best)
      best = candidate ;
      s = 1 ;
    else
      s += 1 ;
    endif
  endwhile
  fclose(fff) ;
endfunction