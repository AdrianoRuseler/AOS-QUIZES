function [tbjmode]=gettbjnpn02mode(Xi)



% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);

for z=1:y
    %  CombVec(Vcc,Rb,Rc,Re,Beta,Vbe,Vcesat); %%
    Vcc=Xi(1,z); % R
    Rb=Xi(2,z); % R
    Rc=Xi(3,z); % R
    Re=Xi(4,z); % R
    Beta=Xi(5,z); % R
    Vbe=Xi(6,z);
    Vcesat=Xi(7,z);

    iB=(Vcc-Vbe)/(Rb+(Beta+1)*Re);
    iBsat=(Vcc-Vbe-(Re/Rc)*(Vbe-Vcesat))/(Rb+Re+Re*Rb/Rc);
    iCsat=(Vbe-Vcesat+Rb*iBsat)/Rc;

    if (iCsat-Beta*iB)>=0 % Região ativa
        tbjmode(z)=3;
    else
        tbjmode(z)=2; % Saturação
    end
end



