%> \file
%>  Transform tour stored as a sequence of cities into a list of successors
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 16:35:54 2014
%> @ingroup Algorithms

%> 
%> @param tour
function succ = getTourList(sequence,n)  
  succ = zeros(n,1) ;
  p = size(sequence,1) ; 
  for i=1:p-1
    succ(sequence(i)) = sequence(i+1) ; 
  endfor
endfunction
