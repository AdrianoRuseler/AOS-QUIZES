% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'FET00op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vdd','Vgg','Rd','Rg'}; % Variables names
circuit.parname={'Vdd','Vgg','Rd','Rg'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vdd=10:5:30; 
Vgg=-[1:5]; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
Rg = combnres(1,10000,'E24'); %
Rd = combnres(1,10,'E24'); %

% Is=[10e-15 15e-15 20e-15];
Beta=[1:5]*1e-3;
% Vto=-[5:10];
Vto=-[1:5];

% Rb = combres(1,[100],'E12'); %
Xi=CombVec(Vdd,Vgg,Rd,Rg,Beta,Vto); %%
[fetmode]=getnjf00mode(Xi);
indx=find(fetmode==2); % 1- Corte; 2 - Saturação; 3 - ôhmica;
circuit.Xi=Xi(:,indx);

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

circuit.parind=[1:4];
circuit.modind=[5:6];

circuit.model.parnamesim={'Beta','Vto'};
circuit.model.parname={'Beta','Vto'};
circuit.model.parunit={'\( \frac{A}{V^2} \)','V'};
% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%
% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model.name='JFET'; % for .model 
circuit.model.tipo='NJF'; % for .model 

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;
% Generate question
quiz.enunciado = 'Simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.incfrom=0; % Increment from

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo


quiz.fettype='j1:NJF';
quiz.feteval = 1; % Evaluate fet op

% 
% quiz.tbjtype='q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente de dreno Id?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'j1:Id'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente Dreno-Source de saturação Idss?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'j1:NJF'}; % Device:Var
quiz.question{q}.vartype={'feteval:Idss'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Gate-Source Vgs?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:Vgs'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Dreno-Source Vds?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:Vds'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da tensão Vds de saturação Vds<sub>sat</sub> = Vgs - Vto?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:NJF'}; % Device:Var
quiz.question{q}.vartype={'feteval:Vgst'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% 
% q=7;
% quiz.question{q}.str='g) Qual o valor da resistência rd?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'j1:NJF'}; % Device:Var
% quiz.question{q}.vartype={'feteval:rd'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a região de operação do JFET?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:NJF'}; % Device:Var
quiz.question{q}.vartype={'feteval:mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='FET';



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



