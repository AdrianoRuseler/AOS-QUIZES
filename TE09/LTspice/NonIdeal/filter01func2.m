function  out = filter01func2(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','R1','R2','C2','RL'}; % Variables names

% Vs = parvalues(1);
fi = parvalues(2);
Avol = parvalues(3);
GBW = parvalues(4);
% RL = parvalues(5);
% C2 = parvalues(4);

out = 20*log10(Avol/sqrt(2)); % ganho Ho em dB