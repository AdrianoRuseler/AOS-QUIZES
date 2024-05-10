function [combmode]=getcomb02mode(Xi)

% Select
[~,y]=size(Xi);
combmode=zeros(y,1);

syms x

for z=1:y
    % CombVec(Vcc,RD,RE,R1,R2,Beta,Vto,IS,BF); %%
    Vcc=Xi(1,z); %
    Rd=Xi(2,z); %
    Re=Xi(3,z); %
    R1=Xi(4,z); %
    R2=Xi(5,z); %
    Beta=Xi(6,z); %
    Vto=Xi(7,z);
    Is=Xi(8,z);
    BF=Xi(9,z);

    Rth=R1*R2/(R1+R2);
    Vth=Vcc*R2/(R1+R2);
%     Vx=(Rth/(BF+1)+Re)*Is;

%     eqn = Vth-x-Vx*exp(x/0.025865) == 0;
%     Vbe=double(solve(eqn,x,'Real',true));

    Vbe=0.7; % implementar função
    Ib=(Vth-Vbe)/(Rth+(BF+1)*Re);
    Id=BF*Ib;

    Vgs=Vto+sqrt(Id/Beta);
    Vdsat=Vgs-Vto;

    Vdss=Vcc-Vth+Vgs+Rth*Ib-Rd*Id;

    if Vgs<0
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

