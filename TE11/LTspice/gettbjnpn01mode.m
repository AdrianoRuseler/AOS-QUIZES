function [tbjmode,logdata]=gettbjnpn01mode(Xi)

% system(['XVIIx64.exe -Run -b -ascii -netlist ' circuit.dir circuit.name 'op.asc']); % Cria o arquivo .net
% winopen([circuit.dir circuit.name '.net'])

netlines{1}='* E:\Dropbox\UTFPR\ET74C\MATLAB\Q05\TBJ01CAop.asc';
netlines{2}='Rb cc B {Rb}';
netlines{3}='Rc cc C {Rc}';
netlines{4}='Vcc cc 0 {Vcc}';
netlines{5}='Q1 C B 0 0 TBJ';
netlines{6}='.model NPN NPN';
netlines{7}='.model PNP PNP';
netlines{8}='.lib standard.bjt';
netlines{9}='.param Vcc=15 Rb=62000 Rc=620';
netlines{10}='.op';
netlines{11}='.model TBJ NPN(BF=50)';
netlines{12}='.backanno';
netlines{13}='.end';

% Select 
[~,y]=size(Xi);
tbjmode=zeros(y,1);
for z=1:y
    % % Xi=CombVec(Vcc,Rc,Rr,Cr,Beta,Tf,Tr); %% %%
    paramstr = ['.param Vcc=' num2str(Xi(1,z)) ' Rb=' num2str(Xi(3,z)) ' Rc=' num2str(Xi(2,z))];
    netlines{9}=paramstr; % Updates param line from net file
    modelstr=['.model TBJ NPN(BF=' num2str(Xi(5,z)) ')'];
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
