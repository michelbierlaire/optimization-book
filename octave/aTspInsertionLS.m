%> \file
%> Local search method for the TSP based on the insertion heuristic
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 16:18:32 2014
%> @ingroup Algorithms
%> 
%> @param dist the distance matrix
%> @param subtour initial subtour stored as a succesor list
%> @return betterTour local optimum

function [bestTourSeq,bestLength] = aTspInsertionLS(dist,subtourList)
  n = rows(dist) ;
  if (columns(dist) != n) 
    error("Distance matrix must be square") ;
  endif
  betterTourList = subtourList ;
  currentList = subtourList ;
  bestTourSeq = aTspInsertion(dist,subtourList) ;
  bestLength = tspCalculateLength(bestTourSeq,dist) ;
  printf("Initial subtour: ") ;
  printTour(currentList) ;
  printf("\n");
%  printf("%d &",getTour(current)) ;
  printf("%.2f\\\\\n",bestLength) ;
  iter = 0 ;
  contin = 1 ;
  while (contin)
    contin = 0 ;
    iter += 1 ;
    [neighborhood, city1, city2] = a2optNeighborhood(getTourSequence(currentList)) ;
    for i =1:columns(neighborhood)
      tourSeq = aTspInsertion(dist,getTourList(neighborhood(:,i),n)) ;
      l = tspCalculateLength(tourSeq,dist) ;
%      printf("Best length: %f, Candidate length: %f\n",bestLength,l); 
      if (l < bestLength)
	betterTourList = getTourList(neighborhood(:,i),n) ;
	bestLength = l ;
	bestTourSeq = tourSeq ;
	bestindex = i ;
	contin =  1 ;
      endif 
    endfor
    if (contin)
      printf("=========\n") ;
      currentList'
      aTspInsertion(dist,currentList)'
      betterTourList'
      aTspInsertion(dist,betterTourList)'
      bestTourSeq'
      printf("=========\n") ;
%      printTour(bestTour) ;
      printf("%.2f & %d & %d\\\\\n",bestLength,city1(bestindex),city2(bestindex)) ;
      currentList = betterTourList ;
    endif
  endwhile
endfunction