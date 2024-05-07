function  out = diode02func1(parvalues) % Function 1 for filter 01

% circuit.Xi=CombVec(Vcc,R0,Is1,n1); %%
k = physconst('Boltzmann');
q = 1.602176565e-19;
% Vcc = parvalues(1);
% R0 = parvalues(2);
Td = 27 + 273.15;
% Is1 = parvalues(4);
n1 = parvalues(4);

out = n1*k*Td/q; % nVT