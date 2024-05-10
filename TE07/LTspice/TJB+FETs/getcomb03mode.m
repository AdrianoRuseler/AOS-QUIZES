function [combmode]=getcomb03mode(Xi)

%% TODO
% Select
[~,y]=size(Xi);
combmode=zeros(y,1);

for z=1:y
    % CombVec(Vcc,RC,RE,R1,R2,R3,IS,BF,IS,BF); %%
    Vcc=Xi(1,z); %
    Rc=Xi(2,z); %
    Re=Xi(3,z); %
    R1=Xi(4,z); %
    R2=Xi(5,z); %
    R3=Xi(6,z); %
    Is1=Xi(7,z);
    BF1=Xi(8,z);
    Is2=Xi(9,z);
    BF2=Xi(10,z);

    
    Rth=R1*R2/(R1+R2);
    Vth=Vcc*R2/(R1+R2);

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

