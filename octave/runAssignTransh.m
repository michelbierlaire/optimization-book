%> \file
%> Solve the transportation problem as a transhipment problem
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @dateWed Thu Aug  7 13:30:04 2014

adj = [ 0  0  0  0  1  2  0  0 ; 
        0  0  0  0  3  4  5  0 ;
        0  0  0  0  6  0  7  8 ;
        0  0  0  0  0  9 10  0 ;
        0  0  0  0  0  0  0  0 ;
        0  0  0  0  0  0  0  0 ;
        0  0  0  0  0  0  0  0 ;
        0  0  0  0  0  0  0  0 ];



cost = [ 8000 ; 11000 ; 9000 ; 13000 ; 12000 ; 9000 ; 11000 ; 0.01 ; 14000 ; 12000 ];
lb = [ 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0  ] ;
ub = [  1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1  ] ;

supply = [ 1 ; 1 ; 1 ; 1 ; -1 ; -1 ; -1 ; -1  ] ;

[x,copt] = aTranshipment(adj,cost,lb,ub,supply)  

#coord = [ 1 1 ; 3 1 ; 5 1  ; 5 3 ; 7 1 ] ;
#labels = [ "$o$" ; "2" ; "3" ; "4" ; "$d$" ];
#aPstricks(adj,coord,labels,cost) ;

#glpk(tcost,incidenceMatrix,tsupply)

