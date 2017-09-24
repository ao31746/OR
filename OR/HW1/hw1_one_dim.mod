set P;

param n;
param c{i in P, j in 1..n};
param h{i in P, j in 1..n};
param t{i in P};

var x{i in P, j in 1..n};
var y;

maximize Profit:
	150 * y - sum{i in P}(sum{j in 1..n}(c[i, j] * x[i, j]));
	
subject to Supply{i in P}:
	sum{j in 1..n}(x[i, j]) <= t[i];
	
subject to Hard:
	sum{i in P}(sum{j in 1..n}(x[i, j] * h[i, j])) <= 6 * y;
	
subject to Easy:
	sum{i in P}(sum{j in 1..n}(x[i, j] * h[i, j])) >= 3 * y;
	
subject to y_limit:
	sum{i in P}(sum{j in 1..n}(x[i, j])) = y;
	
subject to nonzero{i in P, j in 1..n}:
	x[i, j] >= 0;
	