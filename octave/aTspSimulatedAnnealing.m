%> \file
%> Simulated annealing for the TSP 
%> 
%> @author Michel Bierlaire
%> @date Sun Sep  7 11:44:24 2014
%> @ingroup Algorithms
%> 
%> @param tour initial solution
%> @param dist the distance matrix
%> @return betterTour local optimum

function [bestTour, bestTourLength] = aTspSimulatedAnnealing(tour,dist)
  [fff,msg] = fopen("tspSimAnnIters.dat","w") ;
  fprintf(fff,"Iter\tTemp\tCurrent\tBest\n") ;
  lastTemp = 0.000001 ; 
  maxiter = 50 ;
  nbrcooling = 100 ;
  current = tour ;
  bestTour = tour ;
  currentLength =  tspCalculateLength(current,dist) ;
  bestTourLength = currentLength ;
  typicalIncrease = 5.0 ; 
  firstTau = 0.999 ;
  lastTau = 0.00001 ;
  n = 0 ;
  for tt =1:nbrcooling
    a = (lastTau - firstTau) / nbrcooling ;
    temp = -typicalIncrease/log(firstTau + a * tt) ;
%    printf("Tempature %f - tau %f\n",temp,firstTau + a * tt) ;
%    printf("Current length: %.1f\n",currentLength) ;
%    printf("Best tour length: %.1f\n",bestTourLength) ;
    k = 1 ;
    iter = 0 ;
    while (iter <= maxiter)
      n += 1 ;
      fprintf(fff,"%d\t%f\t%f\t%f\n",n,temp,currentLength,bestTourLength)
      iter += 1 ;
      if (mod(iter,10) == 0 ) 
%	printf("Iter %d\n",iter) ;
      endif
      chosenNeighborhood = a2optRandomNeighbor(current) ;
      l = tspCalculateLength(chosenNeighborhood,dist) ;
      delta = l - currentLength ;
      if (delta < 0)
%	printf("Descent: accepted\n") ;
	current = chosenNeighborhood ;
	currentLength = l ;
	if (l < bestTourLength)
	  bestTour = current ;
	  bestTourLength = currentLength ;
	endif
      else
	r = rand() ;
%	printf("Random number: %f compared to %f\n",r,exp(-delta/temp))
	if r < exp(-delta/temp)
%	  printf("Ascent: accepted\n") ;
	  current = chosenNeighborhood ;
	  currentLength = l ;
	else
%	  printf("Ascent: rejected\n") ;
	endif
      endif
    endwhile
  endfor
  n += 1 ;
  fprintf(fff,"%d\t%f\t%f\t%f\n",n,temp,currentLength,bestTourLength)
  fclose(fff) ;
endfunction