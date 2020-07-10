%> \file
%> Generate the pstricks code to display a network
%> 
%> @author Michel Bierlaire
%> @date Mon Jul 28 12:32:23 2014
%> @ingroup Algorithms

%> Generate the pstricks code to display a network
%> @param adj adjacency matrix of the network. Each nonzero entry corresponds to an arc. The value of the entry is the ID of the arc.
%> @param  coordinates a matrix with 2 columns (x and y coord.) and as many rows as nodes 
function  aPstricks(adj,coordinates,nodelabels,arccosts)
  arcs = aPrepareNetwork(adj) ;
  narcs = length(arcs) ;
  nnodes = rows(adj) ;
 if (rows(nodelabels) != nnodes)
   error("Argument nodelabels should have %d rows of strinfs  and not %d",nnodes,rows(nodelabels))
 endif
 if (rows(arccosts) != narcs)
   error("Argument arccosts should be %d x 1 and not %d x %d",narcs,size(arccosts))
 endif
 if (columns(adj) != nnodes) 
   error("Adjacency matrix must be square and not %d x %d",size(adj)) ;
 endif
 if (rows(coordinates) != nnodes) 
   error("Coordinate matrix must be %d x 2 and not %d x %d ",nnodes,size(coordinates)) ;
 endif
 xmax = max(coordinates(:,1)) ;
 xmin = min(coordinates(:,1)) ;
 ymax = max(coordinates(:,2)) ;
 ymin = min(coordinates(:,2)) ;

 printf("\\begin{pspicture}(%f,%f)(%f,%f)\n",xmin-1.0,ymin-1.0,xmax+1.0,ymax+1.0) ;
 for n = 1: nnodes
  printf("\\cnodeput(%f,%f){n%d}{%s}\n",coordinates(n,1),coordinates(n,2),n,nodelabels(n,:)) ;
 endfor
 for i=1:narcs
   printf("\\ncline{->}{n%d}{n%d}\\Aput{%d}\n",arcs(i,1),arcs(i,2),arccosts(i)) ;
 endfor
 printf("\\end{pspicture}\n") ;
endfunction