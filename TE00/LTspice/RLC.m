clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'RLC'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vipk','fi','C0','L0','R0'}; % Variables names
circuit.parname={'Vipk','fi','C0','L0','R0'}; % Variables names
circuit.parunit={'V','Hz','F','H','&Omega;'}; % Variables unit

% parameters input
Vipk=100:25:250; 
fi=50:5:100;

R0 = combres(1,[0.1],'E12'); %
L0 = combcap(1,1e-3,'E12'); %
C0 = combcap(1,1e-5,'E12'); %


% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vipk,fi,C0,L0,R0); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=1:5;
% 
% circuit.model.parnamesim={'IS','BF','VAF'};
% circuit.model.parname={'IS','BF','VAF'};
% circuit.model.parunit={'A','','V'};
% % circuit.model.parvalue=[10e-15 250 100];
% circuit.modind=5:7;

% % circuit.Xm=CombVec(Is,Beta,Va); %%
% circuit.model.name='TBJ';
% circuit.model.tipo='NPN';

circuit.cmdtype = '.tran'; % Operation Point Simulation
circuit.cmdupdate = 1; % 

% cmdstr = ['.tran 0 ' num2str(circuit.cycles/circuit.parvalue(circuit.freqind),'%10.8e') ' ' num2str(circuit.printcycle/circuit.parvalue(circuit.freqind),'%10.8e')];

circuit.freqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 5; % Cycle to start print

% quiz.tbjtype = 'q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op
% Generate question
quiz.enunciado = 'Simule no LTspice o circuito com carga RLC apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
% q=q+1;

q=q+1;
quiz.question{q}.str='Qual o valor eficaz da tensão no indutor L0?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vl0rms'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% % 
% 
q=q+1;
quiz.question{q}.str='Qual o valor eficaz da corrente no indutor L0?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'il0rms'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o valor eficaz da tensão na carga RLC?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'virms'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o valor da impedância de carga Z0?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'z0'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=3;
% quiz.question{q}.str='c) Qual o valor do ganho de tensão vo/vi?';
% quiz.question{q}.units={'V/V'};
% quiz.question{q}.options={'av'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da potência ativa na carga?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'p0'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 

q=q+1;
quiz.question{q}.str='Qual o valor da potência aparente na fonte?';
quiz.question{q}.units={'VA'};
quiz.question{q}.options={'si'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor do fator de potência?';
quiz.question{q}.units={'W/VA'};
quiz.question{q}.options={'fp'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

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


