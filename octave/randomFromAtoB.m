%> \file
%> Compute a random integer between A and B
%> 
%> @author Michel Bierlaire
%> @date Sun Sep  7 19:24:28 2014
%> @ingroup Algorithms

%> Compute a random integer between A and B
%> @param A lower bound
%> @param B upper bound
%> @return r random number
function r=randomFromAtoB(A,B)
  r = 1+floor((A-1)+(B-(A-1))*rand()) ;
endfunction