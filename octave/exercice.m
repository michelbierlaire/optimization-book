function [f,g,H] = exercice(x)
     f = 3.0 * x(1) * x(1) + 3 * x(2) * x(2);
     g = [ 6 * x(1) ; 6 * x(2) ] ;
     H = [6 0 ; 0 6] ;
endfunction
