function tspPrintSubtour(coord,next,length,dist,labels=0)
%
% Warning: the coordinates are inverted
  printf("\\begin{center}\n") ;
  printf("\\psset{xunit=0.3cm}\n") ;
  printf("\\psset{yunit=0.3cm}\n") ;
  printf("\\begin{pspicture}(40,40)\n") ;
  for i=1:size(coord)
    printf("\\cnodeput(%f,%f){n%d}{%d}\n",coord(i,2),coord(i,1),i,i)
  endfor
  currentnode = 1 ;
  while (currentnode != 0) 
    na = currentnode ;
    if (next(currentnode) == 0)
      nb = 1 ;
    else
      nb = next(currentnode) ;
    endif
    printf("\\ncline[linestyle=dotted]{->}{n%d}{n%d}\n",na,nb) ;
    if (labels)
      if (coord(na,2) <= coord(nb,2))
	printf("\\naput[nrot=:U]{%.1f}\n",dist(na,nb)) ;
      else
	printf("\\nbput[nrot=:D]{%.1f}\n",dist(na,nb)) ;
      endif
    endif
    currentnode = next(currentnode) ;
  endwhile
printf("\\end{pspicture}\n") ;
printf("\\end{center}\n") ;
printf("\\end{slide}\n\n\n") ;
printf("Length: %f\n",length) ;
endfunction