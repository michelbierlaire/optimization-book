function [like,g,H] = likelihood(beta)
  Xi1 = zeros(9,1) ;
  Xi1(1) = 1 ;
  Xi1(2) = 5 ;
  Xi1(4) = 1.17 ;
  Xi1(7) = 1 ;
  Xj1 = zeros(9,1) ;
  Xj1(2) = 40 ;
  Xj1(5) = 2.5 ;
  Xi2 = zeros(9,1) ;
  Xi2(1) = 1 ;
  Xi2(2) = 8.33 ;
  Xi2(3) = 2 ;
  Xi2(8) = 1 ;
  Xi2(9) = 1 ;
  Xj2 = zeros(9,1) ;
  Xj2(2) = 7.8 ;
  Xj2(5) = 1.75 ;
  Xj2(6) = 1 ;
  Xi3 = zeros(9,1) ;
  Xi3(1) = 1 ;
  Xi3(2) = 3.2 ;
  Xi3(4) = 2.55 ;
  Xi3(8) = 1 ;
  Xj3 = zeros(9,1) ;
  Xj3(2) = 40 ;
  Xj3(5) = 2.67 ;
  
  dX1 = Xi1 - Xj1 ; 
  dX2 = Xi2 - Xj2 ; 
  dX3 = Xi3 - Xj3 ; 
  
  Vi1 = beta' * Xi1
  Vj1 =  beta' * Xj1
  Vi2 =  beta' * Xi2
  Vj2 =  beta' * Xj2
  Vi3 =  beta' * Xi3
  Vj3 =  beta' * Xj3
  
  Pi1 = 1.0 / (1 + exp(Vj1 - Vi1));
  Pj2 = 1.0 / (1 + exp(Vi2 - Vj2));
  Pi2 = 1.0 - Pj2;
  Pj3 = 1.0 / (1 + exp(Vi3 - Vj3));
  Pi3 = 1.0 - Pj3;
  
  like = log(Pi1) + log(Pj2) + log(Pj3);

  g = zeros(9,1) ;
  for i = 1:9
    g(i) = (1.0-Pi1) * dX1(i) -Pi2 * dX2(i) - Pi3 * dX3(i) ;
  endfor

  H = zeros(9,9) ;
  for i = 1:9
    for j = 1:9
      H(i,j) = - Pi1 * (1-Pi1) * dX1(i) * dX1(j) - Pi2 * (1-Pi2) * dX2(i) * dX2(j) - Pi3 * (1-Pi3) * dX3(i) * dX3(j) ;
    endfor
  endfor
  
endfunction