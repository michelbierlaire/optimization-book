%> \file
%> Find the maximum flow vector
%> 
%> @author Michel Bierlaire
%> @date Sat Aug  9 12:38:29 2014
%> @Ingroup Algorithms

%> Find the maximum flow between two nodes using the Ford Fulkerson algorithm
%> @param adj adjacency matrix of the network. Each nonzero entry corresponds to an arc. The value of the entry is the ID of the arc.
%> @param orig the origin node 
%> @param dest the destination node 
%> @param lb the lower bound on the flow 
%> @param ub the upper bound on the flow 
%> @param flow the current flow vector
%> @return path.arcs: sequence of arcs on the path
%> @return path.dir: +1 if forward, -1 if backward
%> @return cut: array of nodes defining the cut

function [flow, total] = aFordFulkerson(adj,orig,dest,lb,ub)
 nnodes = rows(adj) ;
 narcs = max(max(adj)) ;
 if (columns(adj) != nnodes) 
   error("Adjacency matrix must be square\n") ;
 endif
 if (length(lb) != narcs) 
   error("lb vector has incorrect size %f instead of %d\n",length(lb),narcs) ;
 endif

 if (length(ub) != narcs) 
   error("ub vector has incorrect size %f instead of %d\n",length(ub),narcs) ;
 endif

 for i=1:narcs
   if lb(i) > ub(i)
     error("Incompatible bounds [%f,%f]\n",lb(i),ub(i)) ;
   endif
 end

 flow = zeros(narcs,1) ;
 total  = 0 ;
 proceed = 1 ;
 iter = 1 ;
 printf("Iter &") ;
 printf("%d &",1:narcs) ;
 printf("Flow sent & \\multicolumn{4}{l}{Path}\\\\\n") ;
 while (proceed != 0)
   printf("%d &", iter) ;
   iter += 1 ;
   printf("%d &",flow) ;
   [path, cut, pathFound] = aUnsaturatedPath(adj,orig,dest,lb,ub,flow)  ;
   if pathFound
%#     printf("Unsaturated path found\n") ;
     send = realmax ;
     for i = 1:length(path.arcs)
       theArc = path.arcs(i) ;
       if (path.dir(i) == 1) 
	 f = ub(theArc) - flow(theArc)  ;
	 if (f < send)
	   send = f ;
	 endif
       else
	 f = flow(theArc) - lb(theArc) ;
	 if (f < send)
	   send = f ;
	 endif
       endif
     endfor

#     printf("Send %f units of flows along path ",send)
     printf("%d & ",send)
     printf("%d &",path.arcs)
     printf("\\\\\n") ;

     for i = 1:length(path.arcs)
       theArc = path.arcs(i) ;
       if (path.dir(i) == 1) 
	 flow(theArc) += send ;
       else
	 flow(theArc) -= send ;
       endif
     endfor
     total += send ;
   else
     printf("\\\\\n") ;
     printf("Cut found: ") ;
     printf("%d ",cut) ;
     printf("\n",cut) ;
     proceed = 0 ;
   endif
 endwhile
endfunction