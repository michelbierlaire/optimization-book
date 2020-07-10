%> \file
%>  Kalman filter update. Implementation of algorithms 15.2 and 15.3 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Fri May  9 16:06:12 2014
%> @ingroup Algorithms
%> Applies one update of the Kalman filter algorithm. 
%> @param x the current estimate of the parameters
%> @param H the current filter matrix
%> @param A the data matrix for the next block
%> @param b the RHS for the next block
%> @param lambda the discount factor
%> @return [x,H] x: the updated value of the parameters. H: the updated value of the filter matrix. 
function [x,H] = a1502kalman(x,H,A,b,lambda=1.0)
  H = lambda * H + A'*A ;
  d = H \ (A' * (b - A*x)) ;
  x = x + d ; 
endfunction
