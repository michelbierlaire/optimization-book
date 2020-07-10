%> \file
%> Generate a valid inequality of an integer optimization problem using a Gomory cut. 
%> 
%> @author Michel Bierlaire
%> @date Wed Sep 24 11:09:37 2014
%> @Ingroup Algorithms

%> Generate a valid inequality of an integer optimization problem using a Gomory cut: 
%> \f[ \min_{x \in \mathbb{R}^n} c^T x
%> \f]
%> subject to 
%> \f[ Ax = b \f]
%> and
%> \f[ x \in \mathbb{R}^n \f]
%> where \f$A\in\mathbb{R}^{m\times n}\f$, \f$ b\in\mathbb{R}^m\f$ and
%> \f$c\in \mathbb{R}^n\f$. 
%> @param A the constraint matrix
%> @param b the constraint right hand side
%> @param c the cost vector for the objective function
%> @param i index of the row used to generate the cut. If 0, the first row corresponding to a non integer variable is used. 


%> @return [alpha,gamma]: the inequality $\alpha^T x \leq \gamma$ is valid

function xopt = agomory(A,b,c)

  [m,n] = size(A) ;

   if (m != size(b))
    error("The number of rows in A and b do not match") ;
  endif
  if (n != size(c))
    error("The number of columns in A and do not match the size of c") ;
  endif

  iter = 0;
  while (1)
    iter = iter + 1
    % m and n are the dimension of the original problem
    % mm and nn are the dimension of the current problem including the cuts
    [mm,nn] = size(A) 
    [x,copt,finaltableau,feasible,bounded] = a1705twophases(A,b,c) ;
    if (bounded == 0) 
      error("Unbounded problem detected\n") ;
    endif
    % If some constraints have been detected to be redundant, the size may have changed
    [tm,tn] = size(finaltableau) ;
    tm -= 1 
    tn -= 1 
    lastcol = finaltableau(1:tm,tn+1) ;
    fractional = find(min(ceil(lastcol)-lastcol,lastcol-floor(lastcol))  > sqrt(eps)) ;
    if (isempty(fractional))
      xopt = x(1:n) ;
      return ;
    endif
    i = fractional(1) ;
    gamma = floor(finaltableau(i,1:tn)) ;
    bplus = floor(finaltableau(i,tn+1)) ;

    A = [ A zeros(mm,1) ; gamma  1] ;
    b = [ b ; bplus] ;
    c = [ c ; 0] ;
endwhile
  
  
endfunction