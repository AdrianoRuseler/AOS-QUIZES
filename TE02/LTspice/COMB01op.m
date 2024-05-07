clear all
clc

% Sets simulation dir
circuit.name = 'COMB01op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R1','R2'}; % Variables names
circuit.parname={'Vcc','R1','R2'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=20:5:30; 

BV1=[3.0 3.6 4.3 5.1 6.2 7.5 9.1];
BV2=[2.7 3.3 3.9 4.7 5.6 6.8 8.2];

% Rg = combres(1,100000,'E12'); %
R1 = combnres(1,10,'E24',12); %
R2 = combnres(1,1,'E24',12); %

Is1=[5:15]*1e-15;
n1=1:0.1:1.5;

Is2=[5:30]*1e-15;
n2=1:0.1:1.5;


% VAF=100:50:200;


% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,R1,R2,Is1,n1,BV1,Is2,n2,BV2); %%
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados


circuit.parind=[1:3];

circuit.modind(1,:)=[4:6]; % Index for model parameters
circuit.modind(2,:)=[7:9]; % Index for model parameters


% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='DZ1'; % for .model 
circuit.model(1).tipo='D'; % for .model 

circuit.model(2).name='DZ2'; % for .model 
circuit.model(2).tipo='D'; % for .model 

circuit.model(1).parnamesim={'Is','n','BV'};
circuit.model(1).parname={'Is','n','BV'};
circuit.model(1).parunit={'A','','V'};

circuit.model(2).parnamesim={'Is','n','BV'};
circuit.model(2).parname={'Is','n','BV'};
circuit.model(2).parunit={'A','','V'};

% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;

% Generate question
quiz.enunciado = 'Simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.rowfigdirective=1;
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo


% quiz.fettype='j1:NJF';
% quiz.feteval = 0; % Evaluate fet op

% 
% quiz.tbjtype='q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op
q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente no diodo zener DZ1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ID1'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente no diodo zener DZ2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ID2'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão no diodo zener DZ1?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vz1'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão no diodo zener DZ2?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vz2'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão no resistor R1?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vb'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% 
% % 
% q=4;
% quiz.question{q}.str='d) Qual o valor da tensão sobre os diodos D1 e D2?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vd'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
% q=5;
% quiz.question{q}.str='e) Qual a potência dissipada no diodo LED?';
% quiz.question{q}.units={'W'};
% quiz.question{q}.options={'pled'}; % Device:Var
% quiz.question{q}.vartype={'meas'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';




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



