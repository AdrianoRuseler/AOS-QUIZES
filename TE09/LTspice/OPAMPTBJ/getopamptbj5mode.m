function  mode = getopamptbj5mode(Xi)

% Select
[~,y]=size(Xi); % (Vi,fs,D,L0,C0,R0); %
mode=zeros(y,1);
k = 1.3806504e-23;
q = 1.60217662e-19;
Vt=k*300.1500/q;
vlim=0.9;

for z=1:y
    tmp=num2cell(Xi(:,z));
    % [Vs,Vi,R1,R2,R3,R4,RL,Is,Beta,nf] = deal(tmp{:});
    [Vs,Vi,R1,R2,R3,R4,~,Is,~,nf] = deal(tmp{:});

    vx=abs(-nf*Vt*log(Vi/(R1*Is)));
    vy=R3*vx/R2;
    vo=R4*Is*(Vi/(R1*Is))^(R3/R2); %

    if vo>Vs*vlim || vx>Vs*vlim || vy>Vs*vlim
        mode(z)=-1;  % Erro
    elseif R3>R2 
        mode(z)=2;
    else
        mode(z)=1;
    end
end
