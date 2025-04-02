% clear all
clear circuit quiz
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'LarguraBanda'; % File name
circuit.dir = [pwd '\'];  % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','fi'}; % Variables names
circuit.parname={'Vs','fi'}; % Variables names
circuit.parunit={'V','Hz'}; % Variables unit

circuit.funcstr  = {'filter01func1(parvalues)','filter01func2(parvalues)','filter01func3(parvalues)','filter01func4(parvalues)','filter01func5(parvalues)'}; % Array of strings evalstr


% Avol=1Meg GBW=10Meg Slew=10Meg ilimit=25m rail=0 Vos=0 phimargin=45 en=0 enk=0 in=0 ink=0 Rin=500Meg
circuit.level.tipo = 'UniversalOpamp2';
circuit.level.varname={'Avol','GBW'};
circuit.level.varunit={'V/V','Hz'}; % Variables unit
circuit.level.lvlind = [3 4];
circuit.parind = [1 2];

% parameters input
Vs=15:5:20; 
% Vi=[-5:-1 1:5]; 
Avol=[1:10]*1e6;
GBW=[5:15]*1e5;
fi=(50:10:200)*1e3;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,fi,Avol,GBW); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

circuit.cmdtype = '.ac'; % AC analysis
circuit.cmdupdate = 0; % 

% % Generate question
quiz.enunciado = 'Para o circuito amplificador não-ideal com ganho DC Avol e largura de banda GBW, determine:';

% Text a ser colocado abaixo da figura
quiz.extratext{2} = 'Forma padronizada: \(H(s) = H_o\dfrac{1}{1+\dfrac{s}{ \omega_o }} \)';

quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor do ganho \(H_o\) em decibels?';
quiz.question{q}.units={'dB'};
quiz.question{q}.options={1}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da magnitude de  \(H(s)\) em decibels na frequência de corte?';
quiz.question{q}.units={'dB'};
quiz.question{q}.options={2}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da frequência de corte \(\omega_o\)?';
quiz.question{q}.units={'rad/s'};
quiz.question{q}.options={3}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da magnitude de \(H(s)\) em decibels na frequência fi?';
quiz.question{q}.units={'dB'};
quiz.question{q}.options={4}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da fase  de \(H(s)\) em graus na frequência fi?';
quiz.question{q}.units={'graus'};
quiz.question{q}.options={5}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


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


