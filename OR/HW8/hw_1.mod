set P;
set M;

param s;	# storage cost
param t;	# 6 months
param pr{i in P};	# profit parameter
param sp{i in P, k in M};		# production parameter
param ml{i in P, j in 1..t};	# maketing limit
param tool{k in M};
param abd{k in M};

var X{i in P, j in 1..t}>=0;	# product sell
var B{i in P, j in 1..t}>=0;	# product make
var L{i in P, j in 1..t}>=0;	# product left
var MK{i in P, j in 1..t};	# product can be make
var FIXTOOL{j in 1..t, k in M}binary;# fixing tool month
	
maximize Profit:
	sum{i in P}(sum{j in 1..t}(X[i, j]) * pr[i] )
		- sum{i in P}(sum{j in 1..t}(L[i,j] * s ));

subject to production_limit{j in 1..t}:
	sum{i in P}(B[i, j] * MK[i, j]) <= sum{i in P}(sum{k in M}((tool[k]-FIXTOOL[j, k]) ) * sp[i, k] * 8 * 2 * 6 * 4);


subject to fixing{k in M}:
	sum{j in 1..t}(FIXTOOL[j, k]) = abd[k];


#設定哪些PROD不能被做
subject to production_formula{i in P, j in 1..t, k in M}:
	MK[i, j] = if (tool[k]-FIXTOOL[j, k] = 0 and sp[i, k] > 0) then 0 else 1;
	
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
		