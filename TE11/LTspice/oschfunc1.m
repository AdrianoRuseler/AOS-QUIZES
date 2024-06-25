function  out = oschfunc1(parvalues) % Function 1 for filter 01

% circuit.Xi=CombVec(Vs,R1,R2,R0,C0); %%

Vs = parvalues(1);
R1 = parvalues(2);
R2 = parvalues(3);
R0 = parvalues(4);
C0 = parvalues(5);


out = -1/(2*R0*C0*log(R2/(2*R1+R2))); % Freq de osc