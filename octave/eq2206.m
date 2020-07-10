%> \file
%> Compute the divergence of a flow vector
%> 
%> @author Michel Bierlaire
%> @date Sun Jun 29 15:58:01 2014
%> @ingroup Algorithms


%> Compute the divergence of a flow vector
%> @param adj adjacency matrix of the network
%> @param flow flow vector (number of entries should be equal to the number of non zero entries of the adjacency matrix)
%> @return divergence of eachnode
function divergence = eq2206(adj,flow)
  nnodes = rows(adj) ;
  if (columns(adj) != nnodes) 
    error("Adjacency matrix must be square") ;
  endif

  divergence = zeros(nnodes, 1) ;
  for i = 1:nnodes
    for j = 1:nnodes
      if (adj(i,j) != 0)
        divergence(i) += flow(adj(i,j)) ;
        divergence(j) -= flow(adj(i,j)) ;
      endif
    endfor
  endfor
endfunction
