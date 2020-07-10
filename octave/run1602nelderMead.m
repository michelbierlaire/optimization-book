%> \file
%> Runs example 16.02 illustrating the Nelder-Nead algorithm (Table 16.1)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Mon May 12 11:22:19 2014
x0 = [1 2  1.1 ; 1 1.1 2] ; 
solution = a1601nelderMead('ex1101',x0,1.0e-5,100)

#x0 = [1 (1.0+sqrt(33))/8.0 0 ; 1 (1.0-sqrt(33))/8.0  0] ;
#neldermead('mkkinnon',x0,1.0e-5,100)
