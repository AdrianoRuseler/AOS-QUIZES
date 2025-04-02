% clear all
clear circuit quiz
clc

% Config simulation
circuit.name = 'diode09'; % File name
circuit.parname={'Vi','Von','Vz1','Vz2','R1','R2','R3'}; % Variables names
circuit.parnamesim={'Vi','Von','Vz1','Vz2','R1','R2','R3'}; % Variables names
circuit.parunit={'V','V','V','V','&Omega;','&Omega;','&Omega;'}; % Variables unit

circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% parameters input
Vi=15:5:30; 
Von=1:0.05:3;
Vz2=[2.7 3.3 3.9 4.7 5.6  6.8  8.2];
Vz1=[ 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combnres(1,[10],'E24',6); %
R2 = combnres(1,[10],'E24',6); %
R3 = combnres(1,[10],'E24',6); %

circuit.Xi=CombVec(Vi,Von,Vz1,Vz2,R1,R2,R3); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

quiz.enunciado = ['Para o circuito contendo diodos zener com tensão de polarização direta Von'...
    ' e tensão de polarização reversa Vz1 e Vz2 apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
% quiz.extratext{1} = 'Segue uma ajuda para utilizar o <a href="https://youtu.be/YEEPUlJbcmg" target="_blank"> arquivo parâmetros </a>:';
% quiz.extratext{1} = 'Segue uma ajuda para utilizar o arquivo parâmetros:';
% quiz.printparfile = 1; % Imprimir arquivo de parâmetros

quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da tensão média Vx?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'Vx'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão média Vy?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'Vy'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente média no diodo zener Z1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IZ1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente média no diodo zener Z2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IZ2'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o valor da corrente média no resistor R2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IR2'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% quiz.question{6}.str='f) Qual o valor da corrente média no resistor R3?';
% quiz.question{6}.units={'A'};
% quiz.question{6}.options={'IR3'};
% quiz.question{6}.vartype={'mean'}; %
% quiz.question{6}.optscore=[100]; % Score per option
% quiz.question{6}.opttol=[10]; % tolerance in percentage %
% quiz.question{6}.type='NUMERICAL';


%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimdc2xml(circuit,quiz);
    end
else
    psimdc2xml(circuit,quiz);
end
