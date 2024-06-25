function  out = astablefunc2(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vcc','Rc','Rr','Cr'}; % Variables names

% Vcc = parvalues(1);
% Rc = parvalues(2);
Rr = parvalues(3);
Cr = parvalues(4);


out = 1/(2*log(2)*Rr*Cr); % Fre