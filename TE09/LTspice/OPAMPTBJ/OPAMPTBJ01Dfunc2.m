function  out = OPAMPTBJ01Dfunc2(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','Vi','R1','RL'}; % Variables names

% Vs = parvalues(1);
% Vi = parvalues(2);
% R1 = parvalues(3);
% RL = parvalues(4);
% Is = parvalues(5);
% Beta = parvalues(6);
% nf = parvalues(6);

k = 1.3806504e-23;
q = 1.60217662e-19;

Vt=k*(273.15+27)/q;

out = Vt; % ganho Ho 