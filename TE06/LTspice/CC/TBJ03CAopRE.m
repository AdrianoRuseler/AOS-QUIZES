% clear all
clear circuit quiz
clc

% Sets simulation dir
circuit.name = 'TBJ03CAop'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','RB','RE'}; % Variables names
circuit.parname={'Vcc','RB','RE'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=10:5:20; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
Rb = combnres(1,10000,'E24',12); %
% Rc = combres(1,10,'E12'); %
Re = combnres(1,10,'E24',12); %

Is=[10e-15 15e-15 20e-15];
Beta=100:50:300;
Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
% circuit.Xi=CombVec(Vcc,Rb,Re,Is,Beta,Va); %%
% circuit.multiplesims=[10]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

% Rb = combres(1,[100],'E12'); %
X0=CombVec(Vcc,Rb,Re,Is,Beta,Va); %%
[~,y]=size(X0);
nq=randperm(y,1.5*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

% Xi=CombVec(Vcc,Rb,Rc,Beta,Vbe,Vcesat); %%
[tbjmode,logdata]=gettbjnpn03mode(Xi);
% Mostra estatítica de modos encontrados
Tmode = table(sum(tbjmode(:)==2),sum(tbjmode(:)==3));
Tmode.Properties.VariableNames = ["Saturação","Região ativa"];
disp(Tmode)

indx=find(tbjmode==3); % 2 - Saturação; 3 - Região ativa;
circuit.Xi=Xi(:,indx);
circuit.logdata={logdata{indx}};


circuit.parind=[1 2 3];
circuit.modind=[4 5 6];

circuit.model.parnamesim={'IS','BF','VAF'};
circuit.model.parname={'IS','BF','VAF'};
circuit.model.parunit={'A','','V'};
% circuit.model.parvalue=[10e-15 250 100];

% circuit.Xm=CombVec(Is,Beta,Va); %%
circuit.model.name='TBJ';
circuit.model.tipo='NPN';

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run =0;
% Generate question
quiz.enunciado = 'Para a configuração seguidor de emissor apresentada na Figura 1, simule no LTspice o ponto de operação (.op) e determine os parâmetros do modelo de pequenos sinais do TBJ:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 65 - 90
quiz.incfrom=0; % Increment from
% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

quiz.tbjtype='q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op

q=0;
% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente de base Ib?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'q1:Ib'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente de base Ic?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'q1:Ic'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor do ganho &beta; em CC?';
% quiz.question{q}.units={'A/A'};
% quiz.question{q}.options={'q1:BetaDC'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor do ganho &beta; em CA?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.options={'q1:BetaAC'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


% 
% q=q+1;
% quiz.question{q}.str='Qual a tensão Base-Emissor Vbe?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbe'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual a tensão Base-Coletor Vbc?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbc'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[1]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual a tensão Coletor-Emissor Vce?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vce'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[1]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da resistência R&pi;?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:Rpi'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da transcondutância gm?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:Gm'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da resistência re?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
quiz.question{q}.vartype={'re'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da resistência ro?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
quiz.question{q}.vartype={'ro'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

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



