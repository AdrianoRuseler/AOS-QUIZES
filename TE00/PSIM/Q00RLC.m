% clear all
% clc

clear circuit quiz q

% Config simulation
circuit.parname={'Vi','fi','L0','C0','R0'}; % Variables names
circuit.parunit={' V',' Hz','H','F','&Omega;'}; % Variables unit
circuit.parnamesim={'Vi','fi','L0','C0','R0'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'Q00RLC'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% eval(circuit.func1str) % Must return a escalar
% circuit.funcstr  = {'Q00RLfunc1(parvalues)','Q00RLfunc2(parvalues)'}; % Array of strings evalstr
% Parameters setup

Vi=(100:25:250); 
fi=50:5:100;
R0 = combres(1,[0.1],'E12'); %
C0 = combcap(1,1e-5,'E12');
L0 = combcap(1,1e-3,'E12');


% 
% Vi=225; 
% fi=[ 60 50 100];
% R0 = 2.7; %
% C0 = 390e-6;
% L0 = 33e-3;


circuit.Xi=CombVec(Vi,fi,L0,C0,R0); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print
circuit.cyclenpts = 1000; % Total number of simulated points per cycles

% Generate question
quiz.enunciado = 'Para o circuito monofásico com carga RLC apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor eficaz da corrente de carga?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'i0rms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor eficaz da tensão no capacitor C0?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'vcrms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da impedância de carga Z0?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'Z0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor do ângulo de carga em graus (deg)?';
quiz.question{q}.units={'Graus'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'phi'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor do ângulo de carga em radianos (rad)?';
% quiz.question{q}.units={'Radianos'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'phirad'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor médio da potência instantânea na carga?';
% quiz.question{q}.units={'W'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o valor da potência ativa na carga?';
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
quiz.question{q}.str='Qual o fator de potência?';
quiz.question{q}.units={'W/VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'VAPF_PF'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';



%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimca2xml(circuit,quiz);
    end
else
    psimca2xml(circuit,quiz);
end

