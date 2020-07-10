%> \file
%>  Transform tour stored as list of successor, into a sequence of cities
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 16:22:08 2014
%> @ingroup Algorithms

%> Print tour stored as list of successor
%> @param tour
function sequence = getTourSequence(next)
  currentnode = 1 ;
  sequence = [currentnode] ;
  while (next(currentnode) != 0)
    currentnode = next(currentnode) ;
    sequence = [sequence ; currentnode] ;
  endwhile
endfunction
