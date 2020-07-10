%> \file
%> Compute an halmitonian path using the nearest neighbor heuristic
%> 
%> @author Michel Bierlaire
%> @date Sat Sep  6 16:11:15 2014
%> @ingroup Algorithms

%> Compute an halmitonian path using the nearest neighbor heuristic
%> @param dist distance matrix
%> @return permutation of the cities

function pi = aNearestNeighbor(dist)
  n = rows(dist) ;
  if (columns(dist) != n) 
    error("Distance matrix must be square") ;
  endif
  # First city is the depot
  currentCity = 1;
  pi = [ currentCity ] ;
  while (size(pi) != n)
    distances = dist(:,currentCity)  ;
    [s,i] = sort(distances) ;
    for j=1:size(s)
      if (s(j) != 0.0 && !any(pi==i(j)))
	  currentCity = i(j) ;
	  pi(end+1,1) = currentCity ;
	  break ;
      endif
    endfor
  endwhile
  

