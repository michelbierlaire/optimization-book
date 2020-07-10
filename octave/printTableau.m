function printTableau(tableau)

[m n] = size(tableau) ;
m = m - 1 ; 
n = n - 1 ;

printf("\\begin{center}\n") ;
printf("\\begin{tabular}{|*{%d}{c}|c}\n",n) ;
for i=1:n
  printf("\\multicolumn{1}{c}{\\makebox[1.5em]{$x_{%d}$}} &\n",i) ;
endfor
printf("\\multicolumn{1}{c}{\\makebox[1.5em]{\\rule[-3mm]{0mm}{2mm}}} \\\\\n") ;
printf("\\cline{1-%d}\n",n+1) ;
for i=1:m
  for j=1:n+1
    if (j != 1)
      printf(" & ") ;
    endif
    printf(" %f ",tableau(i,j))
  endfor
  printf("\\\\\n") ;
endfor
printf("\\cline{1-%d}\n",n+1) ;
for j=1:n+1
  if (j != 1)
    printf(" & ") ;
  endif
  printf(" %f ",tableau(m+1,j))
endfor
printf("\\\\\n") ;
printf("\\cline{1-%d}\n",n+1) ;
printf("\\end{tabular}\n") ;
printf("\\end{center}\n") ;

endfunction