function [combmode]=getcomb01mode(Xi)

% Select
[~,y]=size(Xi);
combmode=zeros(y,1);

for z=1:y
    % CombVec(Vcc,Rb,Rc,Rs,R1,R2,Beta,Vto,IS,BF);
    Vcc=Xi(1,z); %
    Rb=Xi(2,z); %
    Rc=Xi(3,z); %    
    Rs=Xi(4,z); %
    R1=Xi(5,z); %
    R2=Xi(6,z); %
    Beta=Xi(7,z); %
    Vto=Xi(8,z);
    Is=Xi(9,z);
    BF=Xi(10,z);

    Rth=R1*R2/(R1+R2);
    Vth=Vcc*R2/(R1+R2);
    
    Vx=Vto-Vth;

    a=Rs^2;
    b=2*Rs*Vx-1/Beta;
    c=Vx^2;

    Id=(-b-sqrt(b^2-4*a*c))/(2*a);
    Vdsat=Vth-Id*Rs-Vto;
    Vbe=0.0259*log(Id/Is);
    Ib=Id/(BF+1);
    Vdss=Vcc-Vbe-Rs*Id-Rb*Ib;

    if Rb > BF*Rc
        % TBJ Ativo Direto
        combmode(z)=1;
    else
        % TBJ Saturação
        combmode(z)=2;
    end

    % 0 -> FET Corte + TBJ Corte
    % 1 -> FET Saturação + TBJ Ativo Direto
    % 2 -> FET Saturação + TBJ Saturação
    % 3 -> FET OHM + TBJ Ativo Direto
    % 4 -> FET OHM + TBJ Saturação

    if Vdsat>0
        if Vdss>=Vdsat
            % combmode(z)=2; % FET Saturação
        else
            combmode(z)=combmode(z)+2; % FET OHM
        end
    else
        combmode(z)=0; % Corte
    end
end

