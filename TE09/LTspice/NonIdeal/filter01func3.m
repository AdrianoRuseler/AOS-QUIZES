function  out = filter01func3(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','R1','R2','RL','C2'}; % Variables names
fi = parvalues(2);
Avol = parvalues(3);
GBW = parvalues(4);


out = 2*pi*GBW/Avol; % freq corte em rads/s