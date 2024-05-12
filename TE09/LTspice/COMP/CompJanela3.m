clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'CompJanela3'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vi','Vs','fi','R1','R2','R3','RL'}; % Variables names
circuit.parname={'Vi','Vs','fi','R1','R2','R3','RL'}; % Variables names
circuit.parunit={'V','V','Hz','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vi=15:5:20; 
Vs=15:5:20; 
fi=[1000 500 250 200 100]; 
Vfwd=0.4:0.05:1;
Ron = combnres(1,0.01,'E24'); %

R1 = combnres(1,100,'E24');
R2 = combnres(1,100,'E24');
R3 = combnres(1,100,'E24');
RL = combnres(1,10000,'E24',12);

X0=CombVec(Vi,Vs,fi,R1,R2,R3,RL,Vfwd,Ron); %%

Ron = combres(1,0.01,'E12'); %
% circuit.Xi=CombVec(Vi,Vs,R1,R2,R3,Vfwd); %%r

circuit.timeout = 50; % Simulation timeout in seconds
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

[~,y]=size(X0);
nq=randperm(y,circuit.nsims); % escolha as questoes
circuit.Xi=X0(:,nq);
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

% % Generate question
quiz.enunciado = 'Para o circuito comparador de janela apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 


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
quiz.question{q}.options={'vomax'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de Vo para Vy < Vi < Vx?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vomin'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de Vo para Vi < Vy?';
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



