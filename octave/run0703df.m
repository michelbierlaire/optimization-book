%> \file
%> Runs example 7.3 with Newton's method with finite differences, one variable (Tables 8.1 and 8.2)
%> 
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Sat Apr  5 20:25:00 2014

tau = 1.0e-7
root = a0801newtondf1('ex0703',2.0,1.0e-15,tau)

tau = 0.1
root = a0801newtondf1('ex0703',2.0,1.0e-15,tau)


