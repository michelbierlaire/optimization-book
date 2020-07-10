%> \file
%> Extract a simple cycle flow from a circulation
%> 
%> @author Michel Bierlaire
%> @date Sun Jun 29 16:21:01 2014
%> @ingroup Algorithms

%> Extract a simple cycle flow from a circulation
%> @param adj the adjacency matrix of the network
%> @param circ the circulation flow
%> @return cycle flow a simple cycle flow
function cycleflow = acycle(adj,circ)
 cycleflow = zeros(size(circ)) ;
 nnodes = rows(adj) ;
 if (columns(adj) != nnodes) 
   error("Adjacency matrix must be square") ;
 endif
 arcs = aPrepareNetwork(adj) ;
# for i=1:length(arcs)
#   printf("%d->%d: %f\n",arcs(i,1),arcs(i,2),circ(i))
# endfor
 nonzeros = find(circ) ;
 if(length(nonzeros)==0)
   printf("The circ flow vector is zero")
   return 
 endif
 # Find an arc carrying positive flow
 theArc = nonzeros(1) ;
 theLoopArcs = [theArc] ;

 layerNumber = 1 ;
 if (circ(theArc) > 0) 
   layer{layerNumber} = arcs(theArc,2) ;
   otherNode = arcs(theArc,1) ;
   theLoopOrientation = [1] ;
 else
   layer{layerNumber} = arcs(theArc,1) ;
   otherNode = arcs(theArc,2) ;
   theLoopOrientation = [-1] ;
 endif
 inserted = 1 ;
 treatedNodes = zeros(nnodes,1) ;
 treatedNodes(layer{layerNumber}) = 1 ;
 while (inserted != 0)
#  printf("Layer %d\n=========\n",layerNumber);
  inserted = 0  ;
#  printf("Current layer\n") ;
  currentlayer = zeros(0) ;
  for i = layer{layerNumber} 
#    printf("Treat node %d\n",i) ;
    for arcij = adj(i,:)
      if (arcij != 0)
        if (circ(arcij) > 0) && (treatedNodes(arcs(arcij,2)) == 0) 
#            printf("Forward arc: %d -> %d\n",arcs(arcij,1),arcs(arcij,2)); 
            currentlayer(end + 1) = arcs(arcij,2) ;
            inserted = 1 ;
            treatedNodes(arcs(arcij,2)) = 1 ;
        endif          
      endif
    endfor
    for arcij = adj(:,i)'
      if (arcij != 0)
        if (circ(arcij) < 0) && (treatedNodes(arcs(arcij,1)) == 0) 
#            printf("Backward arc: %d -> %d\n",arcs(arcij,1),arcs(arcij,2)); 
          currentlayer(end + 1) = arcs(arcij,1) ;
          inserted = 1 ;
          treatedNodes(arcs(arcij,1)) = 1 ;
        endif          
      endif
    endfor
  endfor
  layerNumber += 1 ;
  layer(layerNumber) = currentlayer; 
 endwhile


### Here, layer contains the nodes organized into layers
### Search for the node to close the loop

 for key = 1:length(layer)
   theLayer = layer{key} ;
#   printf("Look for %d in \n",otherNode)
   idx = find(theLayer == otherNode) ;
   if (length(idx) > 0) 
     theLayerOfOtherNode = key ;
     theIndexOfOtherNode = idx ;
   endif
 endfor

 theLoop = [otherNode] ; 
flowMin = realmax ;
 for k = theLayerOfOtherNode-1:-1:1
   # Find an arc carrying positive flow. It must exist by construction
   for ell = layer{k}
     theForwardArc = adj(ell,theLoop(end)) ;
     if (theForwardArc != 0)
       forwardflow = circ(theForwardArc) ;
       if (forwardflow > 0)
         theLoop(end+1) = ell ;
         theLoopArcs(end+1) = theForwardArc ;
         theLoopOrientation(end+1) = 1 ;
         if (forwardflow < flowMin) 
           flowMin = forwardflow ;
         endif
         break ; 
       endif
     endif
     theBackwardArc = adj(theLoop(end),ell) ;
     if (theBackwardArc != 0)
       backwardflow = circ(theBackwardArc) ;
       if (backwardflow < 0) 
         theLoop(end+1) = ell ;
         theLoopArcs(end+1) = theBackwardArc ;
         theLoopOrientation(end+1) = -1 ;
         if (-backwardflow < flowMin)
           flowMin = -backwardflow;
         endif 
         break ; 
       endif
     endif
   endfor
 endfor
for i = length(theLoopArcs):-1:1
  printf("%d",theLoop(i))
  if (theLoopOrientation(i) == 1) 
    printf("->") ;
  else
    printf("<-") ;
  endif
  cycleflow(theLoopArcs(i)) = flowMin * theLoopOrientation(i) ;
endfor 
  printf("%d [%f]\n",theLoop(end),flowMin)

endfunction

