set CITY;
set TIME;
set FLIGHT;

set WAIT within {CITY cross CITY cross TIME};
set FLY within {CITY cross CITY cross TIME};
set CITIES within {CITY cross CITY}

param WAITING_COST;
param FLYING_COST{FLIGHT};
param FLYING_D{CITIES};
param DEPART{FLY}
param ARRIVAL{FLY};

var wait{WAIT}integer;
var fly{FLY}integer;

minimize cost:
	sum{k in FLYING_COST}(sum{(i, j)in FLY}(fly[i, j] * FLYING_COST[k] * FLYING_D[i, j]));

subject to node{i in FLY}:
	sum{}
	
subject to wait_non{i in WAIT}:
	wait[i] >=0 ;
	
subject to fly_non{i in FLY}:
	fly[i] >=0 ;