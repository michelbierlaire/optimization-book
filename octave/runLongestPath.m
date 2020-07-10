%> \file
%> Run to illustrate the critical path 
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Wed Aug  6 16:40:26 2014

 
cost = [ 0  1  1  1  1  3  3  3  2  5  5  5  6  1  2  2  3  2  1]' ;

adj = [  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0 ;
         0  0  2  3  0  0  0  0  0  0  0  0  0  0  0 ;
         0  0  0  4  0  5  0  0  0  0  0  0  0  0  0 ;
         0  0  0  0  6  0  7  0  0  0  0  0  0  0  0 ;
         0  0  0  0  0  0  0  8  0  0  0  0  0  0  0 ;
         0  0  0  0  0  0  0  9  0  0  0  0  0  0  0 ;
         0  0  0  0 10  0  0  0 11  0  0  0  0  0  0 ;
         0  0  0  0  0  0  0  0  0 12  0  0  0  0  0 ;
         0  0  0  0  0  0  0  0  0  0 13  0  0  0  0 ;
         0  0  0  0  0  0  0  0  0  0  0 14  0  0  0 ;
         0  0  0  0  0  0  0  0  0  0  0 15  0 16  0 ;
         0  0  0  0  0  0  0  0  0  0  0  0 17  0  0 ;
         0  0  0  0  0  0  0  0  0  0  0  0  0  0 18 ;
         0  0  0  0  0  0  0  0  0  0  0  0  0  0 19 ;
         0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 ] ;


labels = ["$o$" ; "1" ; "2" ; "3" ; "4" ; "5" ; "6" ; "7" ; "8" ; "9" ; "10" ; "11" ; "12" ; "13" ; "$d$" ] ; 

coord = [ 1   3 ;
          3   3 ; 
          5   5 ;
          5   3 ;
          7   3 ;
          7   5 ;
          5   1 ;
          9   5 ;
          7   1 ;
         11   5 ;
          9   1 ;
         11   3 ;
         13   3 ;
         13   1 ;
         15   3 ] ; 

aPstricks(adj,coord,labels,cost) ;
 
orig = 1 ;
[lambda,pred] = aShortestPath(adj,-cost,orig) 

%[lambda,pred] = aDijkstra(adj,cost,orig) 

%nnodes = rows(adj) ;
%for i=1:nnodes
%  if (pred(i) != -1)
%    printf("%d -> %d\n",pred(i),i)
%  endif
%endfor
