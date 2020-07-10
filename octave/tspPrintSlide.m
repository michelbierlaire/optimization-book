function tspPrintSlide(coord,list,close,dist,topti,toptj,labels=0)
%
% Warning: the coordinates are inverted
  printf("\\begin{slide}{Voyageur de commerce : 2-OPT(%d,%d)}\n",topti,toptj) ;
  printf("\\begin{center}\n") ;
  printf("\\psset{xunit=0.3cm}\n") ;
  printf("\\psset{yunit=0.3cm}\n") ;
  printf("\\begin{pspicture}(40,40)\n") ;
  for i=1:size(coord)
    printf("\\cnodeput(%f,%f){n%d}{%d}\n",coord(i,2),coord(i,1),i,i)
  endfor
  for i=1:size(list)-1
    printf("\\ncline{->}{n%d}{n%d}\n",list(i),list(i+1)) ;
    if (labels)
      if (coord(list(i),2) <= coord(list(i+1),2))
	printf("\\naput[nrot=:U]{%.1f}\n",dist(list(i),list(i+1))) ;
      else
	printf("\\nbput[nrot=:D]{%.1f}\n",dist(list(i),list(i+1))) ;
      endif
    endif
  endfor
  if (close) 
    printf("\\ncline{->}{n%d}{n%d}\n",list(end),list(1))
    if (labels)
      if (coord(list(end),2) <= coord(list(1),2))
	printf("\\naput[nrot=:U]{%.1f}\n",dist(list(end),list(1))) ;
      else
	printf("\\nbput[nrot=:D]{%.1f}\n",dist(list(end),list(1))) ;
      endif
    endif
  endif
length = tspCalculateLength(list,dist) ;

printf("\\end{pspicture}\\\\ Longueur : %.1f\n",length) ;
printf("\\end{center}\n") ;
printf("\\end{slide}\n\n\n") ;
endfunction