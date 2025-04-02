% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'COMB04op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','RC','RB'}; % Variables names
circuit.parname={'Vcc','RC','RB'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=20:5:30; 

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];

% Rg = combres(1,100000,'E12'); %
% Ry = combres(1,10000,'E12'); %
% R1 = Ry(1:6);
% R2 = Ry(7:12);
% R3 = Ry(1:6);

RB = combnres(1,10000,'E24',12); %
RC = combnres(1,10,'E24',12); %
% RE = combres(1,10,'E12'); %

IS1=[10e-15 15e-15 20e-15];
BF1=10:5:20;

IS2=[10e-15 15e-15 20e-15];
BF2=25:5:50;

% VAF=100:50:200;

% Is=[10e-15 15e-15 20e-15];
% Beta=[1:5]*1e-3;
% Vto=-[1:5];

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,RC,RB,IS1,BF1,IS2,BF2); %%
    % 0 -> TBJ1 Corte + TBJ2 Corte
    % 1 -> TBJ1 Ativo Direto + TBJ2 Ativo Direto
    % 2 -> TBJ1 Ativo Direto + TBJ2 Saturação
    % 3 -> TBJ1 Saturação + TBJ2 Ativo Direto
    % 4 -> TBJ1 Saturação + TBJ2 Saturação
% [combmode]=getcomb04mode(Xi);
% indx=find(combmode==1); %  
% circuit.Xi=Xi(:,indx);

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

circuit.parind=[1:3];

circuit.modind(1,:)=[4 5]; % Index for model parameters
circuit.modind(2,:)=[6 7]; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='TBJ1'; % for .model 
circuit.model(1).tipo='PNP'; % for .model 

circuit.model(2).name='TBJ2'; % for .model 
circuit.model(2).tipo='NPN'; % for .model 

circuit.model(1).parnamesim={'IS','BF'};
circuit.model(1).parname={'IS','BF'};
circuit.model(1).parunit={'A',''};

circuit.model(2).parnamesim={'IS','BF'};
circuit.model(2).parname={'IS','BF'};
circuit.model(2).parunit={'A',''};

% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;

% Generate question
quiz.enunciado = 'Simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo


% quiz.fettype='j1:NJF';
% quiz.feteval = 0; % Evaluate fet op

% 
quiz.tbjtype='q1:pnp'; 
quiz.tbjeval = 0; % Evaluate tbj op

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da tensão base-emissor Vbe em Q1?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vbe'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base Ib em Q1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q1:Ib'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de coletor Ic em Q1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q1:Ic'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o modo de operação do TBJ Q1?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:pnp'}; % Device:Var
quiz.question{q}.vartype={'mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='TBJ';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão base-emissor Vbe em Q2?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q2:Vbe'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base Ib em Q2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q2:Ib'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de coletor Ic em Q2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q2:Ic'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o modo de operação do TBJ Q2?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q2:npn'}; % Device:Var
quiz.question{q}.vartype={'mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='TBJ';




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

