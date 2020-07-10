%> \file
%> Decompose a flow vector into simple path flows
%> 
%> @author Michel Bierlaire
%> @date Tue Jul  1 17:01:52 2014
%> @ingroup Algorithms

%> Decompose a flow vector into simple path flows
%> @param adj the adjacency matrix of the network
%> @param flow the flow vector
%> @return simplePathFlows a matrix with as many columns as arcs, and as many rows as simple paths in the decomposition
function simplePathFlows = aFlowDecomposition(adj,flow)
  nnodes = rows(adj) ;
   narcs = max(max(adj)) ;

  y = adivergence(adj,flow) ;

  modAdj = [ adj  zeros(nnodes,1) ; zeros(1,nnodes+1)] ;
  arcNumber = narcs ;
  modFlow = flow ;
  for i=1:length(y)
    if (y(i) != 0)
      arcNumber += 1 ;
      modAdj(nnodes + 1,i) = arcNumber ;
      modFlow(end+1) = y(i) ;
    endif
  endfor
  simpleCycleFlow = aCirculationDecomposition(modAdj,modFlow);
  simplePathFlows = simpleCycleFlow(:,1:narcs);
endfunction
