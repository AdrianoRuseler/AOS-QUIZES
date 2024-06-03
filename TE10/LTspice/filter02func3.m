function  out = filter02func3(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','R1','R2','C1','RL'}; % Variables names

Vs = parvalues(1);
R1 = parvalues(2);
R2 = parvalues(3);
RL = parvalues(5);
C1 = parvalues(4);

out = 1/(R1*C1); % w0