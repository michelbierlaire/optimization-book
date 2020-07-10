%> \file
%> Local search method for the TSP 
%> 
%> @author Michel Bierlaire
%> @date Sun Sep  7 11:08:18 2014
%> @ingroup Algorithms
%> 
%> @param tour initial solution
%> @param dist the distance matrix
%> @return betterTour local optimum

function betterTour = aTspLocalSearch(tour,dist)
  betterTour = tour ;
  current = tour ;
  bestLength = tspCalculateLength(tour,dist) ;
  printf("%d &",current) ;
  printf("%.2f\\\\\n",bestLength) ;
  iter = 0 ;
  contin = 1 ;
  while (contin)
    contin = 0 ;
    iter += 1 ;
    [neighborhood, city1, city2] = a2optNeighborhood(current) ;
    for i =1:columns(neighborhood)
      l = tspCalculateLength(neighborhood(:,i),dist) ;
      if (l < bestLength)
	betterTour = neighborhood(:,i) ;
	bestLength = l ;
	bestindex = i ;
	contin =  1 ;
      endif 
    endfor
    if (contin)
      printf("%d &",betterTour) ;
      printf("%.2f & %d & %d\\\\\n",bestLength,city1(bestindex),city2(bestindex)) ;
      current = betterTour ;
    endif
  endwhile
endfunction