function [circuitmode]=getcomb08mode(Xi)
% 0 -> indefinido
% 1 -> sat
% 2 -> ativo

Vcesat=0.5; 
Vbe=0.7;

% Select
[~,y]=size(Xi);
circuitmode=zeros(y,1);

for z=1:y
    %  Xi=CombVec(Vi,Vs,R1,R2,RL,Rs,IS,BF);
    Vi=Xi(1,z); %  
    Vs=Xi(2,z); %  
    R1=Xi(3,z); %  
    R2=Xi(4,z); %  
    RL=Xi(5,z);
    Rs=Xi(6,z);
%     IS=Xi(7,z);
    BF=Xi(8,z);

    Ie=Vi*R2/(Rs*(R1+R2));
    Ib=Ie/(BF+1);
    Ic=BF*Ib;
    Vce=Vs-RL*Ic-Rs*Ie;
    
    if Vce > Vcesat % TBJ
        circuitmode(z)=2; % ativo
    else
        circuitmode(z)=1; % sat
    end

end
