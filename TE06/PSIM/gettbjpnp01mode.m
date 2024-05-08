function [tbjmode]=gettbjpnp01mode(Xi)



% Select
[~,y]=size(Xi);
tbjmode=zeros(y,1);

for z=1:y
    %     Xi=CombVec(Vcc,Rb,Rc,Beta,Veb,Vecsat); %%
    Vcc=Xi(1,z); % R
    Rb=Xi(2,z); % R
    Rc=Xi(3,z); % R
    Beta=Xi(4,z); % R
    Veb=Xi(5,z);
    Vecsat=Xi(6,z);

    iB=(Vcc-Veb)/Rb;
    iCsat=(Vcc-Vecsat)/Rc;

    if (iCsat-Beta*iB)>=0 % Região ativa
        tbjmode(z)=3;
    else
        tbjmode(z)=2; % Saturação
    end
end



