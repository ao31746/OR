set STU;
set PRO;

param pref {STU, PRO} >=0;
param upper;
param lower;


var X {STU, PRO} binary;

minimize pref_cost:
	sum{i in STU}(
	sum{j in PRO}( pref[i, j] * X[i, j]));
	
subject to allo_l{j in PRO}:
	sum{i in STU} (  X[i, j]) <= upper;
subject to allo_h{j in PRO}:
	sum{i in STU} (  X[i, j]) >= lower;
#subject to ass_pro{j in PRO}:
#	sum{i in STU} ( X[i, j]) = 1;
subject to ass_peo{i in STU}:
	sum{j in PRO} ( X[i, j]) = 1;