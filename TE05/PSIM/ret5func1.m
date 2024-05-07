function  out = ret5func1(parvalues) % Function 1 for ret5

% circuit.parname={'Vi','fi','Von','ron','L0','R0'}; % Variables names

% Vi=parvalues(1);
fi=parvalues(2);
% Von=parvalues(3);
% ron=parvalues(4);
L0=parvalues(5);
R0=parvalues(6);

X0=2*pi*fi*L0;

phi=atan(X0/R0);

% beta = puschlowski(a,phi,alpha)

out=puschlowski(0,phi,0);