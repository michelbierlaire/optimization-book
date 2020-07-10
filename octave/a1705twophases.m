%> \file
%>  Two phases simplex algorithm with tableau to solve a linear optimization problem in standard from. Implementation of algorithm 17.5 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Wed Jul 23 10:28:49 2014
%> @ingroup Algorithms

%> Solve a linear optimization problem in standard form using the tableau simplex with two phases 
%> \f[ \min_{x \in \mathbb{R}^n} c^T x
%> \f]
%> subject to 
%> \f[ Ax = b \f]
%> and
%> \f[ x \geq 0 \f]
%> where \f$A\in\mathbb{R}^{m\times n}\f$, \f$ b\in\mathbb{R}^m\f$ and
%> \f$c\in \mathbb{R}^n\f$. 
%> @param A the constraint matrix
%> @param b the constraint right hand side
%> @param c the cost vector for the objective function
%> @return [x,copt,finaltableau] x the optimal solution, copt the value of the objective function, finaltableau the optimal tableau
function [x,copt,finaltableau,feasible,bounded] = a1705twophases(A,b,c) 

  [m,n] = size(A) ;

  if (m != size(b))
    error("The number of rows in A and b do not match") ;
  endif
  if (n != size(c))
    error("The number of columns in A and do not match the size of c") ;
  endif

% Make sure that b >= 0 
  for i=1:m
    if (b(i) < 0)
      b(i) *= -1 ;
      A(i,:) *= -1 ;
    endif
  endfor

% First tableau for Phase I
  tab = [ A eye(m,m) b ; zeros(1,n+m+1) ];
  for i = 1:n
    tab(m+1,i) = -sum(tab(1:m,i));
  end
  tab(m+1,n+m+1) = -sum(tab(1:m,n+m+1)) ;

  printf("=====First tableau for phase I ========\n") ;
  printTableau(tab) 
  printf("=============\n") ;

  
% The basic variables are variables n+1 to n+m
 rowindex = [n+(1:m)] ;
% Solve the phase I problem
  [opttableau,bounded,rowindex] = a1704tableau(tab,rowindex) ;
  printf("=====Solution of  phase I ========\n") ;
  printTableau(opttableau) 
  printf("=============\n") ;

  if (bounded == 0) 
    feasible = 1 ;
    x=[] ;  
    copt = 0 ;
    finaltableau = []
    bounded = 0 ;
    return ;
  endif
  if (opttableau(m+1,n+m+1) > sqrt(eps))
    printf("Optimal cost is %e > %e. No feasible solution exists.\n",opttableau(m+1,n+m+1),sqrt(eps)) ;
    feasible = 0 ;
    x=[] ;  
    copt = 0 ;
    finaltableau = []
    bounded = 1 ;
    return ;
  endif
  feasible = 1 ;
  ok = 0 ;
  
  rowstoberemoved = [] ;
% Remove the auxiliary variables from the basis
  for i=n+1:n+m
    basic = any(rowindex == i) ;
    if (basic != 0) 
%      printf("Auxiliary variable %d is in the basis\n",i-n) ;
      rowpivot = find(opttableau(:,i)') ;
				% Search the pivot
      colpivot = -1 ;
      k=1 ;
      while (colpivot < 0 && k <= n)
	if (abs(opttableau(rowpivot,k)) > eps) 
	  colpivot = k ;
	else
	  k = k + 1 ;
	endif
      end
      if (colpivot < 0) 
	printf("Redundant constraint identified %d\n",rowpivot) ;
        rowstoberemoved(end + 1) = rowpivot ;
      else
	opttableau = a1703pivot(opttableau,rowpivot,colpivot)  ;
	printf("=====Pivoting after  phase I ========\n") ;
	printTableau(opttableau) 
	printf("=============\n") ;
	rowindex(rowpivot) = colpivot ;
      endif
    endif
  end
% Remove the redundant constraints
  printf("* Remove %d rows: ",size(rowstoberemoved,2)) ;
%  printf("%d ",rowstoberemoved)
%  printf("\n") ;
%  printf("Size of tableau: %dx%d\n",size(opttableau)) ;
%  printf("Rowindex: ")
%  printf("%d ",rowindex)
%  printf("\n") ;
  for r = size(rowstoberemoved,2):-1:1
    printf("Remove row %d\n",rowstoberemoved(r))
    opttableau(rowstoberemoved(r),:) = [] ;
    rowindex(rowstoberemoved(r)) = [] ;
%    printf("Size of tableau: %dx%d\n",size(opttableau)) ;
%    printf("Rowindex: ")
%    printf("%d ",rowindex)
%    printf("\n") ;
  endfor 
% Remove the columns 
  finaltableau = opttableau ;
  finaltableau(:,n+1:n+m) = [] ;
  printf("=====Cleaned tableau after  phase I ========\n") ;
  printTableau(finaltableau) 
  printf("=============\n") ;

  [m,n] = size(finaltableau) ;
  m = m-1  ;
  n = n-1  ;

  cb = zeros(m,1) ;
  for i=1:m
    cb(i) = c(rowindex(i)) ;
%    printf("Basic variable %d in row %d\n",rowindex(i),i)
  end

  for i=1:n
    if (any(rowindex==i))
      finaltableau(m+1,i) = 0 ;
    else
      finaltableau(m+1,i) = c(i) - cb' * finaltableau(1:m,i) ;
    endif
  end
   finaltableau(m+1,n+1) = - cb' * finaltableau(1:m,n+1) ;
  x = zeros(n,1) ;

  finaltableau
% Phase II
  printf(" START PHASE II\n") ;

  [finaltableau,bounded,rowindex] = a1704tableau(finaltableau,rowindex) ;
  printf("=====Final tableau after  phase II ========\n") ;
  printTableau(finaltableau) 
  printf("=============\n") ;
  x = zeros(n,1) ;
  for j=1:m
%    printf("Set x(%d) to %f\n",rowindex(j),finaltableau(j,n+1) )
    x(rowindex(j)) = finaltableau(j,n+1) ;
  endfor
  copt = -finaltableau(m+1,n+1) ;
endfunction

