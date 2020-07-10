%> \file
%> Run the FordFulkerson algorithm
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Fri Aug  8 17:48:59 2014


adj = [ 0  1  2  3  0  0  0  ;
        0  0  4  0  0  5  0  ;
        0  0  0  6  0  7  0  ;
        0  0  8  0  9  0  0  ;
        0  0  0  0  0 10 11  ;
        0  0  0  0  0  0 12  ;
        0  0  0  0  0  0  0  ] ;

orig = 1 ;
dest = 7 ; 
lb = [ 0 0 0 0 0 0 0 0 0 0 0 0 ]' ;
ub = [ 5 3 5 3 3 3 5 1 5 1 2 9 ]' ;
flow = [0 0 0 0 0 0 0 0 0 0 0 0]' ;


%adj = [ 0 1 2 0 0 ;
%        0 0 3 4 0 ;
%        0 0 0 0 5 ;
%        0 0 0 0 6 ;
%        0 0 0 0 0 ]
%orig =  1 ;
%dest = 5 ; 
%lb = [ 0 ; 0 ; 0 ; 0 ; 0 ; 0 ] ;
%ub = [  2 ; 3 ; 3 ; 4 ; 2 ; 1  ] ;


[flow, total] = aFordFulkerson(adj,orig,dest,lb,ub)

