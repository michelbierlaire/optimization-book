%> \file
%> Solve the transportation problem as a transhipment problem
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @dateWed Thu Aug  7 13:30:04 2014

adj = [ 0  0  0  1  2  3  4 ; 
        0  0  0  5  6  7  8 ;
        0  0  0  9 10 11 12 ;
        0  0  0  0  0  0  0 ;
        0  0  0  0  0  0  0 ;
        0  0  0  0  0  0  0 ;
        0  0  0  0  0  0  0 ];



cost = [ 18 ; 6 ; 10 ; 9 ; 9 ; 16 ; 13 ; 7 ; 14 ; 9 ; 16 ; 5 ]
lb = [ 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ] ;
ub = [  16513 ; 16513 ; 16513 ; 16513 ; 16513 ; 16513 ; 16513 ; 16513 ; 16513 ; 16513 ; 16513 ; 16513 ] ;

supply = [ 3110 ; 3198 ; 10205 ; -8961 ; -3777 ; -2517 ; -1258 ] ;

[x,copt] = aTranshipment(adj,cost,lb,ub,supply)  

#coord = [ 1 1 ; 3 1 ; 5 1  ; 5 3 ; 7 1 ] ;
#labels = [ "$o$" ; "2" ; "3" ; "4" ; "$d$" ];
#aPstricks(adj,coord,labels,cost) ;

#glpk(tcost,incidenceMatrix,tsupply)

