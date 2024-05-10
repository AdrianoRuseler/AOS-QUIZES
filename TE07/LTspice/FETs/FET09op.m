clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'FET09op'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vdd','Rd','Rg'}; % Variables names
circuit.parname={'Vdd','Rd','Rg'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vdd=-[20:5:30]; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
Rg = combres(1,100000,'E12'); %
Rd = combres(1,10,'E12'); %

% Is=[10e-15 15e-15 20e-15];
Kp=[1:5]*1e-3;
Vto=-[1:5];

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vdd,Rd,Rg,Kp,Vto); %%
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=[1:3];
circuit.modind=[4:5];

circuit.model.parnamesim={'Kp','Vto'};
circuit.model.parname={'Kp','Vto'};
circuit.model.parunit={'\( \frac{A}{V^2} \)','V'};
% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%
% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model.name='MOSFET'; % for .model 
circuit.model.tipo='PMOS'; % for .model 

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;
% Generate question
quiz.enunciado = 'Simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo


quiz.fettype='m1:pmos';
quiz.feteval = 1; % Evaluate fet op



q=1;
quiz.question{q}.str='a) Qual o valor da corrente de dreno Id?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'m1:Id'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=2;
quiz.question{q}.str='b) Qual o valor da tensão Gate-Source Vgs?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'m1:Vgs'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=3;
quiz.question{q}.str='c) Qual o valor da tensão Dreno-Source Vds?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'m1:Vds'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=4;
quiz.question{q}.str='d) Qual o valor da tensão de threshold Vth?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'m1:Vth'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=3;
% quiz.question{q}.str='c) Qual o valor do ganho &beta; em CC?';
% quiz.question{q}.units={'A/A'};
% quiz.question{q}.options={'q1:BetaDC'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=4;
% quiz.question{q}.str='d) Qual a tensão Base-Emissor Vbe?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbe'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=5;
% quiz.question{q}.str='e) Qual a tensão Base-Coletor Vbc?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbc'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[1]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=6;
% quiz.question{q}.str='e) Qual a tensão Coletor-Emissor Vce?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vce'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[1]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=7;
% quiz.question{q}.str='f) Qual o valor da resistência re?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'re'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=8;
% quiz.question{q}.str='g) Qual o valor da resistência ro?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'ro'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 

q=5;
quiz.question{q}.str='e) Qual o valor da tensão Vgst = - Vgs + Vto?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'m1:pmos'}; % Device:Var
quiz.question{q}.vartype={'feteval:Vgst'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% 
% q=6;
% quiz.question{q}.str='Esta é uma string com informações de como proceder na questão a seguir!';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'m1:pmos'}; % Device:Var
% quiz.question{q}.vartype={'feteval:rd'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='STRING';

q=6;
quiz.question{q}.str='f) Qual a região de operação do MOSFET?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'m1:pmos'}; % Device:Var
quiz.question{q}.vartype={'feteval:mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='FET';


%% 
circuit.nsims= 50; % Number of simulations
quiz.nquiz = 50; % Number of quizes

% circuit.nsims=length(circuit.Xi);
% quiz.nquiz = length(circuit.Xi);

ltspicemd2xml(circuit,quiz); % 


