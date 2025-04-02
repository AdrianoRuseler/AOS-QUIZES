% clear all
clear circuit quiz
clc

% Config simulation
circuit.name = 'diode02'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

circuit.parname={'Vi','Von','Vz','R1','R2'}; % Variables names
circuit.parnamesim={'Vi','Von','Vz','R1','R2'}; % Variables names
circuit.parunit={'V','V','V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vi=15:5:30; 
Von=0.4:0.05:0.8;
Vz=[2.7 3.0 3.3 3.6 3.9 4.3 4.7 5.1 5.6 6.2 6.8 7.5 8.2 9.1];
R1 = combnres(1,[1],'E24',12); %
R2 = combnres(1,[10],'E24',12); %
% R3 = combres(1,[100],'E24'); %
circuit.Xi=CombVec(Vi,Von,Vz,R1,R2); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

% Generate question
quiz.enunciado = ['Para o circuito contendo diodos com tensão de polarização direta Von'...
    ' e um zener com tensão de polarização reversa Vz apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  
% https://www.tutorialspoint.com/latex_equation_editor.htm
quiz.exptable=0; % Cria tabela para responder com expressão matemática

q=0;
q=q+1;
quiz.question{q}.str='Qual a corrente no resistor R1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IR1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a corrente no diodo zener Z1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IZ1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a corrente no resistor R2?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IR2'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a tensão sobre o resistor R2 (Vx)?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'Vx'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a potência dissipada no diodo zener Z1?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'pd'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimdc2xml(circuit,quiz);
    end
else
    psimdc2xml(circuit,quiz);
end