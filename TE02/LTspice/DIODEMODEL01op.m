clear all
clc

circuit.name = 'DIODEMODEL01op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R0','Td'}; % Variables names
circuit.parname={'Vcc','R0','Td'}; % Variables names
circuit.parunit={'V','&Omega;','ºC'}; % Variables unit

circuit.funcstr  = {'diode01func1(parvalues)'}; % Array of strings evalstr

% parameters input
Vcc=10:5:30; 
Td=25:5:50;

% Rg = combres(1,100000,'E12'); %
R0 = combnres(1,10,'E24'); %

Is1=[5:15]*1e-12;
n1=1:0.1:1.5;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,R0,Td,Is1,n1); %%
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=[1:3];
circuit.modind(1,:)=[4:5]; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='D0'; % for .model 
circuit.model(1).tipo='D'; % for .model 


circuit.model(1).parnamesim={'Is','n'};
circuit.model(1).parname={'Is','n'};
circuit.model(1).parunit={'A',''};

% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;

% Generate question
quiz.enunciado = 'Simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

q=0;
q=q+1;
quiz.question{q}.str='Qual a tensão Vd do diodo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'d0:Vd'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual a corrente Id do diodo?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'d0:Id'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da resistência Ron do modelo linear do diodo?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'d0:Req'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor de nVT?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={1}; % Only lowcase
% quiz.question{q}.vartype={'func'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Vfwd do modelo linear do diodo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'von'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% 
% quiz.question{q}.str='Qual o valor da corrente no diodo zener DZ1?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'ID1'};
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente no diodo zener DZ2?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'ID2'};
% quiz.question{q}.vartype={'op'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da tensão no diodo zener DZ1?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vz1'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da tensão no diodo zener DZ2?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vz2'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
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


