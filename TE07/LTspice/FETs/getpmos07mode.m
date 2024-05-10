function [fetmode]=getpmos07mode(Xi)

% Select
[~,y]=size(Xi);
fetmode=zeros(y,1);

for z=1:y
    % CombVec(Vdd,Vgg,Rd,Rg,Kp,Vto);
    Vdd=Xi(1,z); % R
    Vgg=Xi(2,z); % R
    Rd=Xi(3,z); % R
%     Rg=Xi(4,z); % R
    Kp=Xi(5,z); % R
    Vto=Xi(6,z);

%     Idss=Beta*Vto^2;

    Vdsat=Vgg-Vto;
    Id=-(Kp/2)*Vdsat^2;
    Vdss=Vdd-Rd*Id;

    if Vdsat<0
        if Vdss<=Vdsat
            fetmode(z)=2; % Saturação
        else
            fetmode(z)=3; % ôhmica
        end
    else
        fetmode(z)=1; % Corte
    end
end
% 1- Corte; 2 - Saturação; 3 - ôhmica;

