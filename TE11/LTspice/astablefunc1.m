function  out = astablefunc1(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vcc','Rc','Rr','Cr'}; % Variables names
% Qual o valor da relação \( t_H = ln(2)R_r C_r \)?

% Vcc = parvalues(1);
% Rc = parvalues(2);
Rr = parvalues(3);
Cr = parvalues(4);


out = log(2)*Rr*Cr; % Fre