clear all
clc

% Config simulation
% circuit.name = 'zener01'; % File name
circuit.parnamesim={'Vcc','Rb','Rc','Re','Beta','Vbe','Vcesat'}; % Variables names simulation
circuit.parname={'Vcc','Rb','Rc','Re','&beta;','Vbe','Vcesat'}; % Variables names quiz
circuit.parunit={'V','&Omega;','&Omega;','&Omega;','','V','V'}; % Variables unit

% Simulation setup 
circuit.name = 'tbjcc02'; % File name
% circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.dir = [pwd '\']; %
circuit.theme  = 'boost'; % clean or boost


% parameters input
Vcc=15:5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6  6.8  8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];

Rb = combnres(1,[100],'E192',12); %
Rc = combnres(1,[1],'E192',12); %
Re = combnres(1,[1],'E192',12); %

Vbe=0.6:0.05:0.7;
Beta=[50:5:150];
Vcesat=0.2:0.1:0.5;

% circuit.multiplesims=[50 50 100]; % Number of simulations
circuit.nsims= 16; % Number of simulations

X0=CombVec(Vcc,Rb,Rc,Re,Beta,Vbe,Vcesat); %%

[~,y]=size(X0);
nq=randperm(y,3*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

[tbjmode]=gettbjnpn02mode(Xi);
% Mostra estat�tica de modos encontrados
Tmode = table(sum(tbjmode(:)==2),sum(tbjmode(:)==3));
Tmode.Properties.VariableNames = ["Satura��o","Regi�o ativa"];
disp(Tmode)

indx=find(tbjmode==3); % 2 - Satura��o; 3 - Regi�o ativa;
circuit.Xi=Xi(:,indx);

% Generate question
quiz.enunciado = ['Para o circuito polariza��o de emissor contendo um transistor TBJ do tipo NPN apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os par�metros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.incfrom=0; % Increment from

% https://www.tutorialspoint.com/latex_equation_editor.htm
quiz.exptable=0; % Cria tabela para responder com express�o matem�tica

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor m�dio da corrente de base?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IRb'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta TODO

q=q+1;
quiz.question{q}.str='Qual o valor m�dio da corrente de coletor?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IRc'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \beta \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Coletor','Corrente de Base','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor da rela��o corrente de coletor por corrente na base, Ic/Ib?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.options={'BetaC'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor m�dio da tens�o entre coletor e emissor, Vce?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'Vce'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\(V_{CC}-R_C \beta \frac{V_{CC}-V_{BE}}{R_B}\)';  %TODO
quiz.question{q}.expopts={'Tens�o Vce','Tens�o Vbc','Tens�o em Rb','Tens�o em Rc'}; % Primeira correta TODO
% 
q=q+1;
quiz.question{q}.str='Qual o valor m�dio da tens�o entre base e coletor, Vbc?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'Vbc'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\(V_{BE}-V_{CC}+R_C \beta \frac{V_{CC}-V_{BE}}{R_B}\)';  %TODO
quiz.question{q}.expopts={'Tens�o Vbc','Tens�o Vce','Tens�o em Rb','Tens�o em Rc'}; % Primeira correta TODO


q=q+1;
quiz.question{q}.str='Qual o modo de opera��o do TBJ?';
quiz.question{q}.units={'Corte','Satura��o','Ativo Direto','Ativo Reverso'}; % Options for selection
quiz.question{q}.options={'optx'}; % Var for correct answer
quiz.question{q}.vartype={'meanround'}; % Must be int
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='PSIMCHOICE';


% 
% quiz.question{5}.str='e) Qual o valor da corrente m�dia no resistor R1?';
% quiz.question{5}.units={'A'};
% quiz.question{5}.options={'IR1'};
% quiz.question{5}.vartype={'mean'}; %
% quiz.question{5}.optscore=[100]; % Score per option
% quiz.question{5}.opttol=[10]; % tolerance in percentage %
% quiz.question{5}.type='NUMERICAL';


%% Generates questions
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimdc2xml(circuit,quiz);
    end
else
    psimdc2xml(circuit,quiz);
end


