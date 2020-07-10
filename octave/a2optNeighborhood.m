%> \file
%> Generate the 2-opt neightborhood for the TSP
%> 
%> @author Michel Bierlaire
%> @date Sun Sep  7 11:12:39 2014
%> @ingroup Algorithms

%> Generate the 2-opt neightborhood for the TSP
%> @param cities current tour
%> @return matrix containing all tours neighbor of the current one

function [neighborhood,city1, city2] = a2optNeighborhood(cities)
  first = 1 ;
  for i=2:size(cities)-1
    for j=i+1:size(cities)
      next = a2opt(cities,i,j) ; 
      if (first)
	neighborhood = next ;
	first = 0 ; 
        city1 = cities(i) ;
        city2 = cities(j) ;
      else
	neighborhood = [neighborhood  next] ;
        city1 = [city1 cities(i)] ;
        city2 = [city2 cities(j)] ;
      endif
    endfor
  endfor
endfunction

