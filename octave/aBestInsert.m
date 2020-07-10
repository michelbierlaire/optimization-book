%> \file
%> Identifies the best insertion in a tour for the TSP
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 18:39:05 2014
%> @ingroup Algorithms

%> Inserts city i in the best place
%> @param next for each node, provides the next node in the tour
%> @param dist distance matrix
%> @param i city to be inserted
%> @return new tour
function [bestnode,bestlength] = aBestInsert(next,dist,i)
  currentnode = 1 ;
  bestnode = 0 ;
  bestlength = realmax ;
  while (currentnode != 0)
    candidate = next ;
    candidate = aInsert(candidate,currentnode,i) ;
    [l,m] = aSubtourLength(candidate,dist) ;
    if (l < bestlength) 
      bestnode = currentnode ;
      bestlength = l ;
    endif
    currentnode = next(currentnode) ;
  endwhile
endfunction


