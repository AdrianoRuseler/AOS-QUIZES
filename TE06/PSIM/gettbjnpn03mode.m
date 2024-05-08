function [tbjmode]=gettbjnpn03mode(Xi)



% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);

for z=1:y
    %  CombVec(Vcc,Ra,Rb,Rc,Re,Beta,Vbe,Vcesat); %%
    Vcc=Xi(1,z); % R
    Ra=Xi(2,z); % R
    Rb=Xi(3,z); % R
    Rc=Xi(4,z); % R
    Re=Xi(5,z); % R
    Beta=Xi(6,z); % R
    Vbe=Xi(7,z);
    Vcesat=Xi(8,z);

    Rth=(Ra*Rb)/(Ra+Rb);
    Vth=Vcc*Rb/(Ra+Rb);
    iB=(Vth-Vbe)/(Rth+(Beta+1)*Re);

    iEsat=(Vth-Vbe+Rth*(Vcc-Vcesat)/Rc)/(Re+Rth+(Re*Rth)/Rc);

    iCsat=(Vcc-Vcesat-Re*iEsat)/Rc;

    if (iCsat-Beta*iB)>=0 % Região ativa
        tbjmode(z)=3;
    else
        tbjmode(z)=2; % Saturação
    end
end



