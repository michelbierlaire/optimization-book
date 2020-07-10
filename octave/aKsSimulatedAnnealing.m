%> \file
%> Simulated annealing for the knapsack problem
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 29 10:07:38 2014
%> @ingroup Algorithms
%> 

function [bestSack, bestSackLength, bestSackWeight] = aKsSimulatedAnnealing(u,w,c,x0)
  [fff,msg] = fopen("ksSimAnnIters.dat","w") 
  fprintf(fff,"Iter\tTemp\tCurrent_u\tCurrent_w\tBest_u\tBest_w\n") ;
  lastTemp = 0.000001 ; 
  maxiter = 5 ;
  nbrcooling = 1000 ;
  current = x0 ;
  bestSack = x0 ;
  if (w'*x0 > c)
    error("Infeasible starting point") ;
  endif
  currentLength =  u'*current;
  currentWeight = w'*current ;
  bestSackLength = currentLength ;
  bestSackWeight = currentWeight ;
  typicalIncrease = 20.0 ; 
  firstTau = 0.999 ;
  lastTau = 0.00001 ;
  n = 0 ;
  for tt =1:nbrcooling
    a = (lastTau - firstTau) / nbrcooling ;
    temp = -typicalIncrease/log(firstTau + a * tt) ;
    printf("Tempature %f - tau %f\n",temp,firstTau + a * tt) ;
    printf("Current length: %.1f\n",currentLength) ;
    printf("Best  length: %.1f\n",bestSackLength) ;
    k = 1 ;
    iter = 0 ;
    while (iter <= maxiter)
      n += 1 ;
      fprintf(fff,"%d\t%f\t%f\t%f\t%f\t%f\n",n,temp,currentLength,currentWeight,bestSackLength,bestSackWeight)
      iter += 1 ;
      chosenNeighborhood = aKsRandomNeighbor(current,1) ;
      l = chosenNeighborhood'*u ;
      weight = chosenNeighborhood'* w ;
      delta = l - currentLength ;
      if (weight > c)
%	  printf("Infeasible: rejected\n") ;
      elseif (delta > 0)
%	printf("Asscent: accepted\n") ;
	current = chosenNeighborhood ;
	currentLength = l ;
	currentWeight = current'*w ;
	if (l > bestSackLength)
	  bestSack = current ;
	  bestSackLength = currentLength ;
	  bestSackWeight = currentWeight ;
	endif
      else
	r = rand() ;
%	printf("Random number: %f compared to %f\n",r,exp(delta/temp))
	if r < exp(delta/temp)
%	  printf("Descent: accepted\n") ;
	  current = chosenNeighborhood ;
	  currentLength = l ;
	  currentWeight = current'*w ;
	else
%	  printf("Descent: rejected\n") ;
	endif
      endif
    endwhile
  endfor
  n += 1 ;
  fprintf(fff,"%d\t%f\t%f\t%f\t%f\t%f\n",n,temp,currentLength,currentWeight,bestSackLength,bestSackWeight)
  fclose(fff) ;
endfunction
