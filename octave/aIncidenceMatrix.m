%> \file
%> Provide the incidence matrix of the network 
%> 
%> @author Michel Bierlaire
%> @date Wed Jul 23 09:43:15 2014
%> @ingroup Algorithms

%> Provide the incidence matrix a a network
%> @param adj the adjacency matrix of the network
%> @return A 
function A = aIncidenceMatrix(adj)

 nnodes = rows(adj) ;
 narcs = max(max(adj)) ;
 if (columns(adj) != nnodes) 
   error("Adjacency matrix must be square") ;
 endif

 arcs = aPrepareNetwork(adj) ;
 
 A = zeros(nnodes,narcs) ;

 for m=1:narcs
   i = arcs(m,1) ;
   j = arcs(m,2) ;
   A(i,m) = 1 ;
   A(j,m) = -1 ;
 endfor
endfunction