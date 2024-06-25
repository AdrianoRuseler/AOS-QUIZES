function  out = filter01func4(parvalues) % Function 1 for filter 01

% 
fi = parvalues(2);
Avol = parvalues(3);
GBW = parvalues(4);

% fi = 50e3;
% Avol = 1e6;
% GBW = 0.8e6;


w0 = 2*pi*(GBW/Avol); % wo
sys = tf(Avol,[1/w0 1]);
% h = bodeplot(sys,opt)

% sys = tf(Avol,[1/(2*pi*(GBW/Avol)) 1]);


% opt = bodeoptions;
% opt.FreqUnits = 'Hz';
% setoptions(h,'FreqUnits','Hz','Grid','on','XLim',{[0.100 10000]});
% p=getoptions(h);
% [mag,phase] = bode(sys,2*pi*fi);
% out = bode(sys,2*pi*fi); % mag
% ydb = 20*log10(abs(bode(sys,2*pi*fi)))

out = mag2db(abs(bode(sys,2*pi*fi))); % mag in dB





