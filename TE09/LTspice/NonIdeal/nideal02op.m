clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'nideal02op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','Vi','R1','R2','RL'}; % Variables names
circuit.parname={'Vs','Vi','R1','R2','RL'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;','&Omega;'}; % Variables unit


circuit.funcstr  = {'nideal01func1(parvalues)'}; % Array of strings evalstr


% Avol=1Meg GBW=10Meg Slew=10Meg ilimit=25m rail=0 Vos=0 phimargin=45 en=0 enk=0 in=0 ink=0 Rin=500Meg
circuit.level.tipo = 'UniversalOpamp2';
circuit.level.varname={'Ilimit'};
circuit.level.varunit={'A'}; % Variables unit
circuit.level.lvlind = [6];
circuit.parind = [1:5];
% parameters input
Vs=25; 
Vi=[5]; 

% Avol=[10e5 10e6];
ilimit=[5e-3 10e-3 15e-3 20e-3];
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];

R1=[10 12 15 18 22 27]*100; %
R2=[33 39 47 56 68 82]*100; %

% R1 = combres(1,100,'E12');
% R2 = combres(1,100,'E12');
RL = combnres(1,10,'E24',12);

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,Vi,R1,R2,RL,ilimit); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados


circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % 
circuit.LTspice.net.run =1;

% % Generate question
quiz.enunciado = 'Para o circuito amplificador não-ideal com limite da corrente apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da tensão na entrada inversora V-?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vneg'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da tensão de saída Vo?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vo'}; % Only lowcase
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

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
quiz.question{q}.str='Qual o valor da corrente em RL?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'irl'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente na fonte Vs2 (Vnn)?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'iv2'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente em R2?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'ir2'}; % Only lowcase
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


