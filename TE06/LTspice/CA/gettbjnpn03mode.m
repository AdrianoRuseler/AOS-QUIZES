function [tbjmode,logdata]=gettbjnpn03mode(Xi)

% system(['XVIIx64.exe -Run -b -ascii -netlist ' circuit.dir circuit.name 'op.asc']); % Cria o arquivo .net
% winopen([circuit.dir circuit.name 'op.net'])

netlines{1}='* E:\Dropbox\UTFPR\ET74C\MATLAB\Q05\TBJ03CAop.asc';
netlines{2}='Rb C B {RB}';
netlines{3}='Vcc C 0 {Vcc}';
netlines{4}='Q1 C B P001 0 TBJ';
netlines{5}='RE P001 0 {RE}';
netlines{6}='.model NPN NPN';
netlines{7}='.model PNP PNP';
% netlines{8}='.lib C:\Users\Ruseler\Documents\LTspiceXVII\lib\cmp\standard.bjt';
netlines{8}='.lib C:\Users\ruseler\AppData\Local\LTspice\lib\cmp\standard.bjt';
netlines{9}='..param Vcc=30 RB=820k RE=220';
netlines{10}='.op';
netlines{11}='.model TBJ NPN(IS=1e-14 BF=50 VAF=200)';
netlines{12}='.backanno';
netlines{13}='.end';

% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);
for z=1:y
    %  X0=CombVec(Vcc,Rb,Re,Cx,Is,Beta,Va); %%
    paramstr = ['.param Vcc=' num2str(Xi(1,z)) ' Rb=' num2str(Xi(2,z)) ' Re=' num2str(Xi(3,z)) ' Cx=' num2str(Xi(4,z))];
    netlines{9}=paramstr; % Updates param line from net file
    modelstr=['.model TBJ NPN(IS=' num2str(Xi(5,z)) ' BF=' num2str(Xi(6,z)) ' VAF=' num2str(Xi(7,z)) ')'];
    netlines{11}=modelstr; % Updates param line from net file
    [netfiles{z},logfiles{z},rawfiles{z}] = writenetfile(netlines);
end

parfor z=1:y
    system(['LTspice -Run -b -ascii ' netfiles{z}]); % Simula o circuito
end

for z=1:y
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
