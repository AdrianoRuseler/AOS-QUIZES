clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'COMB08op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vi','Vs','R1','R2','RL','Rs'}; % Variables names
circuit.parname={'Vi','Vs','R1','R2','RL','Rs'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vi=1:0.25:5; 
Vs=10:5:20;

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];

% Rg = combres(1,100000,'E12'); %
R1 = combnres(1,100,'E24',12); %

R2 = combnres(1,100,'E24',12); %
RL = combnres(1,1,'E24',12); %
Rs = combnres(1,10,'E24',12); %

IS=[10e-15 15e-15 20e-15];
BF=50:25:150;
% VAF=100:50:200;

% Is=[10e-15 15e-15 20e-15];
% Beta=[1:5]*1e-3;
% Vto=-[1:5];

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vi,Vs,R1,R2,RL,Rs,IS,BF); %%
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=[1:6];

circuit.modind(1,:)=[7 8]; % Index for model parameters
% circuit.modind(2,:)=[8 9]; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
% circuit.model(1).name='JFET'; % for .model 
% circuit.model(1).tipo='NJF'; % for .model 

circuit.model(1).name='TBJ'; % for .model 
circuit.model(1).tipo='NPN'; % for .model 

% circuit.model(1).parnamesim={'Beta','Vto'};
% circuit.model(1).parname={'Beta','Vto'};
% circuit.model(1).parunit={'\( \frac{A}{V^2} \)','V'};

circuit.model(1).parnamesim={'IS','BF'};
circuit.model(1).parname={'IS','BF'};
circuit.model(1).parunit={'A',''};

% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;

% Generate question
quiz.enunciado = 'Analise e simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

quiz.eqlist{1}='\(\dfrac{V_i R_2}{R_1+R_2}\)';
quiz.eqlist{2}='\( V_S - \left( 1+\dfrac{R_L}{R_s} \right ) V_i\)';
quiz.eqlist{3}='\( \dfrac{V_i}{R_1+R_2}\)';
quiz.eqlist{4}='\( V_S -  \dfrac{R_2(R_s+R_L)}{R_S(R_1+R_2)}  V_i\)';
quiz.eqlist{5}='\(\dfrac{V_i R_2}{R_S(R_1+R_2)}\)';
quiz.eqlist{6}='\(\dfrac{V_i R_2}{R_S(R_1+R_2)} \dfrac{1}{B_F+1} \)';
quiz.eqlist{7}='\(\dfrac{V_i R_2}{R_S(R_1+R_2)} \dfrac{B_F}{B_F+1} \)';

quiz.eqnum={'A','B','C','D','E','F','G'};
quiz.vartype={'str','str','str','str','str','str','str'};


% quiz.fettype='j1:NJF';
% quiz.feteval = 0; % Evaluate fet op

% 
% quiz.tbjtype='q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op


q=0;

q=q+1;
quiz.question{q}.str='Qual equação calcula o valor da corrente em RL?';
quiz.question{q}.units={'A'};
quiz.question{q}.options=quiz.eqnum; % Only lowcase
quiz.question{q}.vartype=quiz.vartype; % meas 
quiz.question{q}.optscore=[0 0 0 0 0 0 100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor da corrente em RL?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'irl'};
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente de dreno Id?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'j1:Id'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da tensão Dreno-Source Vds?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'j1:Vds'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da tensão Vds de saturação Vds<sub>sat</sub> = Vgs - Vto?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'j1:NJF'}; % Device:Var
% quiz.question{q}.vartype={'feteval:Vgst'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
% q=q+1;
% quiz.question{q}.str='Qual a região de operação do JFET?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'j1:NJF'}; % Device:Var
% quiz.question{q}.vartype={'feteval:mop'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='FET';
% 
% 

% 
% q=2;
% quiz.question{q}.str='b) Qual o valor da corrente Dreno-Source de saturação Idss?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'j1:NJF'}; % Device:Var
% quiz.question{q}.vartype={'feteval:Idss'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 

% q=4;
% quiz.question{q}.str='d) Qual o valor da tensão Dreno-Source Vds?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'j1:Vds'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente de emissor Ie?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'j1:Id'}; % Mesmo do JFET neste caso!!!!
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
q=q+1;
quiz.question{q}.str='Qual equação calcula o valor da corrente de base Ib?';
quiz.question{q}.units={'A'};
quiz.question{q}.options=quiz.eqnum; % Only lowcase
quiz.question{q}.vartype=quiz.vartype; % meas 
quiz.question{q}.optscore=[0 0 0 0 0 100 0]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base Ib?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q1:Ib'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% % 
% 
q=q+1;
quiz.question{q}.str='Qual equação calcula o valor da tensão coletor-emissor Vce?';
quiz.question{q}.units={'V'};
quiz.question{q}.options=quiz.eqnum; % Only lowcase
quiz.question{q}.vartype=quiz.vartype; % meas 
quiz.question{q}.optscore=[0 0 0 100 0 0 0]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor da tensão coletor-emissor Vce?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vce'};
quiz.question{q}.vartype={'log'}; % meas 
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

