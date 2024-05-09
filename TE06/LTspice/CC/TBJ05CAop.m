clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'TBJ05CAop'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R1','R2','RC','RE'}; % Variables names
circuit.parname={'Vcc','R1','R2','RC','RE'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=10:5:20; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combnres(1,10000,'E24',6); % Ativo Direto
R2 = combnres(1,10000,'E24',6); % Ativo Direto
% R1 = combnres(1,100,'E24',6); % Saturação
% R2 = combnres(1,100,'E24',6); % Saturação
Rc = combnres(1,10,'E24',6); %
Re = combnres(1,10,'E24',6); %

Is=[10e-15 15e-15 20e-15];
Beta=50:25:150;
Va=100:25:200;

% Rb = combres(1,[100],'E12'); %
% circuit.Xi=CombVec(Vcc,R1,R2,Rc,Re,Is,Beta,Va); %%
% circuit.multiplesims=[10]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

X0=CombVec(Vcc,R1,R2,Rc,Re,Is,Beta,Va); %%
[~,y]=size(X0);
nq=randperm(y,3*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

[tbjmode,logdata,logfiles]=gettbjnpn05mode(Xi);

% Mostra estatítica de modos encontrados
Tmode = table(sum(tbjmode(:)==2),sum(tbjmode(:)==3));
Tmode.Properties.VariableNames = ["Saturação","Região ativa"];
disp(Tmode)

indx=find(tbjmode==3); % 2 - Saturação; 3 - Região ativa;
if isempty(indx)
    return
end
circuit.Xi=Xi(:,indx);
circuit.indx=indx;
circuit.logdata={logdata{indx}};

circuit.parind=[1:5];
circuit.modind(1,:)=[6:8]; % Index for model parameters

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
quiz.enunciado = 'Para a configuração com divisor de tensão, simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 65 - 90
quiz.incfrom=25; % Increment from

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

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
quiz.question{q}.str='Qual a tensão Base-Emissor Vbe?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vbe'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a tensão Base-Coletor Vbc?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vbc'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[1]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a tensão Coletor-Emissor Vce?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vce'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[1]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da resistência Rpi?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:Rpi'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da resistência re?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'re'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da resistência ro?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'ro'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o modo de operação do TBJ?';
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


