%> \file
%> Perform a local search for the knapsack problem with a neighborhood of a given size
%> 
%> @author Michel Bierlaire
%> @date Sun Sep  7 22:12:01 2014
%> @ingroup Algorithms
%> 
%> @param u utility of each item 
%> @param w weight of each item 
%> @param c capacity of the knapsack
%> @param x0 current solution
%> @param s size of the neighborhood
%> @return x local optimum

function x = aKsLocalSearch(u,w,c,x0,s)
  current = x0 ;
  maxiter = 1000 ;
  totalWeight = w'*x0 ;
  if (totalWeight > c)
    error("The initial solution is infeasible. Total weight: %f. Capacity %f.",totalWeight,c) 
  endif
  currentValue = u'*x0 ;
  iter = 0 ;
  while (iter <= maxiter)
    iter += 1  ;
    candidate = aKsRandomNeighbor(current,s)  ;
%    printf("%f &",candidate) 
    if (w'*candidate <= c)
      if (u'*candidate > currentValue)
	current = candidate ;
	currentValue = u'*candidate ;
	iter = 0 ;
      endif
    endif
  endwhile
  x = current ;
endfunction
