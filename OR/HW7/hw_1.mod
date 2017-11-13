set nodes; #n1 n2 n3 n4;
set arcs within{nodes cross nodes};
set des within{nodes};

param qs{nodes, des};
param t{arcs};
param c{arcs};


var X{arcs}>=0;
var XS{arcs, des}>=0;

minimize z:
	sum {(i,j)in arcs}(c[i,j]*t[i,j]*log(c[i,j]/(c[i,j]-X[i,j])));
subject to flow{(i,j) in arcs}:
	sum{k in des}(XS[i, j, k]) = X[i, j];
	
subject to supply{k in nodes,s in des: s<>k}:
	qs[k, s] + sum{(i, k) in arcs}(XS[i,k,s]) = 
		sum{(k,j) in arcs}(XS[k,j,s]);