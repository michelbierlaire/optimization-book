%> \file
%> Transform a transhipment problem into a problem in standard form
%> 
%> @author Michel Bierlaire
%> @date Sat Jul 19 09:26:25 2014
%> @ingroup Algorithms

%> Transform a transhipment problem with m nodes and n arcs into a problem in standard form
%> @param adj the adjacency matrix of the network (dim m x m)
%> @param cost the cost vector (dim n)
%> @param lb the vector of lower bounds (dim n)
%> @param ub the vector of upper bounds (dim n)
%> @param supply the vector of supply (dim m)
%> @return [tadj,tcost,tsupply] transformed adjacency matrix, transformed cost, transformed supply
function [tadj,tcost,tsupply] = aTranshipmentTransform(adj,cost,lb,ub,supply)

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

 if (length(supply) != nnodes) 
   error("supply vector has incorrect size") ;
 endif

 if (sum(supply) != 0.0) 
   error("Infeasible supply/demand vector. Must sum up to 0") ;
 endif

 arcs = aPrepareNetwork(adj) ;




 tadj = zeros(narcs+nnodes,narcs+nnodes) ;
 tsupply = [supply ; zeros(narcs,1)] ;
 tcost = [cost ; zeros(narcs,1)] ;
 for m=1:narcs
				# transform first the lower bounds to
				# zero using the change of variable
				# where x is replaced by x - lb
   ub(m) -= lb(m) ;
   i = arcs(m,1) ;
   j = arcs(m,2) ;
   tsupply(i) -= lb(m) ;
   tsupply(j) += lb(m) ;
   
				# Insert the artificial nodes and
				# artificial arcs for the slack
				# variables.

   tadj(nnodes+m,j) = m ;
   tadj(nnodes+m,i) = narcs + m ;
   tsupply(nnodes+m) = ub(m) ;
   tsupply(i) -= ub(m) ;
 endfor
endfunction