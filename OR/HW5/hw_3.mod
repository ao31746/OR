set F_NODES;
set D_NODES;
set C_NODES;

set F_D_LINKS within {F_NODES cross D_NODES};
set D_C_LINKS within {D_NODES cross C_NODES};
set F_C_LINKS within {F_NODES cross C_NODES};
set pref_f within {F_NODES cross C_NODES};
set pref_d within {D_NODES cross C_NODES};

param f_d_cost{F_D_LINKS};
param d_c_cost{D_C_LINKS};
param f_c_cost{F_C_LINKS};
param weight;


param capacity{F_NODES} >=0;	#factory capacity
param throughtput{D_NODES} >=0;	#depot limmit
param req{C_NODES} >=0;			#customr requirement

var F_D{F_D_LINKS} >=0;
var D_C{D_C_LINKS} >=0;
var F_C{F_C_LINKS} >=0;

minimize transportation_cost:
	sum{(i, j) in F_D_LINKS} (f_d_cost[i, j] * F_D[i, j]) +
	sum{(j, k) in D_C_LINKS} (d_c_cost[j, k] * D_C[j, k]) +
	sum{(i, k) in F_C_LINKS} (f_c_cost[i, k] * F_C[i, k]) -
	weight * (sum{(i, k) in pref_f}(F_C[i, k]) + sum{ (j, k) in pref_d}(D_C[j, k]))
	;
	
subject to factory_cap{i in F_NODES}:
	sum{(i, j) in F_D_LINKS} (F_D[i, j]) +
	sum{(i, k) in F_C_LINKS} (F_C[i, k])  <= capacity[i];

subject to depot_thrp_in{j in D_NODES}:
	sum{(i, j) in F_D_LINKS} (F_D[i, j]) <= throughtput[j];
	
subject to depot_thrp_out{j in D_NODES}:
	sum{(j, k) in D_C_LINKS} (D_C[j, k]) <= throughtput[j];	
	
subject to cus_req{k in C_NODES}:
	sum{(i, k) in F_C_LINKS} (F_C[i, k]) +
	sum{(j, k) in D_C_LINKS} (D_C[j, k])  = req[k];
	
subject to DEPOT_flow{j in D_NODES}:
	sum{(i, j) in F_D_LINKS} (F_D[i, j]) = sum{(j, k) in D_C_LINKS} (D_C[j, k]);



	



