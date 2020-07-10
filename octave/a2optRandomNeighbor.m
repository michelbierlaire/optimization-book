%> \file
%> Generate one random 2-opt neighbor for the TSP
%> 
%> @author Michel Bierlaire
%> @date Sun Sep  7 19:21:07 2014
%> @ingroup Algorithms

%> Generate one random 2-opt neighbor for the TSP
%> @param cities current tour
%> @return neighbor the selected neighbor

function neighbor = a2optRandomNeighbor(cities)
  first = 1 ;
  i = randomFromAtoB(2,size(cities)-1) ;
  j = randomFromAtoB(i+1,size(cities)) ;
  neighbor = a2opt(cities,i,j) ; 
endfunction

