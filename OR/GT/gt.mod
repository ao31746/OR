set h;	#cluster people = 9
set k;	#product = 37 now 5

param n{i in h};
param p{i in h, j in k};
param r{j in k};
param c_d{j in k};
param c_f{j in k};
param com{j in k};
param d;
param q;

var X{j in k} binary;
var W binary;

maximize profit:
	sum{i in h, j in k}(p[i, j] * r[j] * X[j] * n[i]) - d * sum{j in k}(c_f[j] * X[j]) 
	- sum{i in h, j in k}(c_d[j] * n[i] * p[i, j] * X[j])+ q * W;

subject to w: 
	sum{j in k}(com[j]*X[j]) >= 2 * W;
	
