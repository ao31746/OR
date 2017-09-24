set P;
set A{P};

param c{i in P, A[i]};
param h{i in P, A[i]};
param t{P};

var x{i in P, A[i]};
var y;

maximize Profit:
	150 * y - sum{i in P}(sum{j in A[i]}(c[i, j] * x[i, j]));
	
subject to Supply{i in P}:
	sum{j in A[i]}(x[i, j]) <= t[i];

subject to Hard:
	sum{i in P}(sum{j in A[i]}(x[i, j] * h[i, j])) <= 6 * y;
	
subject to Easy:
	sum{i in P}(sum{j in A[i]}(x[i, j] * h[i, j])) >= 3 * y;
	
subject to y_limit:
	sum{i in P}(sum{j in A[i]}(x[i, j])) = y;
	
subject to nonzero{i in P, j in A[i]}:
	x[i, j] >= 0;
	