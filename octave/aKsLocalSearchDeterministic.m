%> \file
%> Perform a local search for the knapsack problem with a neighborhood of a given size, with a complete enumeration of the neighbors
%> 
%> @author Michel Bierlaire
%> @date Mon Sep  8 14:55:12 2014
%> @ingroup Algorithms
%> 
%> @param u utility of each item 
%> @param w weight of each item 
%> @param c capacity of the knapsack
%> @param x0 current solution
%> @param s size of the neighborhood
%> @return x local optimum

function x = aKsLocalSearchDeterministic(u,w,c,x0,s)
  n = size(u,1) ;
  if (size(w) != n)
    error("Vectors of incompatible sizes: %d and %d\n",n,size(w))
  endif
  current = x0 ;
% The next statement generates all possible combinations of s indices among n
  neighbors = nchoosek(1:n,s)'
  totalWeight = w'*x0 ;
  if (totalWeight > c)
    error("The initial solution is infeasible. Total weight: %f. Capacity %f.",totalWeight,c) 
  endif
  currentValue = u'*x0 ;
  iter = 0 ;
  contin = 1 ;
  while (contin)
    contin = 0 ;
    iter += 1  ;
    neighborsVisited = 0 ;
    for index = neighbors
      neighborsVisited += 1 ;
      candidate = current  ;
      for j = index'
	candidate(j) = 1-candidate(j) ;
      endfor
%      printf("Iter %d Neighbor %d Weight %f Utility cand. %f Utility current %f\n",iter,neighborsVisited,w'*candidate,u'*candidate,u'*current) ;
      printf("%d & %d & %d &%d &%d &%d &%d &%d &%d &%d &%d &%d &%d &%d & %d & %d& %d\n",iter,neighborsVisited,candidate',w'*candidate,u'*candidate,u'*current) ;
      if (w'*candidate <= c)
	if (u'*candidate > currentValue)
	  current = candidate ;
	  currentValue = u'*candidate ;
	  contin = 1 ;
	  break ;
	endif
      endif
    endfor
  endwhile
  x = current ;
endfunction
