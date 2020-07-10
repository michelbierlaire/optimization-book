%> \file
%> Calculate the shortest paths from one origin to all nodes
%> 
%> @author Michel Bierlaire
%> @date Mon Jul 28 16:12:48 2014
%> @Ingroup Algorithms

%> Calculate the shortest paths from one origin to all nodes
%> @param adj adjacency matrix of the network. Each nonzero entry corresponds to an arc. The value of the entry is the ID of the arc.
%> @param orig the origin node 
%> @return [lambda,pred] lambda is the vector of labels, pred is the vector of the predecessors in the shortest path 
function [lambda,pred] = aShortestPath(adj,cost,orig)
  arcs = aPrepareNetwork(adj) ;
  nnodes = rows(adj) ;
  lambda = realmax(nnodes,1) ;
  lambda(orig) = 0 ;
% Length of the smallest simple path
  lengthmin = (nnodes-1) * min(cost) ;
  pred(1:nnodes,1) = -1 ;
  listOfNodes = [orig] ;
  iter = 0 ;
  while (!isempty(listOfNodes))
    node = listOfNodes(1) ;
    printf("%d & ",iter) ;
    printf("\\{") ;
    printf("%d ",listOfNodes) ;
    printf("\\} & %d & ",node) ;
    for i=1:nnodes
      if (lambda(i) == realmax)
	printf("$\\infty$ &") ;
      else 
	printf("%d &",lambda(i)) ;
      endif
    endfor
%    printf("%d &",pred) ;
    iter += 1;
    printf("\\\\\n") ;
    listOfNodes(1) = [] ;
    for arcij = adj(node,:)
      if (arcij != 0)
	nodej = arcs(arcij,2) ;
	if (lambda(nodej) > lambda(node) + cost(arcij))
	  lambda(nodej) = lambda(node) + cost(arcij) ;
          if (lambda(nodej) < 0 && lambda(nodej) < lengthmin)
	    error("A cycle of negative cost has been detected")
	  endif
          pred(nodej) = node ;
          idx = find(listOfNodes == nodej) ;
          if (length(idx) == 0)
            listOfNodes(end+1) = nodej ;
	  endif
	endif
      endif
    endfor
  endwhile
  printf("%d &",iter) ;
  printf(" \\{\\} &  & ") ;
  for i=1:nnodes
      if (lambda(i) == realmax)
	printf("$\\infty$ &") ;
      else 
	printf("%d &",lambda(i)) ;
      endif
    endfor
%    printf("%d &",pred) ;
    printf("\\\\\n") ;
endfunction