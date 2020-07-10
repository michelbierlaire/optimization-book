%> \file
%> Runs example 16.03 illustrating the failure of Nelder-Mead algorithm on McKinnon's example (Table 16.2)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Mon May 12 11:32:47 2014

x0 = [1 (1.0+sqrt(33))/8.0 0 ; 1 (1.0-sqrt(33))/8.0  0] ;
solution = a1601nelderMead('ex1603mcKinnon',x0,1.0e-5,100)
