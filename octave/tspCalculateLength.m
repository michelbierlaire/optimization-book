function length = tspCalculateLength(cities,dist)
  length = 0 ;
  for i=1:size(cities)-1
    length += dist(cities(i),cities(i+1));
  endfor
  length += dist(cities(end),cities(1)) ;
endfunction