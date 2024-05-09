function [tbjmode,logdata,paramstr,modelstr]=gettbjnpn02mode(Xi)

% system(['XVIIx64.exe -Run -b -ascii -netlist ' circuit.dir circuit.name 'op.asc']); % Cria o arquivo .net
% winopen([circuit.dir circuit.name 'op.net'])

netlines{1}='* E:\Dropbox\UTFPR\ET74C\MATLAB\Q05\TBJ02CAop.asc';
netlines{2}='R1 cc B {R1}';
netlines{3}='Rc cc C {RC}';
netlines{4}='Vcc cc 0 {Vcc}';
netlines{5}='Q1 C B P001 0 TBJ';
netlines{6}='RE P001 0 {RE}';
netlines{7}='R2 B 0 {R2}';
netlines{8}='.model NPN NPN';
netlines{9}='.model PNP PNP';
% netlines{10}='.lib C:\Users\Ruseler\Documents\LTspiceXVII\lib\cmp\standard.bjt';
netlines{8}='.lib C:\Users\ruseler\AppData\Local\LTspice\lib\cmp\standard.bjt';
netlines{11}='.param Vcc=15 Rb=62000 Rc=620 Cx=0.0001';
netlines{12}='.op';
netlines{13}='.model TBJ NPN(IS=1e-14 BF=50 VAF=200)';
netlines{14}='.backanno';
netlines{15}='.end';

% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);
for z=1:y
    %  X0=CombVec(Vcc,R1,R2,Rc,Re,Cx,Is,Beta,Va); %%
    paramstr{z} = ['.param Vcc=' num2str(Xi(1,z)) ' R1=' num2str(Xi(2,z)) ' R2=' num2str(Xi(3,z)) ' Rc=' num2str(Xi(4,z)) ' Re=' num2str(Xi(5,z)) ' Cx=' num2str(Xi(6,z))];
    netlines{11}=paramstr{z}; % Updates param line from net file
    modelstr{z}=['.model TBJ NPN(IS=' num2str(Xi(7,z)) ' BF=' num2str(Xi(8,z)) ' VAF=' num2str(Xi(9,z)) ')'];
    netlines{13}=modelstr{z}; % Updates param line from net file
    tmpname{z}=char(mlreportgen.utils.hash([paramstr{z} ' ' modelstr{z}]));
    [netfiles{z},logfiles{z},rawfiles{z}] = writenetfile(netlines,tmpname{z});
end

parfor z=1:y % parfor embaralha os valores.
    system(['LTspice -Run -b -ascii ' netfiles{z}]); % Simula o circuito
end

for z=1:y % parfor embaralha os valores.
    logdata{z} = getnetopdata(logfiles{z});
    if (logdata{z}{1}.Vbc)>=0 % Saturação
        tbjmode(z)=2;
    else
        tbjmode(z)=3;% Região ativa  
    end
end
  
for z=1:y
    delete(netfiles{z})
    delete(logfiles{z})
    delete(rawfiles{z})
end
