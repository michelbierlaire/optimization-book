%> \file
%> Solve the max flow problem as a transhipment problem
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @dateWed Aug  6 19:21:26 2014

adj = [ 0 1 2 0 0 ;
        0 0 3 4 0 ;
        0 0 0 0 5 ;
        0 0 0 0 6 ;
        7 0 0 0 0 ]


cost = [0 ; 0 ; 0 ; 0 ; 0 ; 0 ; -1];
lb = [ 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0] ;
ub = [  2.1 ; 3.2 ; 3.3 ; 4.4 ; 2.5 ; 1.6 ; 99 ] ;

supply = [ 0 ; 0 ; 0 ; 0 ; 0 ] ;

#[x,copt] = aTranshipment(adj,cost,lb,ub,supply)  

coord = [ 1 1 ; 3 1 ; 5 1  ; 5 3 ; 7 1 ] ;
labels = [ "$o$" ; "2" ; "3" ; "4" ; "$d$" ];
#aPstricks(adj,coord,labels,cost) ;

incidenceMatrix = aIncidenceMatrix(adj) ;
[xopt, fmin, errnum, extra] =glpk(cost,incidenceMatrix,supply,lb,ub)

