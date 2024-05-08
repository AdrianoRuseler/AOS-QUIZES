function [tbjmode,logdata,logfiles]=gettbjpnp02mode(Xi)

% system(['LTspice -Run -b -ascii -netlist TBJPNP02CAop.asc']); % Cria o arquivo .net
% winopen([circuit.dir circuit.name 'op.net'])

% X0=CombVec(Vcc,Rb,Rc,Re,Is,Beta,Va); %%
netlines{1}='* E:\Dropbox\UTFPR\ET74C\MATLAB\Q04\TBJPNP02CAop.asc';
netlines{2}='Rb B 0 {RB}';
netlines{3}='Rc C 0 {RC}';
netlines{4}='Vcc cc 0 {Vcc}';
netlines{5}='RE cc N001 {RE}';
netlines{6}='Q1 C B N001 0 TBJ';
% netlines{7}='R2 B 0 {R2}';
netlines{7}='.model NPN NPN';
netlines{8}='.model PNP PNP';
% netlines{10}='.lib C:\Users\Ruseler\Documents\LTspiceXVII\lib\cmp\standard.bjt';
netlines{8}='.lib C:\Users\ruseler\AppData\Local\LTspice\lib\cmp\standard.bjt';
netlines{9}='.param Vcc=30 RB=820k RC=680 RE=220';
netlines{10}='.op';
netlines{11}='.model TBJ PNP(IS=10F BF=350 VAF=100)';
netlines{12}='.backanno';
netlines{13}='.end';

% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);
for z=1:y
    %  X0=CombVec(Vcc,R1,R2,Rc,Re,Cx,Is,Beta,Va); %%
    paramstr = ['.param Vcc=' num2str(Xi(1,z)) ' RB=' num2str(Xi(2,z)) ' RC=' num2str(Xi(3,z)) ' RE=' num2str(Xi(4,z))];
    netlines{9}=paramstr; % Updates param line from net file
    modelstr=['.model TBJ PNP(IS=' num2str(Xi(5,z)) ' BF=' num2str(Xi(6,z)) ' VAF=' num2str(Xi(7,z)) ')'];
    netlines{11}=modelstr; % Updates param line from net file
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
