clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'OPAMPTBJ04'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','Vi','R2','RL'}; % Variables names
circuit.parname={'Vs','Vi','R2','RL'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;'}; % Variables unit

circuit.funcstr  = {'OPAMPTBJ04func1(parvalues)'}; % Array of strings evalstr

% parameters input
R2 = combnres(1,100,'E24');
RL = combres(1,1000,'E12');

% E=[10 11 12 13 15 16 18 20 22 24 27 30 33 36 39 43 47 51 56 62 68 75 82 91]; % E24 series (tolerance 5% and 1%)

Vs=15:5:25; 
Vi=[0.6:0.05:0.8]; 

Is=[10:30]*1e-15;
Beta=50:50:250;
nf=1:0.1:2;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,Vi,R2,RL,Is,Beta,nf); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=[1 2 3 4];
circuit.modind=[5 6 7];

circuit.model.parnamesim={'IS','BF','NF'};
circuit.model.parname={'IS','BF','NF'};
circuit.model.parunit={'A','V/V',''};

% circuit.Xm=CombVec(Is,Beta,Va); %%
circuit.model.name='TBJ';
circuit.model.tipo='PNP';

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
quiz.tbjtype='q1:pnp';
quiz.tbjeval = 0; % Evaluate tbj op

% Generate question
quiz.enunciado = 'Simule o ponto de opera��o do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os par�metros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir2'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
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
quiz.question{q}.str='Qual o modo de opera��o do TBJ?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:pnp'}; % Device:Var
quiz.question{q}.vartype={'mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='TBJ';

q=q+1;
quiz.question{q}.str='Qual o valor da tens�o de sa�da Vo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='d) Qual o valor da express�o \( -R_2I_se^{\dfrac{V_i}{nV_T}} \) ?';
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




