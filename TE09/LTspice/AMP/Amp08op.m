% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'Amp08op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','Vi','R1','R2','R3','R4','R5'}; % Variables names
circuit.parname={'Vs','Vi','R1','R2','R3','R4','R5'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vs=20:5:30; 
Vi=[1:5]; 

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combnres(1,1000,'E24',5);
R2 = combnres(1,1000,'E24',5);
R3 = combnres(1,1000,'E24',5);
R4 = combnres(1,1000,'E24',5);
R5 = combnres(1,1000,'E24',5);

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,Vi,R1,R2,R3,R4,R5); %%
circuit.timeout = 5; % Simulation timeout in seconds
% circuit.multiplesims=[50 50 50]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % 

% % Generate question
quiz.enunciado = 'Para o circuito amplificador apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir1'}; % Only lowcase
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


q=q+1;
quiz.question{q}.str='Qual o valor de Vo2?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo2'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R3?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir3'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente em R4?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'ir4'}; % Only lowcase
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da tensão Vo1?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo1'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor do ganho de tensão Vo1/Vi?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options={'g'}; % Only lowcase
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

