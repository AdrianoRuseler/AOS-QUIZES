clear all
clc

% Config simulation
circuit.name = 'diode00'; % File name
circuit.dir = [pwd '\']; %
circuit.theme  = 'boost'; % clean or boost
circuit.parname={'Vi','Von','Vz','Vled','R1','R2'}; % Variables names
circuit.parnamesim={'Vi','Von','Vz','Vled','R1','R2'}; % Variables names
circuit.parunit={'V','V','V','V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vi=5:5:30; 
Von=0.5:0.05:0.7;
Vled=2.5:0.05:5;
% Vz=[6.2 7.5 9.1 2.7 3.3 3.9 4.7 5.6 6.8 8.2];
Vz=[6.2 7.5 9.1 6.8 8.2];
% Vz2=[2.7 3.3 3.9 4.7 5.6  6.8  8.2];
% Vz1=[ 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,[10],'E24'); %
R2 = combres(1,[10],'E24'); %
% R3 = combres(1,[10],'E12'); %

X0=CombVec(Vi,Von,Vz,Vled,R1,R2);
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

[~,y]=size(X0);
nq=randperm(y,3*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

[circuitmode]=getdiode00mode(Xi);
% Mostra estatítica de modos encontrados
Tmode = table(sum(circuitmode(:)==0),sum(circuitmode(:)==1),sum(circuitmode(:)==2));
Tmode.Properties.VariableNames = ["All Off","Zener Off","Zener On"];
disp(Tmode)

indx=find(circuitmode==2); % 0 -> All Off; 1 -> Zener Off; 2 -> Zener On
circuit.Xi=Xi(:,indx);

% circuit.engine ='psim'; % PSIM ou LTspice simulation
% circuit.engine ='ltspice'; % PSIM ou LTspice simulation

% Generate question

quiz.enunciado = ['Para o circuito contendo um diodo e um diodo zener com tensões de polarização direta Von'...
    ', o zener com tensão de polarização reversa Vz e um diodo LED de tensão direta Vled apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  
quiz.incfrom=0; % Increment from

% https://www.tutorialspoint.com/latex_equation_editor.htm
quiz.exptable=0; % Cria tabela para responder com expressão matemática

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor médio da corrente no resistor R1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IR1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor médio da tensão no resistor R2?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'VR2'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta %TODO
% 
q=q+1;
quiz.question{q}.str='Qual o valor médio da corrente no diodo zener Z1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'Iz'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor da potência média no diodo zener Z1?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'Pz'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta %TODO

% q=q+1;
% quiz.question{q}.str='Qual o valor da potência média na fonte Vi?';
% quiz.question{q}.units={'W'};
% quiz.question{q}.options={'PVi'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da potência média no LED?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'Pled'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
quiz.question{q}.expopts={'Corrente de Base','Corrente de Coletor','Corrente de Emissor','Corrente na Fonte'}; % Primeira correta %TODO

% 
% q=q+1;
% quiz.question{q}.str='Qual a expressão da corrente média no resistor R3?';
% % quiz.question{q}.units={'A'};
% % quiz.question{q}.options={'\(\sqrt[a]{b+c}\)','\( \iint_{a}^{b}{c} \)','\( \left| \begin{matrix} a_1 & a_2 \ a_3 & a_4 \end{matrix} \right| \)','\( \mu \)','\( \iiint_{a}^{b}{c} \)'};
% quiz.question{q}.options={'Expr01','Expr02','Expr03','Expr04','Expr05'};
% quiz.question{q}.vartype={'string','string','string','string','string'}; % Expression
% quiz.question{q}.optscore=[100 50 75 0 0]; % Score per option
% % quiz.question{q}.opttol=[10 10 10 10 10]; % tolerance in percentage %
% quiz.question{q}.type='STRINGCHOICE_HS';

% MULTICHOICE
% MULTICHOICE_S


%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimdc2xml(circuit,quiz);
    end
else
    psimdc2xml(circuit,quiz);
end




