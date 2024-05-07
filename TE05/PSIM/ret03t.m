clear all
clc

% Config simulation
circuit.parname={'Vi','fi','a','Von','ron','R0'}; % Variables names utilizados no enunciado
circuit.parunit={' V',' Hz','','V','&Omega;','&Omega;'}; % Variables unit
circuit.parnamesim={'Vi','fi','a','Von','ron','R0'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'ret03t'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Parameters setup
Vi=(100:25:250); 
fi=50:5:100;
a=0.1:0.05:0.5;
Von=0.5:0.05:0.7;
ron = combnres(1,1e-3,'E24',12);
R0 = combnres(1,[1],'E24',12); %

circuit.Xi=CombVec(Vi,fi,a,Von,ron,R0); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o circuito retificador de onda completa com transformador ideal apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  

q=0;

q=q+1;
quiz.question{q}.str='Qual o valor eficaz da tensão no secundário do transformador?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'vsrms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor médio da tensão na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor médio da corrente na carga?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'I0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da tensão na carga?';
% quiz.question{q}.units={'V'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'v0rms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor médio da corrente no diodo?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'I0'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da corrente no diodo?';
% quiz.question{q}.units={'A'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'i0rms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';



q=q+1;
quiz.question{q}.str='Qual a potência ativa na carga?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a potência aparente na fonte?';
quiz.question{q}.units={'VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'Si'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a potência dissipada nos diodos?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'pd'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o fator de potência?';
quiz.question{q}.units={'W/VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'VAPF_PF'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual a taxa de distorção harmônica da corrente?';
% quiz.question{q}.units={'A/A'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'thdi'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da componente fundamental da corrente na fonte?';
% quiz.question{q}.units={'A'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'ifrms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 


%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimca2xml(circuit,quiz);
    end
else
    psimca2xml(circuit,quiz);
end


