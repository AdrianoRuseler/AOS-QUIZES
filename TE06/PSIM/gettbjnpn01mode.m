function [tbjmode]=gettbjnpn01mode(Xi)



% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);

for z=1:y
    %     CombVec(Vcc,Rb,Rc,Beta,Vbe,Vcesat); %%
    Vcc=Xi(1,z); % R
    Rb=Xi(2,z); % R
    Rc=Xi(3,z); % R
    Beta=Xi(4,z); % R
    Vbe=Xi(5,z);
    Vcesat=Xi(6,z);

    iB=(Vcc-Vbe)/Rb;
    iCsat=(Vcc-Vcesat)/Rc;

    if (iCsat-Beta*iB)>=0 % Região ativa
        tbjmode(z)=3;
    else
        tbjmode(z)=2; % Saturação
    end
end



