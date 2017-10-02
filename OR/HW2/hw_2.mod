set P;
set M;

param s;	# storage cost
param t;	# 6 months
param pr{i in P};	# profit parameter
param ul{i in P, j in 1..t};	# fix in month

var X[i in P, j in 1..t];	# product sell
var B[i in P, j in 1..t];	# product buy
var L[i in P, j in 1..t];	# product left

	
maximize Profit:
	sum{i in P}(sum{j in 1..t}(B[i, j]) * pr[i] )
		- sum{i in P}(sum{j in 1..t}(L[i,j]) * 0.5 );
		
subject to period_limit{i in P, j in 1..t}:
	L[i, j-1] - X[i, j] + B[i, j]= L[i, j];
	
subject to last_pl{i in P}:
	L[i, 5] - X[i, 6] + B[i, 6] = 500;
	
subject to store_limit{i in P, j in 1..t}:
	L[i, j] <= 100;
	
subject to nonzero_B{i in P, j in 1..t}:
	B[i, j] >= 0;

subject to nonzero_L{i in P, j in 1..t}:
	L[i, j] >= 0;
		