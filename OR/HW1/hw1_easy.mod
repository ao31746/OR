set v;
set o;

param v_c{i in v};
param v_h{i in v};
param o_c{i in o};
param o_h{i in o};

var v_x{i in v};
var o_x{i in o};
var y;

maximize Profit:
	150 * y - (sum{i in v}(v_c[i] * v_x[i]) + sum{i in o}(o_c[i] * o_x[i])) ;
	
subject to v_Supply:
	sum{i in v}(v_x[i]) <= 200;

subject to o_Supply:
	sum{i in o}(o_x[i]) <= 250;
	
subject to Hard:
	sum{i in v}(v_x[i] * v_h[i]) + sum{i in o}(o_x[i] * o_h[i]) <= 6 * y;
	
subject to Easy:
	sum{i in v}(v_x[i] * v_h[i]) + sum{i in o}(o_x[i] * o_h[i]) >= 3 * y;
	
subject to y_limit:
	sum{i in v}(v_x[i]) + sum{i in o}(o_x[i]) = y;
	
subject to nonzero_v{i in v}:
	v_x[i] >= 0;
	
subject to nonzero_o{i in o}:
	o_x[i] >= 0;