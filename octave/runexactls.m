delta = 6 ;
eps = 1.0e-3 ;
xstar = aquadraticinterpolation('exlinesearch',delta,eps) 

xstar = agoldensection('exlinesearch',5,10,eps)

