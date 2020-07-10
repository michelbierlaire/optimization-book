%> \file
%>  Pivoting of the simplex tableau. Implementation of algorithm 17.3 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Wed Jul 23 09:57:11 2014
%> @ingroup Algorithms

%> Pivot the tableau
%> @param tab the simplex tableau
%> @param l the row of the pivot
%> @param j the column of the pivot
%> @return newtab the pivoted tableau
function newtab = a1703pivot(tab,l,j) 
  [mtab,ntab] = size(tab)  ;
  if (l > mtab)
    error("The row of the pivot exceeds the size of the tableau") ;
  endif
  if (j > ntab)
    error("The column of the pivot exceeds the size of the tableau") ;
  endif
  thepivot = tab(l,j) ;
  if (abs(thepivot) < realmin)
    error("The pivot is too close to zero") ;
  endif

  thepivotrow = tab(l,:) ;
  newtab = tab ;
  for i=1:mtab
    if (i == l) 
      newtab(l,:) = newtab(l,:) / thepivot ;
    else
      mult = -newtab(i,j) / thepivot ;
      newtab(i,:) = newtab(i,:) + mult * thepivotrow ;
    endif
  endfor
endfunction
