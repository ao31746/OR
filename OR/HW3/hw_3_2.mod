param n;
param x{i in 1..n}; 
param y{i in 1..n};


var B;
var A;
var Z;
var C;

minimize max_deviation:
	Z;
	
subject to max_consratin{i in 1..n}:
	Z >= abs(y[i] - ( C * x[i]^2 + B * x[i] + A));
	