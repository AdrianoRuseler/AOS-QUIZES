% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
% circuit.name = 'zener01'; % File name
circuit.parnamesim={'Vcc','Rb','Rc','Beta','Veb','Vecsat'}; % Variables names
circuit.parname={'Vcc','Rb','Rc','&beta;','Veb','Vecsat'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','','V','V'}; % Variables unit

% Simulation setup 
circuit.name = 'tbjcc01pnp'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost


% parameters input
Vcc=15:5:30; 
Rb = combnres(1,[1000],'E192',24); % Região Ativa
% Rb = combnres(1,[100],'E192',24); % Saturação
Rc = combnres(1,[1],'E192',24); %
Veb=0.5:0.05:0.8;
Beta=[50:5:150];
Vecsat=0.2:0.1:0.5;

X0=CombVec(Vcc,Rb,Rc,Beta,Veb,Vecsat); %%
% circuit.multiplesims=[50 50 100]; % Number of simulations
% circuit.nsims = 32; % Number of simulations
circuit.nsims = 32; % Number of simulations

[~,y]=size(X0);
nq=randperm(y,3*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

[tbjmode]=gettbjpnp01mode(Xi);
% Mostra estatítica de modos encontrados
Tmode = table(sum(tbjmode(:)==2),sum(tbjmode(:)==3));
Tmode.Properties.VariableNames = ["Saturação","Região ativa"];
disp(Tmode)

indx=find(tbjmode==3); % 2 - Saturação; 3 - Região ativa;
circuit.Xi=Xi(:,indx);


% Generate question
quiz.enunciado = ['Para o circuito de polarização fixa com transistor TBJ do tipo PNP apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.incfrom=25; % Increment from

% https://www.tutorialspoint.com/latex_equation_editor.htm
quiz.exptable=0; % Cria tabela para responder com expressão matemática

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IRb'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % Tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta TODO

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de coletor?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IRc'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % Tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \beta \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Coletor','Corrente de Base','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor da relação corrente de coletor por corrente na base, Ic/Ib?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.options={'BetaC'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão entre emissor e coletor, Vec?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'Vec'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\(V_{CC}-R_C \beta \frac{V_{CC}-V_{BE}}{R_B}\)';  %TODO
quiz.question{q}.expopts={'Tensão Vce','Tensão Vbc','Tensão em Rb','Tensão em Rc'}; % Primeira correta TODO

q=q+1;
quiz.question{q}.str='Qual o valor da tensão entre coletor e base, Vcb?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'Vcb'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\(V_{BE}-V_{CC}+R_C \beta \frac{V_{CC}-V_{BE}}{R_B}\)';  %TODO
quiz.question{q}.expopts={'Tensão Vbc','Tensão Vce','Tensão em Rb','Tensão em Rc'}; % Primeira correta TODO

q=q+1;
quiz.question{q}.str='Qual o modo de operação do TBJ?';
quiz.question{q}.units={'Corte','Saturação','Ativo Direto','Ativo Reverso'}; % Options for selection
quiz.question{q}.options={'optx'}; % Var for correct answer
quiz.question{q}.vartype={'meanround'}; % Must be int
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='PSIMCHOICE';



%% Generates questions
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimdc2xml(circuit,quiz);
    end
else
    psimdc2xml(circuit,quiz);
end

