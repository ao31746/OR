set mine;

param royalty{mine};
param limit{mine};
param quanlity{mine};
param require{i in 1..5};

var RUN{i in 1..5, j in mine}binary;
var X{i in 1..5, j in mine}binary; #pay royal
var PRO{i in 1..5, j in mine};

maximize profit:
	sum{i in 1..5}(10*sum{j in mine}(PRO[i,j])*(0.9^(i-1)))
		- sum{i in 1..5}(sum{j in mine}(X[i,j]* royalty[j]));
	
	
subject to open{i in 1..5}:
	sum{j in mine}(X[i,j]) <= 3;
	
subject to quality{i in 1..5}:
	(sum{j in mine}(PRO[i, j] * quanlity[j])) / (sum{j in mine}(PRO[i, j])) = require[i];
	 
subject to quantity{i in 1..5, j in mine}:
	X[i, j] = if (PRO[i,j] > 0) then 1 else 0;

subject to produce{i in 1..5, j in mine}:
	PRO[i, j] <= limit[j];

	
subject to run{i in 1..4, j in mine}:
	-RUN[i, j] + RUN[i+1, j] <= 0;
	
