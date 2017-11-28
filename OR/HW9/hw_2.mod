set mine;
set year;

param royalty{mine};
param limit{mine};
param quanlity{mine};
param require{i in year};

var X{i in year, j in mine}binary; #pay royal
var PRO{i in year, j in mine}>=0;

maximize profit:
	sum{i in year, j in mine}(10 * PRO[i,j])*0.9^(i-1)
		- sum{i in year, j in mine}(X[i,j]* royalty[j]);
	
	
subject to open{i in year}:
	sum{j in mine}(X[i,j]) <= 3;
	

subject to quality{i in year}:
	sum{j in mine}(PRO[i,j] * quanlity[j]) = require[i] * sum{j in mine}(PRO[i, j]);

subject to quantity{i in year, j in mine}:
	X[i,j] * 5000000 >= PRO[i,j];

subject to produce{i in year, j in mine}:
	PRO[i, j] <= limit[j];
	
subject to run{i in 1..4, j in mine}:
	-X[i, j] + X[i+1, j] <= 0;
	
