% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'TBJ02CA'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost
% Config simulation
circuit.parnamesim={'Vcc','R1','R2','Rc','Re','Cx'}; % Variables names
circuit.parname={'Vcc','R1','R2','Rc','Re','Cx'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;','&Omega;','F'}; % Variables unit

% parameters input
Vcc=15:5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,1000,'E12');
R2 = combres(1,1000,'E12');
Re = combres(1,10,'E12'); %
Rc = combres(1,10,'E12'); %
Cx = 100e-6;

Is=[10e-15 15e-15 20e-15];
Beta=50:25:150;
Va=50:25:150;
% circuit.multiplesims=[10]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

% Rb = combres(1,[100],'E12'); %
X0=CombVec(Vcc,R1,R2,Rc,Re,Cx,Is,Beta,Va); %%
[~,y]=size(X0);
nq=randperm(y,2*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

% Xi=CombVec(Vcc,Rb,Rc,Beta,Vbe,Vcesat); %%
[tbjmode,logdata,paramstr,modelstr]=gettbjnpn02mode(Xi);
% Mostra estatítica de modos encontrados
Tmode = table(sum(tbjmode(:)==2),sum(tbjmode(:)==3));
Tmode.Properties.VariableNames = ["Saturação","Região ativa"];
disp(Tmode)

indx=find(tbjmode==3); % 2 - Saturação; 3 - Região ativa;
circuit.Xi=Xi(:,indx);
circuit.logdata={logdata{indx}};
circuit.logdataparamstr={paramstr{indx}};
circuit.logdatamodelstr={modelstr{indx}};
% circuit.nsims=length(circuit.Xi);

% [~,y]=size(circuit.Xi);
% nq=randperm(y,circuit.nsims); % escolha as questoes
% circuit.X=circuit.Xi(:,nq);

circuit.timeout = 5; % Simulation timeout in seconds
circuit.parind=1:6;
circuit.modind(1,:)=7:9; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='TBJ';
circuit.model(1).tipo='NPN';
circuit.model(1).parnamesim={'IS','BF','VAF'};
circuit.model(1).parname={'IS','BF','VAF'};
circuit.model(1).parunit={'A','','V'};

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 1;

quiz.tbjtype = 'q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op

% Generate question
quiz.enunciado = 'Para o circuito com configuração emissor comum de polarização por divisor resistivo apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.incfrom=0; % Increment from

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo
q=0;
% q=q+1;
% quiz.question{q}.str='Qual o valor do ganho &beta; em CC?';
% quiz.question{q}.units={'A/A'};
% quiz.question{q}.options={'q1:BetaDC'};
% quiz.question{q}.vartype={'oplog'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor do ganho &beta; em CA do TBJ?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.options={'q1:BetaAC'};
quiz.question{q}.vartype={'oplog'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da resistência R&pi; do TBJ?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:Rpi'}; % Device:Var
quiz.question{q}.vartype={'oplog'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da resistência ro do TBJ?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:Ro'}; % Device:Var
quiz.question{q}.vartype={'oplog'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da resistência re do TBJ?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'re'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da impedância de entrada Zi?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'zi'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da impedância de entrada Zi do circuito?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'zicalc'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


% q=q+1;
% quiz.question{q}.str='Qual o valor da impedância de saída Zo do circuito?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'zo'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da impedância de saída Zo do circuito?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'zocalc'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor do ganho de tensão vo/vi?';
% quiz.question{q}.units={'V/V'};
% quiz.question{q}.options={'av'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor do ganho de tensão vo/vi do circuito?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options={'avcalc'};
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




