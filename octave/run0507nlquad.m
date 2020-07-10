%> \file
%> Runs example 5.11 with Newton's local with the quadratic model
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Sun Apr  6 11:41:25 2014
%> @note The second run fails with the following error message: "chol: input matrix must be positive definite". Indeed, the hessian matrix is not positive definite at the starting point, and  the quadratic problem is not bounded. 

x0 = [-2 ; 1] ;
root = a1002newtonquad('ex0507gradient',x0,1.0e-15)

x0 = [1 ; 1] ;
root = a1002newtonquad('ex0507gradient',x0,1.0e-15)


