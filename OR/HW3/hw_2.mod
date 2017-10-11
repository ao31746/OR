param n;
param x{i in 1..n}; 
param y{i in 1..n};


var B;
var A;
var Z;

minimize max_deviation:
	Z;
	
subject to max_consratin{i in 1..n}:
	Z >= abs(y[i] - ( B * x[i] + A));
	