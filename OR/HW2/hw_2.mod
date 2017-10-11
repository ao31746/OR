set P;
set M;

param s;	# storage cost
param t;	# 6 months
param pr{i in P};	# profit parameter
param ul{j in 1..t, k in M};	# fixing tool month
param sp{i in P, k in M};		# production parameter
param ml{i in P, j in 1..t};	# maketing limit
param tool{k in M};


var X{i in P, j in 1..t};	# product sell
var B{i in P, j in 1..t};	# product make
var L{i in P, j in 1..t};	# product left
var MK{i in P, j in 1..t};	# product can be make
	
maximize Profit:
	sum{i in P}(sum{j in 1..t}(X[i, j]) * pr[i] )
		- sum{i in P}(sum{j in 1..t}(L[i,j] * s ));

subject to production_limit{j in 1..t}:
	sum{i in P}(B[i, j] * MK[i, j]) <= sum{i in P}(sum{k in M}((tool[k]-ul[j, k]) ) * sp[i, k] * 8 * 2 * 6 * 4);


#設定哪些PROD不能被做
subject to production_formula{i in P, j in 1..t, k in M}:
	MK[i, j] = if (tool[k]-ul[j, k] = 0 and sp[i, k] > 0) then 0 else 1;
	
subject to marketing_limit{i in P, j in 1..t}:
	X[i, j] <= ml[i, j];
		
subject to period_limit{i in P, j in 2..t}:
	L[i, j-1] - X[i, j] + B[i, j] * MK[i, j]= L[i, j];

subject to first_pl{i in P}:
	- X[i, 1] + B[i, 1] * MK[i, 1] = L[i, 1];
	
subject to last_pl{i in P}:
	L[i, 6] = 50;
	
subject to store_limit{i in P, j in 1..t}:
	L[i, j] <= 100;

subject to nonzero_X{i in P, j in 1..t}:
	X[i, j] >= 0;

subject to nonzero_B{i in P, j in 1..t}:
	B[i, j] >= 0;

subject to nonzero_L{i in P, j in 1..t}:
	L[i, j] >= 0;
		