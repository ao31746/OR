set dep; #A B
set city; # London
set link within{dep cross dep};
set clink in {city cross city};

param benefit {i in city, j in dep};
param commu{i in dep, j in dep};
param cost{i in city, j in city};

#if dep A open in city j
var X{i in city, j in dep}binary;



#commu


maximize transfer:
	sum{i in city}(sum{j in dep}(X[i, j]* benefit[i, j]))
	- sum{(i,k)in link}(sum{(j,I) in clink}(commu[i, k] * cost[j, I] ));
	
subject to 1city{j in dep}:
	sum{i in city}(X[i, j]) = 1;
	
subject to 3deip{i in city}:
	sum{j in dep}(X[i, j]) <= 3;

