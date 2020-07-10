%> \file
%> Apply VNS to the TSP
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 17:12:38 2014
%> @ingroup Algorithms
%> 

function [best,bestLength] = aTspVns(tour,dist)
  n = rows(dist) ;
  if (columns(dist) != n) 
    error("Distance matrix must be square") ;
  endif
  [fff,msg] = fopen("tspIters.dat","w") 
  fprintf(fff,"Iter\tNeighborhood\tCandidate\tBest\n") ;
  best = tour ;
  bestLength = tspCalculateLength(best,dist) ;
  s = 2 ;
  iter = 1 ;
  while (s <= n)
    subtourlist = getTourList(best(1:s),n) ;
    [candidate,length] = aTspInsertionLS(dist,subtourlist) ;
    fprintf(fff,"%d\t%d\t%f\t%f\n",iter,s,length,bestLength) ;
    iter += 1 ;
    if (length < bestLength)
      best = candidate ;
      bestLength = length ;
      s = 2 ;
    else
      s += 1 ;
    endif
  endwhile
  fclose(fff) ;
endfunction