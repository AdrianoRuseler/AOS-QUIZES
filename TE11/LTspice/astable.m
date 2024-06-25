clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'astable'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','Rc','Rr','Cr'}; % Variables names
circuit.parname={'Vcc','Rc','Rr','Cr'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','F'}; % Variables unit

circuit.funcstr  = {'astablefunc1(parvalues)','astablefunc2(parvalues)'}; % Array of strings evalstr

% parameters input
Vcc=10:5:25; 
% Vi=15:5:20; 

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
% R0 = combnres(1,100,'E24',12);
Rc = combnres(1,100,'E24',12);
Rr = combnres(1,1000,'E24',12);
Cr = combnres(1,1e-8,'E24',12);


% .model TBJ NPN(BF=200 TR=100E-9 TF=400E-12)
Beta=250:25:500;
Tf=(100:50:400)*1e-10;
Tr=(100:50:400)*1e-10;

X0=CombVec(Vcc,Rc,Rr,Cr,Beta,Tf,Tr); %%
circuit.timeout = 50; % Simulation timeout in seconds
% circuit.multiplesims=[50 50 25]; % Number of simulations
circuit.nsims = 16; % Numero de circuitos a serem simulados

[~,y]=size(X0);
nq=randperm(y,3*circuit.nsims); % escolha as questoes
Xi=X0(:,nq);

% Xi=CombVec(Vcc,Rc,Rr,Cr,Beta,Tf,Tr); %%
[tbjmode,logdata]=gettbjnpn01mode(Xi);
indx=find(tbjmode==2); % 2 - Saturação; 3 - Região ativa;
circuit.Xi=Xi(:,indx);

circuit.parind=[1 2 3 4]; % Index for circuit parameters
circuit.modind(1,:)=[5 6 7]; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='TBJ';
circuit.model(1).tipo='NPN';
circuit.model(1).parnamesim={'BF','TF','TR'};
circuit.model(1).parname={'BF','TF','TR'};
circuit.model(1).parunit={'','s','s'};
quiz.tbjtype='q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op
quiz.requiremeas=1; % Require meas field in log 

circuit.cmdtype = '.tran'; % Operation Point Simulation
circuit.cmdupdate = 0; % 
% circuit.cmdvarind
% 
% quiz.tbjtype = 'q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op
% % Generate question
quiz.enunciado = 'Para o circuito oscilador astável com TBJ apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

quiz.modelfile=0;

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo
q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da duração do nível alto na saída?';
quiz.question{q}.units={'s'};
quiz.question{q}.options={'th'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da relação \( t_H = ln(2)R_r C_r \)?'; % out = log(2)*(RA+RB)*CA; % tH
quiz.question{q}.units={'s'};
quiz.question{q}.options={1}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da duração do nível baixo na saída?';
% quiz.question{q}.units={'s'};
% quiz.question{q}.options={'tl'}; % Only lowcase
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da relação \( t_L = ln(2) R_B C_A \)?'; % out = log(2)*(RB)*CA; % tL
% quiz.question{q}.units={'s'};
% quiz.question{q}.options={2}; % Only lowcase
% quiz.question{q}.vartype={'func'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da frequência de oscilação?';
quiz.question{q}.units={'Hz'};
quiz.question{q}.options={'fosc'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da relação \( f_{OSC} = \dfrac{1}{2 ln(2) R_r C_r}\)?'; % out = 1/(log(2)*(RA+2*RB)*CA); % freq.
quiz.question{q}.units={'Hz'};
quiz.question{q}.options={2}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';



% q=q+1;
% quiz.question{q}.str='Qual o valor de comparação V+ para Vo positivo?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vx'}; % Only lowcase
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor de comparação V+ para Vo negativo?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vy'}; % Only lowcase
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da relação \( \dfrac{V_s R_1}{R_1+R_2} \)?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={2}; % Only lowcase
% quiz.question{q}.vartype={'func'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


% q=q+1;
% quiz.question{q}.str='Qual o valor da frequência de oscilação?';
% quiz.question{q}.units={'Hz'};
% quiz.question{q}.options={'fosc'}; % Only lowcase
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da relação \( \dfrac{-1}{2 R_0 C_0 ln(\frac{R_2}{2 R_1+R_2}) } \)?';
% quiz.question{q}.units={'Hz'};
% quiz.question{q}.options={1}; % Only lowcase
% quiz.question{q}.vartype={'func'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=2;
% quiz.question{q}.str='b) Qual o valor da impedância de saída Zo?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'zo'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=3;
% quiz.question{q}.str='c) Qual o valor do ganho de tensão vo/vi?';
% quiz.question{q}.units={'V/V'};
% quiz.question{q}.options={'av'};
% quiz.question{q}.vartype={'meas'}; % meas 
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



