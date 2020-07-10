%> \file
%> Generate a random subtour
%> 
%> @author Michel Bierlaire
%> @date Wed Oct 22 17:08:41 2014
%> @ingroup Algorithms
%> 
%> @param n total number of cities
%> @param p number of cities in the subtour (in addition to home)
%> @return tour stored as a success list

function tour = aRandomSubtour(n,p)
  order = randperm(n-1) ;
  tour = zeros(n,1) ;
  tour(1) = 1+order(1) ;
  for (i=1:p-1)
    tour(1+order(i)) = 1+order(i+1) ;
  endfor
endfunction