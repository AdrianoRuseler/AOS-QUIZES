function [tbjmode,logdata,logfiles]=gettbjpnp01mode(Xi)

% system(['LTspice -Run -b -ascii -netlist ' circuit.dir circuit.name 'op.asc']); % Cria o arquivo .net
% winopen([circuit.dir circuit.name '.net'])

netlines{1}='* E:\Dropbox\UTFPR\ET74C\MATLAB\Q04\TBJPNP01CAop.asc';
netlines{2}='Rb B 0 {Rb}';
netlines{3}='Rc C 0 {Rc}';
netlines{4}='Vcc cc 0 {Vcc}';
netlines{5}='Q1 C B cc 0 TBJ';
netlines{6}='.model NPN NPN';
netlines{7}='.model PNP PNP';
% netlines{8}='.lib C:\Users\Ruseler\Documents\LTspiceXVII\lib\cmp\standard.bjt';
netlines{8}='* .lib C:\Users\Ruseler\OneDrive - utfpr.edu.br\Documentos\LTspiceXVII\lib\cmp\standard.bjt';
netlines{9}='.param Vcc=15 Rb=62000 Rc=620 Cx=0.0001';
netlines{10}='.op';
netlines{11}='.model TBJ PNP(IS=1e-14 BF=50 VAF=200)';
netlines{12}='.backanno';
netlines{13}='.end';

% Fatal Error: Could not open library file "C:\Users\Ruseler\Documents\LTspiceXVII\lib\cmp\standard.bjt"
% C:\Users\Ruseler\OneDrive - utfpr.edu.br\Documentos\LTspiceXVII\lib\cmp

% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);
for z=1:y
    %  Xi=CombVec(Vcc,Rb,Rc,Cx,Is,Beta,Va); %%
    paramstr = ['.param Vcc=' num2str(Xi(1,z)) ' Rb=' num2str(Xi(2,z)) ' Rc=' num2str(Xi(3,z)) ];
    netlines{9}=paramstr; % Updates param line from net file
    modelstr=['.model TBJ PNP(IS=' num2str(Xi(4,z)) ' BF=' num2str(Xi(5,z)) ' VAF=' num2str(Xi(6,z)) ')'];
    netlines{11}=modelstr; % Updates param line from net file
    [netfiles{z},logfiles{z},rawfiles{z}] = writenetfile(netlines);
end

parfor z=1:y
    system(['LTspice -Run -b -ascii ' netfiles{z}]); % Simula o circuito
end

for z=1:y
    logdata{z} = getnetopdata(logfiles{z});
    if (logdata{z}{1}.Vbc)<0 
        tbjmode(z)=2; % Saturação
    else
        tbjmode(z)=3;% Região ativa  
    end
end
  
% for z=1:y
%     delete(netfiles{z})
%     delete(logfiles{z})
%     delete(rawfiles{z})
% end
