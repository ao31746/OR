param n;
param x{i in 1..n}; 
param y{i in 1..n};

var C;
var B;
var A;


minimize absolute_deviation:
	sum{i in 1..n}( abs(y[i] - ( C * x[i]^2 + B * x[i] + A)) );
	
	