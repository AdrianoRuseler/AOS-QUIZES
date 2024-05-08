function [tbjmode,logdata,logfiles]=gettbjpnp05mode(Xi)

% system(['LTspice -Run -b -ascii -netlist TBJPNP05CAop.asc']); % Cria o arquivo .net
% winopen([circuit.dir circuit.name 'op.net'])

netlines{1}='* E:\Dropbox\UTFPR\ET74C\MATLAB\Q04\TBJPNP05CAop.asc';
netlines{2}='R1 B 0 {R1}';
netlines{3}='Rc C 0 {RC}';
netlines{4}='Vcc cc 0 {Vcc}';
netlines{5}='RE cc N001 {RE}';
netlines{6}='R2 cc B {R2}';
netlines{7}='Q1 C B N001 0 PNP';
netlines{8}='.model NPN NPN';
netlines{9}='.model PNP PNP';
netlines{8}='.lib C:\Users\ruseler\AppData\Local\LTspice\lib\cmp\standard.bjt';
netlines{11}='.param Vcc=30 R1=820k R2=560k RC=680 RE=220';
netlines{12}='.op';
netlines{13}='.model TBJ PNP(IS=10F BF=350 VAF=100)';
netlines{14}='.backanno';
netlines{15}='.end';

% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);
for z=1:y
    %  X0=CombVec(Vcc,R1,R2,Rc,Re,Cx,Is,Beta,Va); %%
    paramstr = ['.param Vcc=' num2str(Xi(1,z)) ' R1=' num2str(Xi(2,z)) ' R2=' num2str(Xi(3,z)) ' Rc=' num2str(Xi(4,z)) ' Re=' num2str(Xi(5,z))];
    netlines{11}=paramstr; % Updates param line from net file
    modelstr=['.model TBJ PNP(IS=' num2str(Xi(6,z)) ' BF=' num2str(Xi(7,z)) ' VAF=' num2str(Xi(8,z)) ')'];
    netlines{13}=modelstr; % Updates param line from net file
    [netfiles{z},logfiles{z},rawfiles{z}] = writenetfile(netlines);
end

parfor z=1:y
    system(['LTspice -Run -b -ascii ' netfiles{z}]); % Simula o circuito
end

for z=1:y
    logdata{z} = getnetopdata(logfiles{z});
    if (logdata{z}{1}.Vbc)<0 % Saturação
        tbjmode(z)=2;
    else
        tbjmode(z)=3;% Região ativa  
    end
end
  
% for z=1:y
%     delete(netfiles{z})
%     delete(logfiles{z})
%     delete(rawfiles{z})
% end
