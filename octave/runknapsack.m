utility = [ 80 31 48 17 27 84 34 39 46 58 23 67]';
weight =  [ 84 27 47 22 21 96 42 46 54 53 32 78]';
capacity = 300 ;

x0 = [ 0 0 0 0 0 0 0 0 0 0 0 0 ]' ;

%x = aKsRandomNeighbor(x0,4)

%localOptimum = aKsLocalSearchDeterministic(utility,weight,capacity,x0,1)
%localOptimum = aKsVns(utility,weight,capacity,x0)
localOptimum = aKsSimulatedAnnealing(utility,weight,capacity,x0)
localOptimum'*utility

for i=1:12
  if (localOptimum(i) != 0)
    printf("%d ",i)
  endif
endfor  
printf("\n")
