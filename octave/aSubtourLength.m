%> \file
%> Calculate the length of a subtour of the TSP
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 18:49:46 2014
%> @ingroup Algorithms


%> Calculate the length of the current tour
%> @param next for each node, provides the next node in the tour
%> @param [l,m] l is the length, m is the number of nodes
function [l,m] = aSubtourLength(next,dist)
  currentnode = 1 ;
  l = 0 ;
  m = 1 ;
  while (currentnode != 0)
    na = currentnode ;
    if (next(currentnode) == 0)
      nb = 1 ;
    else
      nb = next(currentnode) ;
    endif
    l += dist(na,nb) ;
    m += 1 ;
    currentnode = next(currentnode) ;
  endwhile
endfunction