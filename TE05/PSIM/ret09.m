clear all
clc

% Sets simulation dir
% quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR


% Config simulation
circuit.parname={'Vi','fi','a','Von','ron','C0','R0'}; % Variables names
circuit.parunit={' V',' Hz','','V','&Omega;','F','&Omega;'}; % Variables unit
circuit.parnamesim={'Vi','fi','a','Von','ron','C0','R0'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'ret09'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Parameters setup
Vi=(150:25:250); 
fi=50:5:100;
a=0.1:0.05:0.5;
Von=0.6:0.05:0.9;
ron = combres(1,1e-3,'E12');
R0 = combres(1,[10],'E12'); %
C0 = combcap(1,10e-6,'E12');

circuit.Xi=CombVec(Vi,fi,a,Von,ron,C0,R0); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print

%% Generate question
quiz.enunciado = 'Para o circuito retificador de onda completa com filtro capacitivo apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  

q=0;
q=q+1;
quiz.question{q}.str='Qual a tensão media na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da ondulação de tensão na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'deltav0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor eficaz da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'iirms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% 
q=q+1;
quiz.question{q}.str='Qual a potência ativa na carga?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual a potência aparente na fonte?';
quiz.question{q}.units={'VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'Si'}; % Variables from PSIM simulation
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
% 
q=q+1;
quiz.question{q}.str='Qual a taxa de distorção harmônica THD da corrente na fonte?';
quiz.question{q}.units={'A/A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'thdi'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o valor eficaz da componente fundamental da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'ifrms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor eficaz das componentes harmônicas da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'ihrms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a potência total dissipada nos diodos?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'pd'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor eficaz da corrente no capacitor';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'icrms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

%% Generate question
% quiz.enunciado = 'Para o circuito retificador de onda completa com filtro capacitivo apresentado na Figura 1, determine:'; % Enunciado da pergunta!
% quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
% quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  
% % 
% q=0;
% q=q+1;
% quiz.question{q}.str='Qual o valor da ondulação de tensão na carga?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'deltav0'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


% q=q+1;
% quiz.question{q}.str='Qual o valor em graus do ângulo (0 à 180) de entrada em condução do diodo D1?';
% quiz.question{q}.units={'graus'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'thetac'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor em graus do ângulo (0 à 180) de bloqueiro do diodo D1?';
% quiz.question{q}.units={'graus'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'thetab'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor em graus do ângulo (0 à 180) de condução diodo D1?';
% quiz.question{q}.units={'graus'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'gammad'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


% 
% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da tensão na carga?';
% quiz.question{q}.units={'V'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'v0rms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 

% q=q+1;
% quiz.question{q}.str='Qual o valor de pico da corrente nos diodos';
% quiz.question{q}.units={'A'}; % 
% quiz.question{q}.vartype={'max'}; % Not implemented
% quiz.question{q}.options={'idiodo'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da corrente no capacitor';
% quiz.question{q}.units={'A'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'icrms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


% q=q+1;
% quiz.question{q}.str='Qual a potência ativa na carga?';
% quiz.question{q}.units={'W'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual a potência aparente na fonte?';
% quiz.question{q}.units={'VA'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'Si'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual a potência dissipada no diodo?';
% quiz.question{q}.units={'W'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'pd'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 
% q=q+1;
% quiz.question{q}.str='Qual o fator de potência?';
% quiz.question{q}.units={'W/VA'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'VAPF_PF'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 
% q=q+1;
% quiz.question{q}.str='Qual a taxa de distorção harmônica THD da corrente na fonte?';
% quiz.question{q}.units={'A/A'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'thdi'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 
% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da componente fundamental da corrente na fonte?';
% quiz.question{q}.units={'A'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'ifrms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1; 
% quiz.question{q}.str='Qual o valor eficaz das componentes harmônicas da corrente na fonte?';
% quiz.question{q}.units={'A'}; % 
% quiz.question{q}.vartype={'mean'}; % max, min, rms, mean, delta
% quiz.question{q}.options={'ihrms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual a potência total dissipada nos diodos?';
% quiz.question{q}.units={'W'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'pd'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimca2xml(circuit,quiz);
    end
else
    psimca2xml(circuit,quiz);
end

