set nodes; #n1 n2 n3 n4;
set arcs;  #a1 a2 a3 a4
set od within{nodes cross nodes};
set p{od}; #1: 1 2 3 , 2: 1 2
set routes {od};
#set links within{nodes cross nodes};


param dig{arcs};
param delta{(r,s) in od, p[r,s], arcs};
#param delta{routes[od]};
param qrs{od};


var X{arcs};
var F{(r,s) in od, p[r,s]} >=0; #flow
var T{arcs};

minimize z:
	sum {a in arcs} (X[a] + 0.03 * X[a]^5 / (dig[a]^4) );
		
subject to xa{a in arcs}:
	X[a] = sum{(r,s) in od, k in p[r,s]}(		
			  F[r,s,k] * delta[r,s,k,a]
					);	
subject to flow_equibity{(r, s) in od}:
	sum{k in p[r,s]}(F[r, s, k]) = qrs[r,s];
	
subject to tcons{a in arcs}:
	T[a] =  1 + 0.15 * (X[a]/dig[a])^4;
	 