function  out = filter03func5(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','R1','R2','C1','C2','RL'}; % Variables names

Vs = parvalues(1);
R1 = parvalues(2);
R2 = parvalues(3);
RL = parvalues(6);
C1 = parvalues(4);
C2 = parvalues(5);

out = 1/(R2*C2); % w0