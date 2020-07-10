%> \file
%> Line search algorithm.  Implementation of algorithm 11.2 of \cite Bier06-book
%> 
%> @author Michel Bierlaire
%> @date Tue Apr  8 22:34:52 2014
%> @ingroup Algorithms



%> Applies the line search algorithm to find a step along a direction that verifies the Wolfe conditions. 
%> @param obj objective function \f$f:\mathbb{R}^n \to \mathbb{R} \f$.
%> @param x current iterate
%> @param d direction for the line search
%> @param alpha0 initial step 
%> @param beta1  parameter for the first Wolfe condition (strictly between 0 and 1)
%> @param beta2  parameter for the second Wolfe condition (strictly between beta1 and 1)
%> @param lambda expansion factor for short steps
%> @return step alpha verifying the two Wolfe conditions
function alpha = a1102linesearch(obj,x,d,alpha0,beta1,beta2,lambda)
  if (lambda <= 1) 
    error("lambda must be > 1 and is %f",lambda)
  endif
  if (alpha0 <= 0) 
    error("alpha0 must be > 0 and is %f",alpha0)
  endif
  if (beta1 >= beta2)
    error("Incompatible Wolfe cond. beta1 = %f beta2 = %f",beta1,beta2)
  endif
  [f,g] = feval(obj,x) ;
  deriv = g' * d ;
  if (deriv >= 0)
    error("d is not a descent direction: %.4e\n",g'*d) ;
  endif
  i = 0 ;
  alpha = alpha0 ;
  alphal = 0 ;
  alphar = 999999 ;
  ok = 0 ;
  do
    xnew = x+alpha * d ;
    [fnew,gnew] = feval(obj,xnew) ;
    if (fnew > f + alpha * beta1 * deriv) 
				# Step is too long
      alphar = alpha ;
      alpha = (alphal + alphar) / 2.0 ;
    else
      if (gnew'*d < beta2 * deriv)
				# Insufficient decrease
	alphal = alpha ;
	if (alphar == 999999) 
	  alpha = lambda * alpha ;
	else
	  alpha = (alphal + alphar) / 2.0 ;
	endif
      else
	ok = 1 ;
      endif
    endif
  until (ok == 1)
endfunction 
