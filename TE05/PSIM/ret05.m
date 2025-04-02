% clear all
clear circuit quiz
clc

% Sets simulation dir
% quiz2matlabdir='E:\Dropbox\GitHub\quiz2matlab'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
circuit.parname={'Vi','fi','Von','ron','L0','R0'}; % Variables names
circuit.parunit={' V',' Hz','V','&Omega;','H','&Omega;'}; % Variables unit
circuit.parnamesim={'Vi','fi','Von','ron','L0','R0'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'ret05'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% eval(circuit.func1str) % Must return a escalar
circuit.funcstr  = {'ret5func1(parvalues)','ret5func2(parvalues)'}; % Array of strings evalstr
% Parameters setup

Vi=(100:25:250); 
fi=50:5:100;
Von=0.5:0.05:0.7;

ron = combres(1,1e-3,'E12');
R0 = combres(1,[0.1],'E12'); %
L0 = combcap(1,1e-3,'E12');

circuit.Xi=CombVec(Vi,fi,Von,ron,L0,R0); %%
circuit.nsims = 32; % Numero de circuitos a serem simulados
circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o circuito retificador de meia onda com carga RL apresentado na Figura 1, determine:'; % Enunciado da pergunta!

q=1;
quiz.question{q}.str='a) Qual o valor médio da tensão na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=2;
quiz.question{q}.str='b) Qual o valor médio da tensão no resistor R0?';
quiz.question{q}.units={'V'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'vR0'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=3;
quiz.question{q}.str='c) Qual o valor do ângulo de carga em graus?';
quiz.question{q}.units={'Graus'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'phi'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=4;
quiz.question{q}.str='d) Qual o valor do ângulo de extinção \( \beta \) da corrente em graus?';
quiz.question{q}.units={'Graus'}; % 
quiz.question{q}.vartype={'func'}; % MATLAB Function
quiz.question{q}.options={1}; % Number of the function
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=5;
quiz.question{q}.str='e) Qual a potência ativa na carga?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=6;
quiz.question{q}.str='f) Qual a potência aparente na fonte?';
quiz.question{q}.units={'VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'Si'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=7;
quiz.question{q}.str='g) Qual a potência dissipada no diodo?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'pd'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=8;
quiz.question{q}.str='h) Qual o fator de potência?';
quiz.question{q}.units={'W/VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'VAPF_PF'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=9;
quiz.question{q}.str='i) Qual a taxa de distorção harmônica da corrente na fonte?';
quiz.question{q}.units={'A/A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'thdi'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=10;
quiz.question{q}.str='j) Qual o valor eficaz da componente fundamental da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'ifrms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';




%% Generate quizes

psimca2xml(circuit,quiz)

