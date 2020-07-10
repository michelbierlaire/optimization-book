%> \file
%> Modified Cholesky factorization.  Implementation of algorithm 11.4 of \cite Bier06-book. This implementation is far from efficient, and is designed for illustrative purposes only. Implementations suggested by \cite fang2008modified and \cite SchnEsko99, for instance, should be preferred. 
%> 
%> @author Michel Bierlaire
%> @date Wed Apr  9 14:15:41 2014
%> @ingroup Algorithms



%> Given a symmetric matrix \f$ A\in \mathbb{R}\times \mathbb{R}\f$, provide a lower triangular matrix \f$L\f$ and a real \f$\tau\f$ such that \f[ A + \tau I = L L^T.\f]
%> @param A symmetric matrix \f$n \times n \f$.
%> @return [L, tau] L: lower triangular matrix \f$L\f$, tau: real \f$\tau\f$ such that \f$ A + \tau I = L L^T.\f$
function [L, tau] = a1104modchol(A) 
  tau = 0.0 ;
  [m,n] = size(A) ; 
  if (m != n)
    error("Matrix must be square. Size %dx%d",m,n) ;
  endif
  nf = norm(A,"fro") ;  
  if (nf <= 1.0e-6)
    nf = 1.0e-6 ;
  endif

  mindiag = min(diag(A)) ;

  if (mindiag > 0)
    tau = 0 ;
    R = A ;
  else
    tau = nf ;
    R = A + tau * eye(n,n) ;
  endif

  mineig = min(eig(R)) ;

  printf("Tau = %f  Eig= %f",tau,mineig)
  while (mineig <= 0)
    tau = max([2 * tau, 0.5 * nf])  ;
    R = A + tau * eye(n,n)  ;
    mineig = min(eig(R)) ;
    printf("Tau = %f  Eig= %f",tau,mineig)
  endwhile
  L = chol(R,"lower")  ;
  return

endfunction
