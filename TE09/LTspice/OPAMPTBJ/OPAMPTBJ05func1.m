function  out = OPAMPTBJ05func1(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','Vi','R1','R2','R3','R4','RL'}; % Variables names

Vs = parvalues(1);
Vi = parvalues(2);
R1 = parvalues(3);
R2 = parvalues(4);
R3 = parvalues(5);
R4 = parvalues(6);
RL = parvalues(7);
Is = parvalues(8);
Beta = parvalues(9);
nf = parvalues(10);

k = 1.3806504e-23;
q = 1.60217662e-19;

nVt=nf*k*(273.15+27)/q;

out = R4*Is*(Vi/(R1*Is))^(R3/R2); % 