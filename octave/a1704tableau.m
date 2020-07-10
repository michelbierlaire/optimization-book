%> \file
%>  Phase II simplex algorithm with tableau. Implementation of algorithm 17.4 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Wed Jul 23 10:14:44 2014
%> @ingroup Algorithms

%> Solve a linear optimization problem in standard form using the tableau simplex 
%> @param tab the first simplex tableau
%> @rowindex: for each row, index of the corresponding basic variables
%> @return opttableau the optimal tableau

function [opttableau,bounded,rowindex] = a1704tableau(tab,rowindex)
  

  [mtab,ntab] = size(tab) ;
  m=mtab-1 ;
  n=ntab-1 ;
  while (true)
    printf("=============\n") ;
    printTableau(tab) 
    printf("=============\n") ;
    colpivot = -1 ;
    i = 1 ;
    cfirstneg = eps ;
    while (i <= n ) 
      if tab(m+1,i) < -eps 
        cfirstneg =  tab(m+1,i) ;
        colpivot = i ;
        i = n + 1 ;
      endif 
      i = i + 1 ;
    end
    if (cfirstneg >= -eps) 
      opttableau = tab ;
      bounded = 1 ;
      return ;
    endif
    bestlambda = 1000000 ;
    rowpivot = -1 ;
    for i=1:m
      if (tab(i,colpivot) > 0)
        lambda = tab(i,n+1) / tab(i,colpivot) ;
        if (lambda < bestlambda)   
	  bestlambda = lambda ; 
	  rowpivot = i ;
	endif
      endif
    endfor
    if (rowpivot == -1)
      printf("**** Unbounded problem ****\n") ;
      bounded = 0 ;
      return
    endif
    tab = a1703pivot(tab,rowpivot,colpivot) 
    rowindex(rowpivot) = colpivot ;
  endwhile

endfunction