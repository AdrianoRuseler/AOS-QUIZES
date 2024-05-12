clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'CompJanela2'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vi','Vs','fi','R1','R2','R3','RL'}; % Variables names
circuit.parname={'Vi','Vs','fi','R1','R2','R3','RL'}; % Variables names
circuit.parunit={'V','V','Hz','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vs=5:5:15; 
Vi=10:5:20; 
fi=[1000 500 250 200 100]; 
Vfwd=0.4:0.05:1;
Ron = combres(1,0.01,'E12'); %

R1 = combnres(1,100,'E24',12);
R2 = combnres(1,100,'E24',12);
R3 = combnres(1,100,'E24',12);
RL = combnres(1,10000,'E24',12);

circuit.Xi=CombVec(Vi,Vs,fi,R1,R2,R3,RL,Vfwd,Ron); %%
circuit.timeout = 50; % Simulation timeout in seconds
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados
% 
circuit.parind=1:7;
% 
circuit.model.parnamesim={'Vfwd','Ron'};
circuit.model.parname={'Vfwd','Ron'};
circuit.model.parunit={'V','&Omega;'};

circuit.modind=8:9;


circuit.model.name='Dx';
circuit.model.tipo='D';

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % 
% circuit.cmdvarind
% 
% quiz.tbjtype = 'q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op
% % Generate question
quiz.enunciado = 'Para o circuito comparador de janela apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor de comparação Vx?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vx'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor de comparação Vy?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vy'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de Vo para Vi > Vx?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vomin'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de Vo para Vy < Vi < Vx?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vomax'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de Vo para Vi < Vy?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vomin'}; % Only lowcase
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




