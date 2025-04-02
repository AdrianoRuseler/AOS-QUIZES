% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'Amp05op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','V1','R1','R2','RL'}; % Variables names
circuit.parname={'Vs','V1','R1','R2','RL'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vs=20:5:30; 
V1=[3:4]; 

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combnres(1,1000,'E24',6);
R2 = combnres(1,1000,'E24',6);
RL = combnres(1,1000,'E24',6);

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,V1,R1,R2,RL); %%
circuit.timeout = 5; % Simulation timeout in seconds
% circuit.multiplesims=[50 50 50]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % 

% % Generate question
quiz.enunciado = 'Para o circuito amplificador apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo
quiz.eqlist{1}='\( \dfrac{R_2}{R_1}\)';
quiz.eqlist{2}='\( -\dfrac{R_2}{R_1}V_1\)';
quiz.eqlist{3}='\( \dfrac{R_2}{R_1}V_1\)';
quiz.eqlist{4}='\( \left( 1+\dfrac{R_1}{R_2} \right )\)';
quiz.eqlist{5}='\( \dfrac{R_2V_1}{R_1(R_1+R_2)}\)';
quiz.eqlist{6}='\( \dfrac{R_1}{R_2}\)';
quiz.eqlist{7}='\( \dfrac{R_1V_1}{R_2(R_1+R_2)}\)';

quiz.eqnum={'A','B','C','D','E','F','G'};
quiz.vartype={'str','str','str','str','str','str','str'};

q=0;
q=q+1;
quiz.question{q}.str='Qual equação calcula o valor de Vo?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options=quiz.eqnum; % Only lowcase
quiz.question{q}.vartype=quiz.vartype; % meas 
quiz.question{q}.optscore=[0 0 100 0 0 0 0]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor de Vo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual equação calcula o valor do ganho de tensão Vo/Vi?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options=quiz.eqnum; % Only lowcase
quiz.question{q}.vartype=quiz.vartype; % meas 
quiz.question{q}.optscore=[100 0 0 0 0 0 0]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor do ganho de tensão Vo/Vi?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options={'g'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual equação calcula o valor corrente em R1?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options=quiz.eqnum; % Only lowcase
quiz.question{q}.vartype=quiz.vartype; % meas 
quiz.question{q}.optscore=[0 0 0 0 100 0 0]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='STRING'; 

q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir1'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente em R2?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'ir2'}; % Only lowcase
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente em R3?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'ir3'}; % Only lowcase
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente em R4?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'ir4'}; % Only lowcase
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


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


