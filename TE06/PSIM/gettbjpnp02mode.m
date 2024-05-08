function [tbjmode]=gettbjpnp02mode(Xi)



% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);

for z=1:y
    %  CombVec(Vcc,Rb,Rc,Re,Beta,Veb,Vecsat);
    Vcc=Xi(1,z); % R
    Rb=Xi(2,z); % R
    Rc=Xi(3,z); % R
    Re=Xi(4,z); % R
    Beta=Xi(5,z); % R
    Veb=Xi(6,z);
    Vecsat=Xi(7,z);

    iB=(Vcc-Veb)/(Rb+(Beta+1)*Re);
    
    iBsat=(Vcc-Veb-(Re/Rc)*(Veb-Vecsat))/(Rb+Re+Re*Rb/Rc);
    iCsat=(Veb-Vecsat+Rb*iBsat)/Rc;

    if (iCsat-Beta*iB)>=0 % Região ativa
        tbjmode(z)=3;
    else
        tbjmode(z)=2; % Saturação
    end
end



