%> \file
%> 
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Tue Mar 17 08:53:59 2015

tab = [3 2 1 0 0 0 0 0 0 76 ; 
           4 -5 0 1 0 0 0 0 0 40 ;
           7 5 0 0 -1 0 0 0 1 70 ; 
           -1 2 0 0 0 1 0 0 0 28 ; 
           1 0 0 0 0 0  1 0 0 20 ; 
           0 1 0 0 0 0  0 1 0 20 ;
          -7 -5 0 0 1 0 0 0 0 -70 ];

rowindex= [3 4 9 6 7 8] ;

[opttableau,bounded,rowindex] = a1704tableau(tab,rowindex)

m=6 ;
n=8 ;

newtableau = opttableau ;
newtableau(:,9) = []

c = [0 1 0 0 0 0 0 0] 
cb = c(rowindex)
for i=1:6
newtableau(7,rowindex(i)) = c(rowindex(i)) - cb*newtableau(1:m,rowindex(i))
endfor
