%> \file
%> Runs example 9.8 with the direct method.
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Sun Apr  6 11:27:07 2014

Q = [1 1 1 1 ; 1 2 2 2 ; 1 2 3 3 ; 1 2 3 4] ;
b = [-4 ; -7 ; -9 ; -10 ] ;

solution = a0901quad(Q,b) 

% With Octave, this can be solved directly using the following statement

solution = Q \ -b

