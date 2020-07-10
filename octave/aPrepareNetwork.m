%> \file
%> Prepare the network for efficient access to the data
%> 
%> @author Michel Bierlaire
%> @date Sun Jun 29 16:32:00 2014
%> @ingroup Algorithms

%> Identifies the upstream and downstream nodes of each arc
%> @param adj adjacency matrix of the network. Each nonzero entry corresponds to an arc. The value of the entry is the ID of the arc. 
%> @return arcs A matrix containing the upstream and downstream nodes of each arc. Each row corresponds to an arc. Column 1 contains the upstream node and column 2 the downstream.

function arcs = aPrepareNetwork(adj)
  nnodes = rows(adj) ;
  if (columns(adj) != nnodes) 
    error("Adjacency matrix must be square") ;
  endif
   narcs = max(max(adj)) ;
   arcs = zeros(narcs,2) ;
  for i = 1:nnodes
    for j = 1:nnodes
      if (adj(i,j) != 0)
        arcs(adj(i,j),1) = i ;
        arcs(adj(i,j),2) = j ;
      endif
    endfor
  endfor

endfunction