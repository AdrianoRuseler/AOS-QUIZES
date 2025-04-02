% clear all
clear circuit quiz
clc

% Config simulation
circuit.name = 'diode01'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

circuit.parname={'Vi','Von1','Von2','Von3','R1'}; % Variables names
circuit.parnamesim={'Vi','Von1','Von2','Von3','R1'}; % Variables names
circuit.parunit={'V','V','V','V','&Omega;'}; % Variables unit
circuit.mode=2; % 0->"All OFF", 1->"D1 OFF", 2->"D2 OFF",3->"All ON"

switch circuit.mode
    case 0
        disp("All OFF")
        %parameters input
        Vi=1:0.05:3;
        Von1=1:0.05:2;
        Von2=1:0.05:2;
        Von3=2:0.25:5;
    case 1
        disp("D1 OFF")
        %parameters input
        Vi=10:5:30;
        Von1=0.4:0.05:0.8;
        Von2=0.4:0.05:0.8;
        Von3=1:0.25:5;
    case 2
        disp("D2 OFF")
        %parameters input
        Vi=10:5:30;
        Von1=0.4:0.05:0.8;
        Von2=0.4:0.05:0.8;
        Von3=1:0.25:5;
    case 3
        disp("All ON")
        %parameters input
        Vi=10:5:30;
        Von1=0.4:0.05:0.8;
        Von2=0.4:0.05:0.8;
        Von3=1:0.25:5;
    otherwise
        disp('Other Mode')
end


%parameters input
% Vi=10:5:30; 
% Von1=0.4:0.05:0.8;
% Von2=0.4:0.05:0.8;
% Von3=1:0.25:5;
R1 = combnres(1,10,'E24',12); %

X0=CombVec(Vi,Von1,Von2,Von3,R1); %%

% [mode]=getdiode01mode(X0);
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados
% circuit.PSIMCMD.script.run=0;

[~,y]=size(X0);
nq=randperm(y,3*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

[mode]=getdiode01mode(Xi);
% Mostra estatítica de modos encontrados
Tmode = table(sum(mode(:)==0),sum(mode(:)==1),sum(mode(:)==2),sum(mode(:)==3));
Tmode.Properties.VariableNames = ["All OFF","D1 OFF","D2 OFF","All ON"];
disp(Tmode)

indx=find(mode==circuit.mode); % 0->"All OFF", 1->"D1 OFF", 2->"D2 OFF",3->"All ON"
circuit.Xi=Xi(:,indx);


% circuit.fundfreqind=2; % 
% circuit.cycles = 10; % Total number of cycles
% circuit.printcycle = 8; % Cycle to start print

% Generate question

quiz.enunciado = 'Para o circuito apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  
% quiz.scriptfile=1; % Add link to script file
% https://www.tutorialspoint.com/latex_equation_editor.htm
quiz.exptable=1; % Cria tabela para responder com expressão matemática

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor médio da corrente no diodo D1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ID1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
switch circuit.mode
    case 0 % disp("All OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 1 % disp("D1 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 2 % disp("D2 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 3 % disp("All ON")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    otherwise %  disp('Other Mode')
end
quiz.question{q}.expopts={'Corrente no diodo D1','Corrente no resitor R1','Corrente no diodo D2','Corrente no LED'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor médio da corrente no diodo D2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ID2'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
switch circuit.mode
    case 0 % disp("All OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 1 % disp("D1 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 2 % disp("D2 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 3 % disp("All ON")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    otherwise %  disp('Other Mode')
end
quiz.question{q}.expopts={'Corrente no diodo D2','Corrente no diodo D1','Corrente no LED','Corrente no resitor R1'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor médio da corrente no LED?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ILED1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
switch circuit.mode
    case 0 % disp("All OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 1 % disp("D1 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 2 % disp("D2 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 3 % disp("All ON")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    otherwise %  disp('Other Mode')
end
quiz.question{q}.expopts={'Corrente no LED','Corrente no diodo D1','Corrente no resitor R1','Corrente no diodo D2'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor médio da tensão no resistor R1?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'VR1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
switch circuit.mode
    case 0 % disp("All OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 1 % disp("D1 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 2 % disp("D2 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 3 % disp("All ON")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    otherwise %  disp('Other Mode')
end
quiz.question{q}.expopts={'Tensão no resitor R1','Tensão no diodo D1','Tensão no diodo LED','Tensão no diodo D2'}; % Primeira correta %TODO

q=q+1;
quiz.question{q}.str='Qual o valor da potência dissipada no LED?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'pd'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
switch circuit.mode
    case 0 % disp("All OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 1 % disp("D1 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 2 % disp("D2 OFF")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    case 3 % disp("All ON")
        quiz.question{q}.expmath='\( \frac{V_{CC}-V_{BE}}{R_B} \)'; %TODO
    otherwise %  disp('Other Mode')
end
quiz.question{q}.expopts={'Potência no LED','Potência no diodo D1','Potência no resitor R1','Potência no diodo D2'}; % Primeira correta %TODO



%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        circuits=psimdc2xml(circuit,quiz);
    end
else
    circuits=psimdc2xml(circuit,quiz);
end


%% Generate Report

% opts.printtable=1; % Print data table
% opts.rmtrace = {'values','meanround','dimensions','title','plotStyle'}; % Remove Fields from table
% opts.printploty=1; % Print Ploty
% opts.visible={}; % Visible traces
% opts.printsimctrl=1;
% 
% circuits2html(circuits,opts)


