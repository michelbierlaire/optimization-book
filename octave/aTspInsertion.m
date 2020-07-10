%> \file
%> Compute an halmitonian path using the insertion heuristic
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 10:40:41 2014
%> @ingroup Algorithms

%> Compute an halmitonian path using the insertion heuristic
%> @param dist distance matrix
%> @param initialTour description of the initial tour stored as a successors list
%> @return permutation of the cities
function greedyTour = aTspInsertion(dist,initialTour)
  n = rows(dist) ;
  if (columns(dist) != n) 
    error("Distance matrix must be square") ;
  endif
  # First city is the depot
  next = initialTour ;
  inserted = zeros(n,1) ;
  inserted(1) = 1 ;
  for i=1:n
    if (next(i) != 0)
      inserted(next(i)) = 1 ;
    endif
  endfor
  [l,m] = aSubtourLength(next,dist);
%  printf("%f & ",l) ;
%  printTour(next) ;
  while (m <= n)
    thelength = realmax ;
    thenode = 0 ;
    for (i = 2:n)
      if (inserted(i) == 0)
%	printf("Try to insert city %d\n",i) ;
	[bestnode,bestlength] = aBestInsert(next,dist,i) ;
	if (bestlength < thelength)
	  thelength = bestlength ;
	  thenode = i ;
	  thecity = bestnode ;
	endif
      endif
    endfor
%    printf("Decide to insert city %d after city %d\n",thenode,thecity) ;    
    next = aInsert(next,thecity,thenode) ;
    inserted(thenode) = 1 ;
    [l,m] = aSubtourLength(next,dist) ;
%    printf("%.1f & ",l) ;
%    printTour(next) ;
%    printf("Length: %f\n",l) ;

  endwhile
  [l,m] = aSubtourLength(next,dist) ;
%  printf("%f & ",l) ;
%  printTour(next) 
  greedyTour = zeros(n,1) ;
  pos = 1 ;
  currentnode = 1 ;
  greedyTour(pos) = currentnode ;
  while (next(currentnode) != 0)
    pos += 1 ;
    currentnode = next(currentnode) ;
    greedyTour(pos) = currentnode ;
  endwhile
endfunction

