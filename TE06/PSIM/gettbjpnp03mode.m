function [tbjmode]=gettbjpnp03mode(Xi)



% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);

for z=1:y
    %  CombVec(Vcc,Ra,Rb,Rc,Re,Beta,Veb,Vecsat);
    Vcc=Xi(1,z); % R
    Ra=Xi(2,z); % R
    Rb=Xi(3,z); % R
    Rc=Xi(4,z); % R
    Re=Xi(5,z); % R
    Beta=Xi(6,z); % R
    Veb=Xi(7,z);
    Vecsat=Xi(8,z);

    Rth=(Ra*Rb)/(Ra+Rb);
    Vth=Vcc*Ra/(Ra+Rb);

    iB=(Vth-Veb)/(Rth+(Beta+1)*Re); 

    iEsat=(Vth-Veb+Rth*(Vcc-Vecsat)/Rc)/(Re+Rth+(Re*Rth)/Rc);

    iCsat=(Vcc-Vecsat-Re*iEsat)/Rc;

    if (iCsat-Beta*iB)>=0 % Região ativa
        tbjmode(z)=3;
    else
        tbjmode(z)=2; % Saturação
    end
end



