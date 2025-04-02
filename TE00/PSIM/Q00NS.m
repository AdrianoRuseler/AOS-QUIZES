% clear all
% clc
clear circuit quiz q

% Config simulation
circuit.parname={'Vpk1','f1','Vpk3','Vphi3','Ipk1','Iphi1','Ipk3','Iphi3','Ipk5','Iphi5'}; % Variables names
circuit.parunit={' V',' Hz',' V',' Graus',' A',' Graus',' A',' Graus',' A',' Graus'}; % Variables unit
circuit.parnamesim={'Vpk1','f1','Vpk3','Vphi3','Ipk1','Iphi1','Ipk3','Iphi3','Ipk5','Iphi5'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'Q00NS'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% eval(circuit.func1str) % Must return a escalar
% circuit.funcstr  = {'Q00RLfunc1(parvalues)','Q00RLfunc2(parvalues)'}; % Array of strings evalstr
% Parameters setup

Vpk1=100:25:250; 
f1=50:5:100;

Vpk3=5:5:15; 
Vphi3 = 0:45:180;

Ipk1=10:5:25;
Iphi1 = 0:5:45;

Ipk3=[1 3 5];
Iphi3 = 0:45:180;

Ipk5=[2 4];
Iphi5 = 0:45:180;


circuit.Xi=CombVec(Vpk1,f1,Vpk3,Vphi3,Ipk1,Iphi1,Ipk3,Iphi3,Ipk5,Iphi5); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o circuito monofásico contendo harmônicos apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor eficaz da corrente de carga?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'irms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor eficaz da fundamental de corrente de carga?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'i1rms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor eficaz dos harmônicos de corrente de carga?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'ihrms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% 
q=q+1;
quiz.question{q}.str='Qual o valor eficaz da tensão na fonte?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'vrms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% % 
% % 
q=q+1;
quiz.question{q}.str='Qual o valor eficaz dos harmônicos de tensão na fonte?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'vhrms'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da THD de corrente na fonte?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'thdi'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da THD de tensão na fonte?';
% quiz.question{q}.units={'V/V'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'thdv'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 
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
% 
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

