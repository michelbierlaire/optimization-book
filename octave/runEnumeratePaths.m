%> \file
%> Run to illustrate the path enumeration
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Sun Jul 27 16:11:35 2014

%adj = [ 0 1  0  0 ;
%        0 0  2  3 ;
%        4 0  0  5 ;
%        0 0  0  0 ] ;

%adj = [0 1 0 0 0 0 ; 
%       0 0 0 0 2 0 ;
%       0 3 0 0 0 0 ;
%       4 0 0 0 0 0 ; 
%       0 0 0 5 0 6 ; 
%       0 0 7 0 0 0 ] ;
%adj = [0 1 2 0 ;
%       0 0 3 4 
%       0 0 0 5 ;
%       0 0 0 0 ] ;
#        1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
%cost = [ 8  1  1  1  1  8  1  1  8  8  8  1  8  1  1  8  8  8  1  1  1  8  8  8]' ;

%adj = [        0  1  0  0  2  0  0  0  0  0  0  0  0  0  0  0 ;
%               0  0  3  0  0  0  0  0  0  0  0  0  0  0  0  0 ;
%               0  0  0  4  0  0  0  0  0  0  0  0  0  0  0  0 ; 
%               0  0  0  0  0  0  0  5  0  0  0  0  0  0  0  0 ;
%               0  0  0  0  0  6  0  0  7  0  0  0  0  0  0  0 ;
%               0  8  0  0  0  0  9  0  0  0  0  0  0  0  0  0 ;
%               0  0 10  0  0  0  0 11  0  0  0  0  0  0  0  0 ;
%               0  0  0  0  0  0  0  0  0  0  0 12  0  0  0  0 ;
%               0  0  0  0  0  0  0  0  0 13  0  0 14  0  0  0 ;
%               0  0  0  0  0 15  0  0  0  0 16  0  0  0  0  0 ;
%               0  0  0  0  0  0 17  0  0  0  0 18  0  0  0  0 ;
%               0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 19 ;
%               0  0  0  0  0  0  0  0  0  0  0  0  0 20  0  0 ;
%               0  0  0  0  0  0  0  0  0 21  0  0  0  0 22  0 ;
%               0  0  0  0  0  0  0  0  0  0 23  0  0  0  0 24 ;
%               0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 ];

cost = [0 0 0 0 0 0 0 0 0 0 0 0 ]' ;

adj = [ 0  1  2  0  0  0  0 
       0  0  0  3  0  0  0 
       0  4  0  0  5  0  0 
       0  0  6  0  0  7  8 
       0  0  0  9  0  10  11 
       0  0  0  0  0  0  12 
       0  0  0  0  0  0  0 ] ;

 
arcs = aPrepareNetwork(adj) ;
nnodes = rows(adj) ;
forbiddennodes = zeros(nnodes,1) ;

forwardOnly = 0 ;
nodenames = ['a' 'b' 'c' 'd' 'e' 'f' 'g']'
o = 1 ;
d = 7 ;
[listOfPathsNodes, listOfPathsLinks] = aEnumeratePaths(adj,arcs,o,d,forbiddennodes,forwardOnly);
for i = 1:length(listOfPathsLinks)
  printf("%d & ",i) ;
  cc = 0 ;
#  for a = listOfPathsLinks{i}
  for j = 1:length(listOfPathsLinks{i})
    a = listOfPathsLinks{i}(j) ;
    cc = cc + cost(a)  ;
  endfor
%  printf("%d & ",cc) ;
  for a = listOfPathsNodes{i}
     printf("%c & ",nodenames(a)) ;
  endfor
  printf("\n") ;
endfor

#coord = [ 1 7 ; 3 7 ; 5 7 ; 7 7 ; 1 5 ; 3 5 ; 5 5 ; 7 5 ; 1 3 ; 3 3 ; 5 3 ; 7 3 ; 1 1 ; 3 1 ; 5 1 ; 7 1] ;

#aPstricks(adj,coord,cost) ;