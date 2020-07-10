%> \file
%> Find the shortest unsaturated path from o to d
%> 
%> @author Michel Bierlaire
%> @date Fri Aug  8 17:31:07 2014
%> @Ingroup Algorithms

%> Find an unsaturated path from o to d
%> @param adj adjacency matrix of the network. Each nonzero entry corresponds to an arc. The value of the entry is the ID of the arc.
%> @param orig the origin node 
%> @param dest the destination node 
%> @param lb the lower bound on the flow 
%> @param ub the upper bound on the flow 
%> @param flow the current flow vector
%> @return path.arcs: sequence of arcs on the path
%> @return path.dir: +1 if forward, -1 if backward
%> @return cut: array of nodes defining the cut
function [path, cut, pathFound] = aUnsaturatedPath(adj,orig,dest,lb,ub,flow)
  pathFound =  0 ;
  cut = zeros(0) ;
  arcs = aPrepareNetwork(adj) ;
  nnodes = rows(adj) ;
  treatedNodes = zeros(nnodes,1) ;

  currentlayer.arcs = -1 ;
  currentlayer.nodes = orig ;
  currentlayer.dir  = 0 ;
  
  layer{1} = currentlayer ;
  treatedNodes(orig) = 1 ;
  layerNumber = 1 ;
  inserted = 1 ;
  while (inserted != 0)
    inserted = 0 ;
#    printf("Layer %d\n=========\n",layerNumber);
    currentlayer.arcs = zeros(0) ;
    currentlayer.nodes = zeros(0) ;
    currentlayer.dir = zeros(0) ;
    for i = layer{layerNumber}.nodes
#      printf("Treat node %d\n",i) ;
      for arcij = adj(:,i)'
	if (arcij != 0)
	  if (flow(arcij) > lb(arcij) && (treatedNodes(arcs(arcij,1)) == 0)) 
#            printf("Backward arc: %d -> %d\n",arcs(arcij,1),arcs(arcij,2)); 
            currentlayer.arcs(end + 1) = arcij ;
            currentlayer.nodes(end + 1) = arcs(arcij,1) ;
            currentlayer.dir(end + 1) = -1 ;
            if (currentlayer.nodes(end) == dest) 
	      layer(end+1) = currentlayer ;
	      path = buildPathBackward(layer,dest,arcs) ;
	      pathFound = 1 ;
%	      printLayers(layer,arcs) ;
	      return ;
	    endif
            inserted = 1 ;
            treatedNodes(arcs(arcij,1)) = 1 ;
	  endif
	endif
      endfor
      for arcij = adj(i,:)
	if (arcij != 0)
	  if (flow(arcij) < ub(arcij) && (treatedNodes(arcs(arcij,2)) == 0))
#	    printf("Forward arc: %d -> %d\n",arcs(arcij,1),arcs(arcij,2)); 
            currentlayer.arcs(end + 1) = arcij ;
            currentlayer.nodes(end + 1) = arcs(arcij,2) ;
            currentlayer.dir(end + 1) = 1 ;
            if (currentlayer.nodes(end) == dest) 
	      layer(end+1) = currentlayer ;
	      path =  buildPathBackward(layer,dest,arcs) ;
              arcs(path.arcs,:)
	      pathFound = 1 ;
%	      printLayers(layer,arcs) ;
	      return ;
	    endif
            inserted = 1 ;
            treatedNodes(arcs(arcij,2)) = 1 ;
   	  endif
        endif
      endfor
    endfor
    layerNumber += 1 ;
    layer(layerNumber) = currentlayer ;
  endwhile
#  printf("Saturated cut identified\n") ;
  path.arcs = zeros(0) ;
  path.dir = zeros(0) ;
%  printLayers(layer,arcs) ;
  cut = find(treatedNodes) ;
endfunction


function path = buildPathBackward(layer,dest,arcs)
#  printf("Build path from layer\n")  ;
  path.arcs = zeros(0) ;
  path.dir = zeros(0) ;
  currentNode = dest ; 
  for i = length(layer):-1:2
#    printf("Layer %d node %d\n",i,currentNode) ;
    theLayer = layer{i} ;
    idx = find(theLayer.nodes == currentNode) ;
#    printf("Current arc %d\n",theLayer.arcs(idx)) ;
    path.dir = [theLayer.dir(idx) path.dir]   ;
    path.arcs = [theLayer.arcs(idx) path.arcs] ;
    if (theLayer.dir(idx)  == 1)
      currentNode = arcs(theLayer.arcs(idx),1) ;
    else
      currentNode = arcs(theLayer.arcs(idx),2) ;
    endif
  endfor
endfunction

function printLayers(layer,arcs)
  printf("\\hline\n") ;
  printf("\\multicolumn{3}{l}{\\text{Iteration ?}} \\\\\n") ;
  printf("\\hline\n") ;
  for i = 1:length(layer)
    printf("\\mathcal{S}_{%d} &=& \\{",i) ;
    theLayer = layer{i} ;
    for j = 1:length(theLayer.dir) 
      if (theLayer.arcs(j) == -1)
	printf("%d ",theLayer.nodes(j)) ;
	else
	  if (theLayer.dir(j) == 1)
	    printf("%d[%d \\rightarrow], ",arcs(theLayer.arcs(j),2),arcs(theLayer.arcs(j),1)) ;
	  else 
	    printf("%d[\\leftarrow %d], ",arcs(theLayer.arcs(j),1),arcs(theLayer.arcs(j),2)) ;
	  endif
	endif ;
    endfor
    printf("\\}\\\\\n") ;
  endfor
endfunction