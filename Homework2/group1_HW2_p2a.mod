reset;

option solver cplex;



set years;
set projects;

#param startDate{years,projects} default No;
param returns{years, projects} default 0;
param maxAmt{projects} default Infinity;

var amountInvested{a in projects} >=0; 
var throwOffs{y in years} = sum {a in projects} returns[y,a]*amountInvested[a]; 
var amountNotInvested{y in years} = if y = 2021 
									then 1000000+sum {a in projects}amountInvested[a]*returns[y,a]
									else (1.06*amountNotInvested[y-1] + sum{a in projects}amountInvested[a]*returns[y,a]);

									
maximize totalReturn: amountNotInvested[2024];

subject to maxInvestements{a in projects}: amountInvested[a]<= maxAmt[a];
subject to maxAvailable{y in years}: amountNotInvested[y]>=0;

data group1_HW2_p2a.dat;

solve;

display amountInvested;


 
