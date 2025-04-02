% clear all
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

Xi=CombVec(Vi,Von,Vz,Vled,R1,R2);
[circuitmode]=getdiode00mode(Xi);
indx=find(circuitmode==2); % 0 -> All Off; 1 -> Zener Off; 2 -> Zener On
circuit.Xi=Xi(:,indx);

% circuit.Xi=CombVec(Vi,Von,Vz,Vled,R1,R2); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 32; % Numero de circuitos a serem simulados

% Generate question

quiz.enunciado = ['Para o circuito contendo um diodo e um diodo zener com tensões de polarização direta Von'...
    ', o zener com tensão de polarização reversa Vz e um diodo LED de tensão direta Vled apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  
% quiz.incfrom=0; % Increment from

% https://www.tutorialspoint.com/latex_equation_editor.htm
quiz.eqlist{1}='\( \sqrt{\frac{I_{pk1}^{2}+I_{pk3}^{2}+I_{pk5}^{2}}{2}} \)'; % valor eficaz da corrente de carga?
quiz.eqlist{2}='\(  \sqrt{\frac{I_{pk3}^{2}+I_{pk5}^{2}}{2}} \)'; % Qual o valor eficaz dos harmônicos de corrente de carga?
quiz.eqlist{3}='\( \sqrt{\frac{I_{pk1}^{2}}{2}} \)';  % Qual o valor eficaz da fundamental de corrente de carga?
quiz.eqlist{4}='\( \sqrt{\frac{I_{pk3}^{2}+I_{pk5}^{2}}{I_{pk1}^{2}}} \)'; % Qual o valor da THD de corrente na fonte?
quiz.eqlist{5}='\( \sqrt{\frac{V_{pk3}^{2}}{2}} \)'; % valor eficaz dos harmônicos de tensão na fonte?
quiz.eqlist{6}='\( \sqrt{\frac{V_{pk1}^{2}+V_{pk3}^{2}}{2}}  \)'; % valor eficaz da tensão na fonte?
quiz.eqlist{7}='\( \sqrt{\frac{V_{pk1}^{2}}{2}} \)';
% 
quiz.eqnum={'A','B','C','D','E','F','G'};
quiz.vartype={'str','str','str','str','str','str','str'};

q=0;
q=q+1;
%% TODO
quiz.question{q}.str='Qual equação calcula o valor da corrente média no resistor R1?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options=quiz.eqnum; % Only lowcase
quiz.question{q}.vartype=quiz.vartype; % meas 
quiz.question{q}.optscore=[100 0 0 0 0 0 0]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='STRING'; 


q=q+1;
quiz.question{q}.str='Qual o valor da corrente média no resistor R1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IR1'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão média no resistor R2?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'VR2'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o valor da corrente média no diodo zener Z1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'Iz'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da potência média no diodo zener Z1?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'Pz'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

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




%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimdc2xml(circuit,quiz);
    end
else
    psimdc2xml(circuit,quiz);
end




