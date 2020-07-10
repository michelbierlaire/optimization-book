%> \file
%> Runs example 16.03, the McKinnon example with Torczon's algorithm (Table 16.3)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Mon May 12 13:42:51 2014
x0 = [1 (1.0+sqrt(33))/8.0 0 ; 1 (1.0-sqrt(33))/8.0  0] ;
solution = a1602torczon('ex1603mcKinnon',x0,1.0e-5,100)
