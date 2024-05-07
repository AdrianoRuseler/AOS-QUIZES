function  out = diode01func1(parvalues) % Function 1 for filter 01

% circuit.Xi=CombVec(Vcc,R0,Td,Is1,n1); %%
k = physconst('Boltzmann');
q = 1.602176565e-19;
% Vcc = parvalues(1);
% R0 = parvalues(2);
Td = parvalues(3) + 273.15;
% Is1 = parvalues(4);
n1 = parvalues(5);

out = n1*k*Td/q; % nVT