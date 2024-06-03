function  out = filter02func4(parvalues) % Function 1 for filter 01

% 
Vs = parvalues(1);
R1 = parvalues(2);
R2 = parvalues(3);
RL = parvalues(5);
C1 = parvalues(4);


out = 1/(2*pi*R1*C1); % f0