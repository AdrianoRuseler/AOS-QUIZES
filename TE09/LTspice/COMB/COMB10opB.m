clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'COMB10op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','R1','R2','R3'}; % Variables names
circuit.parname={'Vs','R1','R2','R3'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
% Vi=1:0.25:5; 
Vs=15:5:20;

BV1=[2.7 3.3 3.9 4.7 5.6 6.8 3.0 3.6 4.3 5.1];
% BV1=[3.0 3.6 4.3 5.1 6.2 7.5 9.1];
% BV2=[2.7 3.3 3.9 4.7 5.6 6.8 8.2];
Is1=[5:5:15]*1e-15;
n1=1:0.1:1.5;


% Rg = combres(1,100000,'E12'); %
R1 = combnres(1,10,'E24',12); %
R2 = combnres(1,1000,'E24',12); %
R3 = combnres(1,100,'E24',12); %

% IS=[10e-15 15e-15 20e-15];
% BF=50:25:150;
% VAF=100:50:200;

% Is=[10e-15 15e-15 20e-15];
% Beta=[1:5]*1e-3;
% Vto=-[1:5];

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,R1,R2,R3,Is1,n1,BV1); %%
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=[1:4];

circuit.modind(1,:)=[5:7]; % Index for model parameters
% circuit.modind(2,:)=[8 9]; % Index for model parameters


% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='DZ1'; % for .model 
circuit.model(1).tipo='D'; % for .model 
circuit.model(1).parnamesim={'Is','n','BV'};
circuit.model(1).parname={'Is','n','BV'};
circuit.model(1).parunit={'A','','V'};


% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
% circuit.model(1).name='JFET'; % for .model 
% circuit.model(1).tipo='NJF'; % for .model 

% circuit.model(1).name='TBJ'; % for .model 
% circuit.model(1).tipo='NPN'; % for .model 
% 
% % circuit.model(1).parnamesim={'Beta','Vto'};
% % circuit.model(1).parname={'Beta','Vto'};
% % circuit.model(1).parunit={'\( \frac{A}{V^2} \)','V'};
% 
% circuit.model(1).parnamesim={'IS','BF'};
% circuit.model(1).parname={'IS','BF'};
% circuit.model(1).parunit={'A',''};

% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;

% Generate question
quiz.enunciado = 'Analise e simule no LTspice o ponto de operação (.op) do circuito fonte de tensão negativa apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

% quiz.eqlist{1}='\(-\dfrac{R_3}{R_2+R_3} V_Z\)';
% quiz.eqlist{2}='\(-\left( 1+\dfrac{R_3}{R_2} \right ) V_Z\)';
% quiz.eqlist{3}='\(-\dfrac{R_3}{R_2+R_3} V_O\)';
% quiz.eqlist{4}='\(-\left( 1+\dfrac{R_2}{R_1} \right ) V_Z\)';
% quiz.eqlist{5}='\(-\dfrac{R_3}{R_1(R_2+R_3)} V_O\)';
% quiz.eqlist{6}='\(-\dfrac{R_2}{R_1(R_2+R_3)} V_Z\)';
% quiz.eqlist{7}='\(-\left( \dfrac{1}{R_3}+\dfrac{1}{R_2} \right ) V_Z\)';
% 
% quiz.eqnum={'A','B','C','D','E','F','G'};
% quiz.vartype={'str','str','str','str','str','str','str'};


q=0;

q=q+1;
quiz.question{q}.str='Qual o valor da tensão reversa Vz sobre o diodo zener?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vz'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual equação calcula o valor da tensão Vx?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options=quiz.eqnum; % Only lowcase
% quiz.question{q}.vartype=quiz.vartype; % meas 
% quiz.question{q}.optscore=[0 0 100 0 0 0 0]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Vx?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vx'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual equação calcula o valor da tensão Vo?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options=quiz.eqnum; % Only lowcase
% quiz.question{q}.vartype=quiz.vartype; % meas 
% quiz.question{q}.optscore=[0 100 0 0 0 0 0]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Vo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';



% q=q+1;
% quiz.question{q}.str='Qual equação calcula o valor da corrente no diodo zener?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options=quiz.eqnum; % Only lowcase
% quiz.question{q}.vartype=quiz.vartype; % meas 
% quiz.question{q}.optscore=[0 0 0 0 100 0 0]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor da corrente no diodo zener?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir1'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R3?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir3'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
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

