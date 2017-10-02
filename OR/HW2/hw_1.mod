set P;
set A{P};


param s; # storage cost
param h{i in P, A[i]};
param l{P};
param t;
param c{i in P, A[i], k in 1..t};

var X{i in P, A[i], k in 1..t}; # how many oil to produce every period
var Y{k in 1..t}; # sum of X
var B{i in P, A[i], k in 1..t}; # buy every period
var L{i in P, A[i], k in 1..t}; # left oil every period

maximize Profit:
	sum{k in 1..t}(150 * Y[k]) 
			- sum{i in P}(
				sum{j in A[i]}(
					sum{k in 1..t}( c[i, j, k] * B[i, j, k] )))
			- sum{i in P}(
				sum{j in A[i]}(
					sum{k in 1..t}( L[i, j, k] * s )));
	
subject to Supply{i in P, k in 1..t}:
	sum{j in A[i]}(X[i, j, k]) <= l[i];

subject to Hard{k in 1..t}:
	sum{i in P}(sum{j in A[i]}( X[i, j, k] ) * h[i, j] ) <= 6 * Y[k];
	
subject to Easy{k in 1..t}:
	sum{i in P}(sum{j in A[i]}( X[i, j, k] ) * h[i, j]) >= 3 * Y[k];
	
subject to y_limit{k in 1..t}:
	sum{i in P}(sum{j in A[i]}(X[i, j, k])) = Y[k];
	
subject to period_limit{i in P, j in A[i], k in 2..t}:
	L[i, j, k-1] - X[i, j, k] + B[i, j, k]= L[i, j, k];
	
subject to first_pl{i in P, j in A[i]}:
	500 - X[i, j, 1] + B[i, j, 1] = L[i, j, 1];

subject to last_pl{i in P, j in A[i]}:
	L[i, j, 5] - X[i, j, 6] + B[i, j, 6] = 500;
	
subject to store_limit{i in P, j in A[i], k in 1..t}:
	L[i, j, k] <= 1000;
	
subject to nonzero_X{i in P, j in A[i], k in 1..t}:
	X[i, j, k] >= 0;
	
subject to nonzero_B{i in P, j in A[i], k in 1..t}:
	B[i, j, k] >= 0;

subject to nonzero_L{i in P, j in A[i], k in 1..t}:
	L[i, j, k] >= 0;
		