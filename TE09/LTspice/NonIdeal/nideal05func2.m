function  out = nideal05func2(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','Vi','R1','R2','RL'}; % Variables names

% Vs = parvalues(1);
% Vi = parvalues(2);
R1 = parvalues(3);
R2 = parvalues(4);
% RL = parvalues(5);
% Vos = parvalues(6);

out = R2*R1/(R1+R2); % ganho Ho 