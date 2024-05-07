clear all
clc

% Config simulation
circuit.parname={'Vi','fi','Von','ron','R0'}; % Variables names utilizados no enunciado
circuit.parunit={' V',' Hz','V','&Omega;','&Omega;'}; % Variables unit
circuit.parnamesim={'Vi','fi','Von','ron','R0'}; % Variables names utilizados na simila��o

% Simulation setup 
circuit.name = 'ret01'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Parameters setup
Vi=(100:25:250); 
fi=50:5:100;
Von=0.5:0.05:0.7;
ron = combnres(1,1e-3,'E24',12);
R0 = combnres(1,[0.1],'E24',12); %

circuit.Xi=CombVec(Vi,fi,Von,ron,R0); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o circuito retificador de meia onda apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os par�metros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  
quiz.incfrom=0; % Increment from

% quiz.exptable=1; % Cria tabela para responder com express�o matem�tica

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor m�dio da tens�o na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)';
% quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta


q=q+1;
quiz.question{q}.str='Qual o valor m�dio da corrente na carga?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'I0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da tens�o na carga?';
% quiz.question{q}.units={'V'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'v0rms'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor m�dio da corrente no diodo?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'I0'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor eficaz da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'i0rms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a pot�ncia dissipada no diodo?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'pd'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a pot�ncia ativa na carga?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual a pot�ncia aparente na fonte?';
quiz.question{q}.units={'VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'Si'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o fator de pot�ncia?';
quiz.question{q}.units={'W/VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'VAPF_PF'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual a taxa de distor��o harm�nica da corrente?';
quiz.question{q}.units={'A/A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'thdi'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor eficaz da componente fundamental da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'ifrms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 


%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        circuits=psimca2xml(circuit,quiz);
    end
else
    circuits=psimca2xml(circuit,quiz);
end


%% report

% circuits2html(circuits)


