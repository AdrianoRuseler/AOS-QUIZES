function [circuitmode]=getcomb07mode(Xi)
% 0 -> indefinido
% 1 -> ohm sat
% 2 -> ohm ativo
% 3 -> sat sat
% 4 -> sat ativo


Vcesat=1; 
Vbe=0.7;

% Select
[~,y]=size(Xi);
circuitmode=zeros(y,1);

for z=1:y
    %  Xi=CombVec(Vi,Vs,R1,R2,RL,Beta,Vto,IS,BF); 
    Vi=Xi(1,z); %  
    Vs=Xi(2,z); %  
    R1=Xi(3,z); %  
    R2=Xi(4,z); %  
    RL=Xi(5,z);
    Beta=Xi(6,z);
%     Vto=Xi(7,z);
%     IS=Xi(8,z);
    BF=Xi(9,z);

    Vce=Vs+(1+RL/R1)*Vi;
    Ib=(-Vi/R1-Vbe/R2)/(BF+1);
    Id=Ib+Vbe/R2;
    Vdssat=sqrt(Id/Beta);
    Vds=Vce-Vbe;


    if Vce > Vcesat % TBJ
        circuitmode(z)=2; % ativo
    else
        circuitmode(z)=1; % sat
    end

    if Vds > Vdssat % FET
        circuitmode(z)=circuitmode(z)+2; % sat
%     else
%         circuitmode(z)=1; % ohm
    end


end
