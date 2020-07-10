%> \file
%> Solve a transhipment problem with bound constraints
%> 
%> @author Michel Bierlaire
%> @date Wed Jul 23 14:54:49 2014
%> @ingroup Algorithms

%> Solve the transhipment problem with bound constraints
%> @param adj the adjacency matrix of the network (dim m x m)
%> @param cost the cost vector (dim n)
%> @param lb the vector of lower bounds (dim n)
%> @param ub the vector of upper bounds (dim n)
%> @param supply the vector of supply (dim m)
%> @return cycle flow a simple cycle flow
function [x,copt] = aTranshipment(adj,cost,lb,ub,supply)
 nnodes = rows(adj) ;
 narcs = max(max(adj)) ;
 if (columns(adj) != nnodes) 
   error("Adjacency matrix must be square") ;
 endif
 if (length(cost) != narcs) 
   error("cost vector has incorrect size") ;
 endif
 if (length(lb) != narcs) 
   error("lb vector has incorrect size") ;
 endif

 if (length(ub) != narcs) 
   error("ub vector has incorrect size") ;
 endif

 for i=1:narcs
   if lb(i) > ub(i)
     error("Incompatible bounds") ;
   endif
 end
 if (length(supply) != nnodes) 
   error("supply vector has incorrect size") ;
 endif

 if (sum(supply) != 0.0) 
   error("Infeasible supply/demand vector. Must sum up to 0") ;
 endif

 [tadj,tcost,tsupply] = aTranshipmentTransform(adj,cost,lb,ub,supply)  ;
 incidenceMatrix = aIncidenceMatrix(tadj)
 [xext,copt,opttable,feasible,bounded] = a1705twophases(incidenceMatrix,tsupply,tcost) ;
 if (feasible == 0)
   printf("Problem is infeasible\n") ;
   return ;
 endif
 if (bounded == 0)
   printf("Problem is unbounded\n") ;
   return ;
 endif
 x = xext(1:narcs) ;
 x += lb;
endfunction
