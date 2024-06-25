clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'OPAMPTBJ05'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','Vi','R1','R2','R3','R4','RL'}; % Variables names
circuit.parname={'Vs','Vi','R1','R2','R3','R4','RL'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

circuit.funcstr  = {'OPAMPTBJ05func1(parvalues)'}; % Array of strings evalstr

% E=[10 11 12 13 15];
% parameters input
R1 = combnres(1,100,'E24',6);
R2 = combnres(1,100,'E24',6);
R3 = combnres(1,100,'E24',6);
R4 = combnres(1,1000,'E24',6);
RL = combnres(1,1000,'E24',6);

% E=[10 11 12 13 15 16 18 20] 22 24 27 30 33 36 39 43 47 51 56 62 68 75 82 91]; % E24 series (tolerance 5% and 1%)

Vs=15; 
Vi=[0.25:0.05:0.5]; 

Is=[10:5:30]*1e-15;
Beta=150:50:250;
nf=1:0.2:2;

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

% Rb = combres(1,[100],'E12'); %
X0=CombVec(Vs,Vi,R1,R2,R3,R4,RL,Is,Beta,nf); %%
% X0=CombVec(Vi,fs,D,L0,C0,R0); %
[~,y]=size(X0);
% nq=randperm(y,2*circuit.nsims); % escolha as questoes
nq=randperm(y); % escolha as questoes
Xi=X0(:,nq);

[mode]=getopamptbj5mode(Xi);
% Mostra estatítica de modos encontrados
Tmode = table(sum(mode(:)==-1),sum(mode(:)==0),sum(mode(:)==1),sum(mode(:)==2));
Tmode.Properties.VariableNames = ["Erro","???","OK","Good"];
disp(Tmode)

indx=find(mode==2); % 1-OK
circuit.Xi=X0(:,indx);
circuit.indx=indx;

% Rb = combres(1,[100],'E12'); %

circuit.timeout = 5; % Simulation timeout in seconds

circuit.parind=[1:7];
circuit.modind=[8 9 10];

circuit.model.parnamesim={'IS','BF','NF'};
circuit.model.parname={'IS','BF','NF'};
circuit.model.parunit={'A','V/V',''};

% circuit.Xm=CombVec(Is,Beta,Va); %%
circuit.model.name='TBJ';
circuit.model.tipo='NPN';

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
quiz.tbjtype='q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op

% Generate question
quiz.enunciado = 'Simule o ponto de operação do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da tensão em Vx?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vx'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão em Vy?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vy'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão de saída Vo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da expressão \( R_4I_s{\left ( \dfrac{V_i}{R_1I_s} \right )}^{ \dfrac{R_3}{R_2}} \) ?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={1}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
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




