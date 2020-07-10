%> \file
%> Print tour stored as list of successor
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 15:32:00 2014
%> @ingroup Algorithms

%> Print tour stored as list of successor
%> @param tour
function printTour(next)
  currentnode = 1 ;
  printf("%d & ",currentnode) ;
  while (next(currentnode) != 0)
    currentnode = next(currentnode) ;
    printf("%d & ",currentnode) ;
  endwhile
  printf("1\\\\\n") ;
endfunction
