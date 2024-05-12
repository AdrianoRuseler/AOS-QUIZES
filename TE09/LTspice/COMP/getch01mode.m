function  mode = getch01mode(Xi) %  CombVec(Vs,Vi,fi,R1,R2,RL); %%


% Select
[~,y]=size(Xi);
mode=zeros(y,1);

for z=1:y
    tmp=num2cell(Xi(:,z));
    % [Vs,Vi,fi,R1,R2,RL] = deal(tmp{:});
    [Vs,Vi,~,R1,R2,~] = deal(tmp{:});
    Vx=R1*Vs/(R1+R2);

    if Vi>Vx
        mode(z)=1;
    else
        mode(z)=2;
    end
end



