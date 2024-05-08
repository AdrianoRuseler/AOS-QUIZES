clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'TBJ04CAop'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','RF','RC'}; % Variables names
circuit.parname={'Vcc','RF','RC'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=10:5:20; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
RF = combnres(1,10000,'E24',12); %
RC = combnres(1,10,'E24',12); %

Is=[10e-15 15e-15 20e-15];
Beta=100:50:300;
Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,RF,RC,Is,Beta,Va); %%
% circuit.multiplesims=[10]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=[1 2 3];
circuit.modind(1,:)=[4 5 6]; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='TBJ';
circuit.model(1).tipo='NPN';
circuit.model(1).parnamesim={'IS','BF','VAF'};
circuit.model(1).parname={'IS','BF','VAF'};
circuit.model(1).parunit={'A','','V'};

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;
% Generate question
quiz.enunciado = 'Para a configura��o realimenta��o de coletor, simule no LTspice o ponto de opera��o (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os par�metros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.incfrom=0; % Increment from

quiz.tbjtype='q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base Ib?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q1:Ib'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base Ic?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q1:Ic'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor do ganho &beta; em CC?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.options={'q1:BetaDC'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a tens�o Base-Emissor Vbe?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vbe'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a tens�o Base-Coletor Vbc?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vbc'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[1]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a tens�o Coletor-Emissor Vce?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vce'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[1]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='b) Qual o valor da resist�ncia Rpi?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:Rpi'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='c) Qual o valor da resist�ncia re?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'re'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='d) Qual o valor da resist�ncia ro?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'ro'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o modo de opera��o do TBJ?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
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



