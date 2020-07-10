%> \file
%> Generate a random neighbor in a neighborhood of a given size for the knpasack problem
%> 
%> @author Michel Bierlaire
%> @date Sun Sep  7 22:04:18 2014
%> @ingroup Algorithms
%> 
%> @param x0 current solution
%> @param s size of the neighborhood
%> @return x generated neighbor
function x = aKsRandomNeighbor(x0,s)
  order = randperm(size(x0)) ;
  if (s > size(x0))
    error("Size %d is larger than the size of the problem %d",size,size(x0))
  endif
  x = x0 ;
  for i=1:s
    x(order(i)) = 1-x0(order(i)) ;
  endfor
endfunction