clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'DIODEMODEL02op'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R0'}; % Variables names
circuit.parname={'Vcc','R0'}; % Variables names
circuit.parunit={'V','&Omega;'}; % Variables unit

circuit.funcstr  = {'diode02func1(parvalues)'}; % Array of strings evalstr

% parameters input
Vcc=10:5:20; 
R0 = combnres(1,10,'E24',5); %

% .MODEL DI_10A04 D  ( IS=844n RS=2.06m BV=400 IBV=10.0u
% + CJO=277p  M=0.333 N=2.06 TT=4.32u )

% Name Description Units Default Example 
% Is  saturation current  A  1e-14 1e-7 
% Rs  Ohmic resistance     0.0  10. 
% N  Emission coefficient  -  1.0  1.0 
% Tt  Transit-time  sec  0.0  2n 
% Cjo  Zero-bias junction cap.  F  0.0  2p 
% M  Grading coefficient  -  0.5  0.5 
% BV  Reverse breakdown voltage  V  Infin. 40. 
% Ibv  Current at breakdown voltage  A  1e-10   

Is1=combnres(1,1e-9,'E192',5); 
n1=combnres(1,1e-2,'E192',5);
Rs1=combnres(1,1e-4,'E192',5);
tt1=combnres(1,1e-8,'E192',5);
cjo1=combnres(1,1e-13,'E192',5);
m1=combnres(1,1e-3,'E192',5);
bv1=[50:25:150];
ibv1=[5:10]*1e-6;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,R0,Is1,n1,Rs1,tt1,cjo1,m1,bv1,ibv1); %%
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

circuit.parind=[1:2];
circuit.modind(1,:)=[3:10]; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='D0'; % for .model 
circuit.model(1).tipo='D'; % for .model 

circuit.model(1).parnamesim={'Is','n','Rs','TT','CJO','M','BV','IBV'};
circuit.model(1).parname={'Is','n','Rs','TT','CJO','M','BV','IBV'};
circuit.model(1).parunit={'A','','&Omega;','s','F','','V','A'};

% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;

% Generate question
quiz.enunciado = 'Utilize o arquivo fornecido com o modelo do diodo, simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.modelfile=1; % Add link to model file

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

% q=q+1;
% quiz.question{q}.str='Qual o valor da resistência Ron do modelo linear do diodo?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'d0:Req'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% % q=q+1;
% % quiz.question{q}.str='Qual o valor de nVT?';
% % quiz.question{q}.units={'V'};
% % quiz.question{q}.options={1}; % Only lowcase
% % quiz.question{q}.vartype={'func'}; % meas 
% % quiz.question{q}.optscore=[100]; % Score per option
% % quiz.question{q}.opttol=[5]; % tolerance in percentage %
% % quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da tensão Vfwd do modelo linear do diodo?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'von'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

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


