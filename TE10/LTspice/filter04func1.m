function  out = filter04func1(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','R1','R2','C2','RL'}; % Variables names

% Vs = parvalues(1);
R1 = parvalues(2);
R2 = parvalues(3);
% RL = parvalues(5);
% C2 = parvalues(4);

out = R2/R1; % ganho Ho 