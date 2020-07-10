# Number of plants
n = 10 ;
# NUmber of cities
m = 3 ;
# Fixed costs
p = [1 1 1 1 1 1 1 1 1 1] ;
# Production costs
pg = [1 1 1 2 2 1 1 1 2 2 ] ; 
pe = [2 2 2 1 1 2 1 2 2 2 ] ;
#Transport costs
cg = [ 5 4 3 2 1 5 4 3 2 1 ; 2 2 2 2 2 1 2 2 2 2 ; 1 2 3 4 5 1 2 3 4 5] ;
ce = [ 5 4 3 8 1 5 4 3 2 1 ; 2 2 2 10 12 1 2 2 2 2 ; 1 2 3 1 7 1 2 3 4 5] ;

#Demand 
gas = [1 0 1 ] ;
elec = [1 1 1 ] ;
dg = [50 0 30] ;
de = [30 20 10] ;



#big M
Mg = dg*gas'  ;
Me = de*elec'  ;
#Mg = 10000  ;
#Me = 10000  ;

# Number of variables 
T = 5*n +2*n*m ;
# Initial values 
initX = 0  ;
initYg = n  ;
initYe = 2*n  ;
initZijg = 3*n ;
initZije = 3*n + n*m  ;
initQig =  3*n + 2*n*m  ;
initQie =  4*n + 2*n*m  ;

#Number of constraints
S = 7*n + 4 * m * n + 2*m ;

cost = zeros(T,1) ;
for i = 1:n
  cost(initX + i) = p(i) ;
  cost(initQig + i) = pg(i) ;
  cost(initQie + i) = pe(i) ;
  for j= 1:m
    cost(initZijg + (i-1)*m + j) = cg(j,i)  ;
    cost(initZije + (i-1)*m + j) = ce(j,i)  ;
  endfor
endfor
#printf("Cost: %d = %d\n",size(cost,1),T) 
A = zeros(S,T);
#constraints = zeros(S,1) ;
b = zeros(S,1);

row = 1 ;

# n if plant i serves gas, then it is open 
for i=1:n
  A(row,initX+i) = 1 ; 
  A(row,initYg+i) = -1 ; 
  b(row) = 0 ;
  constraints(row) = "L" ;
  row += 1;
endfor

#printf("Row %d should be %d\n",row-1,n) ;
# n if plant i serves elec, then it is open 
for i=1:n
  A(row,initX+i) = 1 ; 
  A(row,initYe+i) = -1 ; 
  b(row) = 0 ;
  constraints(row) = "L" ;
  row += 1;
endfor

#printf("Row %d should be %d\n",row-1,2*n) ;

# n plant serves gas or electricity, noth both
for i=1:n
  A(row,initYg+i) = 1 ; 
  A(row,initYe+i) = 1 ; 
  b(row) = 1 ;
  constraints(row) = "U" ;
  row += 1;
endfor



#printf("Row %d should be %d\n",row-1,3*n) ;

# n*m Quantity produced satisfies demand for gas
for i=1:n
  A(row,initQig + i) = 1 ;
  for j=1:m
    A(row,initZijg + (i-1)*m + j) = -gas(j) * dg(j) ;
  endfor
  b(row) = 0 ;
  constraints(row) = "L" ;
  row += 1 ;
endfor

#printf("Row %d should be %d\n",row-1,4*n) ;

# n*m Quantity produced satisfies demand for electricity
for i=1:n
  A(row,initQie + i) = 1 ;
  for j=1:m
    A(row,initZije + (i-1)*m + j) = -elec(j) * de(j) ;
  endfor
  b(row) = 0 ;
  constraints(row) = "L" ;
  row += 1 ;
endfor

#printf("Row %d should be %d\n",row-1,5*n) ;

# n Production constraint for gas

for i=1:n
  A(row,initYg + i) = Mg ;
  A(row,initQig + i) = -1 ;
  b(row) = 0 ;
  constraints(row) = "L" ;
  row += 1 ;
endfor

#printf("Row %d should be %d\n",row-1,6*n) ;

# n Production constraint for electricity
for i=1:n
  A(row,initYe + i) = Me ;
  A(row,initQie + i) = -1 ;
  b(row) = 0 ;
  constraints(row) = "L" ;
  row += 1 ;
endfor

#printf("Row %d should be %d\n",row-1,7*n) ;

# m At least one plant serves each city in gas
for j=1:m
  for i=1:n
    A(row,initZijg + (i-1)*m+j) = 1  ;
  endfor
  b(row) = gas(j) ;
  constraints(row) = "L" ;
  row += 1 ;
endfor

#printf("C Row %d should be %d\n",row-1,7*n  +m) ;


# m At least one plant serves each city in electricity
for j=1:m
  for i=1:n
    A(row,initZije + (i-1)*m+j) = 1  ;
  endfor
  b(row) = elec(j) ;
  constraints(row) = "L" ;
  row += 1 ;
endfor

#printf("B Row %d should be %d\n",row-1,7*n + 2*m) ;

# A city can be served in gas by plant i if plant i makes gas
for i=1:n
  for j=1:m
    A(row,initYg + i) = 1  ;
    A(row,initZijg + (i-1)*m+j) = -1  ;
    b(row) = 0 ;
    constraints(row) = "L" ;
    row += 1 ;
  endfor
endfor

#printf("A Row %d should be %d\n",row-1,7*n + n*m + 2*m) ;

# A city can be served in electricity by plant i if plant i makes electricity
for i=1:n
  for j=1:m
    A(row,initYe + i) = 1  ;
    A(row,initZije + (i-1)*m+j) = -1  ;
    b(row) = 0 ;
    constraints(row) = "L" ;
    row += 1 ;
    endfor
endfor

# A city j can be served in gas by plant i if city j is a client for gas
for i=1:n
  for j=1:m
    A(row,initZijg + (i-1)*m+j) = 1  ;
    b(row) = gas(j) ;
    constraints(row) = "U" ;
    row += 1 ;
    endfor
endfor

# A city j can be served in electricity by plant i if city j is a client for gas
for i=1:n
  for j=1:m
    A(row,initZije + (i-1)*m+j) = 1  ;
    b(row) = elec(j) ;
    constraints(row) = "U" ;
    row += 1 ;
    endfor
endfor


#printf("Row %d should be %d\n",row-1,7*n + 2*n*m + 2*m) ;


if (S != row-1)
  error("Number of constraints incorrect: %d - %d\n", S, row-1)
endif


lb = [] ;
for i = 1:T
  lb = [lb 0] ;
endfor

vartype = [] ;
ub = [] ;
for i = 1: initQig
  vartype = [vartype "I"] ;
  ub = [ub 1 ] ;
endfor
for i= 1: n
  vartype = [vartype "C"] ;
  ub = [ub Mg ] ;
endfor
for i= 1: n
  vartype = [vartype "C"] ;
  ub = [ub Me ] ;
endfor

param.save=1 ;

[xopt, fmin, errnum, extra] = glpk(cost, A, b, lb, ub, constraints, vartype, 1,param);

printf("Total cost: %f\n",fmin) ;

#xopt(9) = 0 ;
#xopt(initYe + 9)=0 ;
#cost'* xopt
#printf("cost(9)=%f\n",cost(9)) ;

printf("Plants to build: ") ;
printf("%d ", xopt(1:n)) ;
printf("\n") ;
printf("Plants for gas: ") ;
printf("%d ", xopt(initYg+1:initYg+n)) ;
printf("\n") ;
printf("Plants for electricity: ") ;
printf("%d ", xopt(initYe+1:initYe+n)) ;
printf("\n") ;


for j=1:m
  printf("Gas plants for city %d: ",j) ;
  for i=1:n
    if (xopt(initZijg + (i-1)*m+j) != 0)
      printf("%d ", i) ;
    endif
  endfor
  printf("\n") ;
endfor

for j=1:m
  printf("Electricity plants for city %d: ",j) ;
  for i=1:n
    if (xopt(initZije + (i-1)*m+j) != 0)
      printf("%d ", i) ;
    endif
  endfor
  printf("\n") ;
endfor

printf("Quantity of gas per plant: ") ;
printf("%f ",xopt(initQig+1:initQig+n)) ; 
 printf("\n") ;

printf("Quantity of electricity per plant: ") ;
printf("%f ",xopt(initQie+1:initQie+n)) ; 
 printf("\n") ;


#exit()


printf("if plant i serves gas, then it is open \n") ;
for i=1:n
  if (xopt(initX+i)-xopt(initYg+i) < 0)
    printf("Plant %d: %f - %f = %f >= 0\n",i,xopt(initX+i),xopt(initYg+i),xopt(initX+i)-xopt(initYg+i)) 
  endif
endfor

printf("if plant i serves elec, then it is open \n") ;
for i=1:n
  if (xopt(initX+i)-xopt(initYe+i) < 0) 
    printf("Plant %d: %f - %f = %f >= 0\n",i,xopt(initX+i),xopt(initYe+i),xopt(initX+i)-xopt(initYe+i)) 
  endif
endfor

printf("plant serves gas or electricity, noth both\n") ;
for i=1:n
  if (xopt(initYg+i)+xopt(initYe+i) > 1)
    printf("Plant %d: %f + %f = %f <= 1\n",i,xopt(initYg+i),xopt(initYe+i),xopt(initYg+i)+xopt(initYe+i))
    endif
endfor

printf("Quantity produced satisfies demand for gas\n") ;
for i=1:n
  total = 0 ;
  for j=1:m
    total += dg(j) * gas(j) * xopt(initZijg + (i-1)*m + j) ;
  endfor
  if (xopt(initQig+i)-total < 0)
    printf("Plant %d: ",i) ;
    printf(" %f - %f = %f  >= 0\n",xopt(initQig+i),total,xopt(initQig+i)-total)
  endif
endfor

printf("Quantity produced satisfies demand for electricity\n") ;
for i=1:n
  total = 0 ;
  for j=1:m
    total += de(j) * elec(j) * xopt(initZije + (i-1)*m + j) ;
  endfor
  if (xopt(initQie+i)-total < 0)
    printf("Plant %d: ",i) ;
    printf(" %f - %f = %f  >= 0\n",xopt(initQie+i),total,xopt(initQie+i)-total)
  endif
endfor


printf(" Production constraint for gas\n") ;

for i=1:n
  if (xopt(initYg+i)*Mg-xopt(initQig +i) < 0)
    printf("Plant %d: %f %f - %f = %f >= 0\n",i,xopt(initYg+i),Mg,xopt(initQig +i),xopt(initYg+i)*Mg-xopt(initQig +i))
  endif
endfor

printf(" Production constraint for electricity\n") ;

for i=1:n
  if (xopt(initYe+i)*Me-xopt(initQie +i) < 0)
    printf("Plant %d: %f %f - %f = %f >= 0\n",i,xopt(initYe+i),Mg,xopt(initQie +i),xopt(initYe+i)*Me-xopt(initQie +i))
  endif
endfor


printf(" At least one plant serves each city in gas\n");
for j=1:m
  total  = 0 ;
  for i=1:n
    total += xopt(initZijg+(i-1)*m+j) ;
  endfor
  if (total < gas(j))
    printf("City %d: ",j) ;
    printf("  %f >= %d\n",total,gas(j)) ;
  endif
endfor


printf(" At least one plant serves each city in electricity\n");
for j=1:m
  total  = 0 ;
  for i=1:n
    total += xopt(initZije+(i-1)*m+j) ;
  endfor
  if (total < elec(j))
    printf("City %d: ",j) ;
    printf(" = %f >= %d\n",total,elec(j)) ;
  endif
endfor


printf(" A city can be served in gas by plant i if plant i makes gas\n") ;
for i=1:n
  for j=1:m
    if (xopt(initYg+i)-xopt(initZijg + (i-1)*m + j) < 0)
      printf("Plant %d City %d: %f - %f = %f >= 0\n",i,j,xopt(initYg+i),xopt(initZijg + (i-1)*m + j),xopt(initYg+i)-xopt(initZijg + (i-1)*m + j)) ;
    endif
  endfor
endfor

printf(" A city can be served in gas by plant i if plant i makes electricity\n") ;
for i=1:n
  for j=1:m
    if (xopt(initYe+i)-xopt(initZije + (i-1)*m + j) < 0)
      printf("Plant %d City %d: %f - %f = %f >= 0\n",i,j,xopt(initYe+i),xopt(initZije + (i-1)*m + j),xopt(initYe+i)-xopt(initZije + (i-1)*m + j)) ;
    endif
  endfor
endfor

printf(" A city is served if it buys gas \n") ;
for i=1:n
  for j=1:m
    if (xopt(initZijg + (i-1)*m + j) > gas(j))
      printf("Plant %d City %d: %f <= %d\n",i,j,xopt(initZijg + (i-1)*m + j),gas(j)) ;
    endif
  endfor
endfor

printf(" A city is served if it buys electricity \n") ;
for i=1:n
  for j=1:m
    if (xopt(initZije + (i-1)*m + j) > elec(j))
      printf("Plant %d City %d: %f <= %d\n",i,j,xopt(initZije + (i-1)*m + j),elec(j)) ;
    endif
  endfor
endfor





