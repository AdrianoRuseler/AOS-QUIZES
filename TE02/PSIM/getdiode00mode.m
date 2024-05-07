function [circuitmode]=getdiode00mode(Xi)
% 0 -> All Off
% 1 -> Zener Off
% 2 -> Zener On
% 3 -> All on


% Select
[~,y]=size(Xi);
circuitmode=zeros(y,1);

for z=1:y
    %  Xi=CombVec(Vi,Von,Vz,Vled,R1,R2);%%
    Vi=Xi(1,z); % R
    Von=Xi(2,z); % R
    Vz=Xi(3,z); % R
    Vled=Xi(4,z); % R
    R1=Xi(5,z);
    R2=Xi(6,z);

    if (Vi-Von-Vled) >=0
        circuitmode(z)=1;
        i1=(Vi-Von-Vled)/(R1+R2); % Zener off
    else
        i1=0;
    end

    if (Vi-Vz-Von-R1*i1)>=0
        circuitmode(z)=2; % Zener on
    end
end

