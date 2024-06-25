function  out = filter01func1(parvalues) % Function 1 for filter 01

% circuit.Xi=CombVec(Vs,Avol,GBW);

% Vs = parvalues(1);
fi = parvalues(2);
Avol = parvalues(3);
GBW = parvalues(4);
% RL = parvalues(5);
% C2 = parvalues(4);

out =20*log10(Avol); % ganho Ho em dB