function  out = filter01func5(parvalues) % Function 1 for filter 01

%  circuit.Xi=CombVec(Vs,fi,Avol,GBW); 
fi = parvalues(2);
Avol = parvalues(3);
GBW = parvalues(4);

w0 = 2*pi*(GBW/Avol); % wo
sys = tf(Avol,[1/w0 1]);
% bode(sys)

% [mag,phase] = bode(sys,2*pi*fi);
[~,out] = bode(sys,2*pi*fi); % phase