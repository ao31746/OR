param n;
param x{i in 1..n}; 
param y{i in 1..n};


var B;
var A;


minimize absolute_deviation:
	sum{i in 1..n}( abs(y[i] - ( B * x[i] + A)) );
	
	