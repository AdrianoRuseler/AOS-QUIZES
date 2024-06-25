clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'nideal04op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','Vi','R1','R2','RL','Ib'}; % Variables names
circuit.parname={'Vs','Vi','R1','R2','RL','Ib'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;','&Omega;','A'}; % Variables unit


circuit.funcstr  = {'nideal01func1(parvalues)'}; % Array of strings evalstr


% % Avol=1Meg GBW=10Meg Slew=10Meg ilimit=25m rail=0 Vos=0 phimargin=45 en=0 enk=0 in=0 ink=0 Rin=500Meg
% circuit.level.tipo = 'UniversalOpamp2';
% circuit.level.varname={'in'};
% circuit.level.varunit={'A'}; % Variables unit
% circuit.level.lvlind = [6];
% circuit.parind = [1:5];

% parameters input
Vs=15:5:25; 
Vi=[1:3]; 

% Avol=[100 150 200 250];
Ib=[5e-6 10e-6 15e-6 20e-6];
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combnres(1,1000,'E24',12);
R2 = combnres(1,1000,'E24',12);
RL = combres(1,100,'E12');

% Is=[10e-15 15e-15 20e-15];
% Beta=50:50:300;
% Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,Vi,R1,R2,RL,Ib); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados


circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % 
% circuit.LTspice.net.run =1;

% % Generate question
quiz.enunciado = 'Para o circuito amplificador não-ideal com corrente de polarização Ib apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
% q=q+1;
% quiz.question{q}.str='a) Qual o valor da tensão na entrada inversora V-?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vneg'}; % Only lowcase
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão de saída Vo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor do ganho de tensão Vo/Vi?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options={'g'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da relação -R2/R1?';
quiz.question{q}.units={'&Omega;/&Omega;'};
quiz.question{q}.options={1}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir1'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir2'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


% 
% q=6;
% quiz.question{q}.str='f)  Qual o valor da corrente em RL?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'irl'}; % Only lowcase
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';




%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        quiz.nquiz = circuit.nsims;
        ltspicemd2xml(circuit,quiz);
    end
else
    quiz.nquiz = circuit.nsims;
    ltspicemd2xml(circuit,quiz);
end

