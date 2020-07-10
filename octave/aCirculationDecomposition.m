%> \file
%> Decompose a circulation into simple cycle flows
%> 
%> @author Michel Bierlaire
%> @date Tue Jul  1 17:01:52 2014
%> @ingroup Algorithms

%> Decompose a circulation into simple cycle flows
%> @param adj the adjacency matrix of the network
%> @param circ the circulation flow
%> @return simpleCycleFlows a matrix with as many columns as arcs, and as many rows as simple cycles in the decomposition
function simpleCycleFlows = aCirculationDecomposition(adj,circ)
  simpleCycleFlows = zeros(0,0) ;
  workingcirc = circ ;
  while any(workingcirc)
    theCycleFlow = acycle(adj,workingcirc) ;
    simpleCycleFlows(end+1,:) = theCycleFlow' ;
    workingcirc -= theCycleFlow ;
  endwhile
endfunction
