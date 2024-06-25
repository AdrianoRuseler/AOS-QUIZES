function  out = OPAMPTBJ03func1(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','Vi','R1','RL'}; % Variables names

Vs = parvalues(1);
Vi = parvalues(2);
R2 = parvalues(3);
RL = parvalues(4);
Is = parvalues(5);
Beta = parvalues(6);
nf = parvalues(7);

k = 1.3806504e-23;
q = 1.60217662e-19;

nVt=nf*k*(273.15+27)/q;

out = R2*Is*exp(-Vi/nVt); % ganho Ho 