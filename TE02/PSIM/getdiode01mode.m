function [mode]=getdiode01mode(Xi)

% ff2n(3)
% D1 D2 LED1
% 0 0 0 -> 0 All off
% 0 1 1 -> 1 D1 off
% 1 0 1 -> 2 D2 off
% 1 1 1 -> 3 All ON

% Select
[~,y]=size(Xi);
mode=zeros(y,1);

for z=1:y
    %   CombVec(Vi,Von1,Von2,Von3,R1)
    Vi=Xi(1,z); %
    Von1=Xi(2,z); %
    Von2=Xi(3,z); %
    Von3=Xi(4,z); %

    Von=min([Von1 Von2])+Von3;

    if(Vi >= Von)
        if(Von1==Von2)
            % disp('All on')
            mode(z)=3;
        elseif(Von1<Von2)
            % disp('D2 off')
            mode(z)=2;
        else
            % disp('D1 off')
            mode(z)=1;
        end
        % else
        %     disp('All off')
    end
end