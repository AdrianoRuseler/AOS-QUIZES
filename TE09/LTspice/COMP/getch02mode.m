function  mode = getch02mode(Xi) %  CombVec(Vs,Vi,fi,R1,R2,R3,RL); %%


% Select
[~,y]=size(Xi);
mode=zeros(y,1);

for z=1:y
    tmp=num2cell(Xi(:,z));
    % [Vs,Vi,fi,R1,R2,R3,RL] = deal(tmp{:});
    [Vs,Vi,~,R1,R2,R3,~] = deal(tmp{:});

    Rx=R2*R3/(R2+R3);
    Vx=R1*Vs/(R1+Rx);

    Vy=Vs*(1/R3-1/R2)/(1/R1+1/R2+1/R3);

    if Vi>max(Vx,abs(Vy))
        mode(z)=1;
    else
        mode(z)=2;
    end
end