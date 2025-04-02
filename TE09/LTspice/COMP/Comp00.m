% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'Comp00'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','Vi','fi','R1','RL'}; % Variables names
circuit.parname={'Vs','Vi','fi','R1','RL'}; % Variables names
circuit.parunit={'V','V','Hz','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vs=2.5:0.5:10; 
Vi=15:5:20; 
fi = 1000;

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combnres(1,100,'E24',12);
RL = combnres(1,10000,'E24',12);

% Rb = combres(1,[100],'E12'); %
X0=CombVec(Vs,Vi,fi,R1,RL); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

[~,y]=size(X0);
nq=randperm(y,circuit.nsims); % escolha as questoes
circuit.Xi=X0(:,nq);

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % 

% circuit.cmdvarind
% 
% quiz.tbjtype = 'q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op
% % Generate question
quiz.enunciado = 'Para o circuito comparador apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor de Vo para Vi > V+?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vomin'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de Vo para Vi < V+?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vomax'}; % Only lowcase
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





