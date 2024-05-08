clear all
clc

% Config simulation
% circuit.name = 'zener01'; % File name
circuit.parnamesim={'Vee','Rb','Re','Beta','Veb','Vecsat'}; % Variables names simulation
circuit.parname={'Vee','Rb','Re','&beta;','Veb','Vecsat'}; % Variables names quiz
circuit.parunit={'V','&Omega;','&Omega;','','V','V'}; % Variables unit

% Simulation setup 
circuit.name = 'tbjcc05pnp'; % File name
% circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.dir = [pwd '\']; %
circuit.theme  = 'boost'; % clean or boost


% parameters input ewMsviqy4dWRd8t
Vee=15:5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6  6.8  8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
Rb = combres(1,[100],'E12'); %
% Rc = combres(1,[10],'E12'); %
Re = combres(1,[10],'E12'); %
Veb=0.5:0.05:0.8;
Beta=[50:5:100];
Vecsat=0.2:0.1:0.5;

circuit.Xi=CombVec(Vee,Rb,Re,Beta,Veb,Vecsat); %%
% circuit.multiplesims=[50 50 100]; % Number of simulations
circuit.nsims= 16; % Number of simulations

% Generate question
quiz.enunciado = ['Para o circuito seguidor de emissor contendo um transistor TBJ do tipo PNP apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.incfrom=0; % Increment from

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IRb'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta TODO

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de coletor?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'Ic'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
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

