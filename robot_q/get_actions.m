function [ actions ] = action(s,E)
% where s is the current state from 1-size^2 from environment E.

n = size(E,1);
n_actions = 4;
% obtain row, column indexes (r,c)
r = ceil(s/n);
c = s - (r-1)*n;

actions = [];
if E(r,c) == "obstacle" || E(r,c)  == "end"
    return
end
% create a matrix of possible actions (top, right, bot, left)
actions = [r-1 c; r c+1; r+1 c; r c-1];
% constrain actions to those inside the matrix
valid = actions > 0 & actions < 9;
valid = (valid(:,1) +valid(:,2)) == 2;
% make illegal actions temp -1,-1
for i = 1:n_actions
    if valid(i) == 0
        actions(i,:) = [-1,-1];
    end
end
% remove actions that result in moving towards an obstacle
for row = 1:n_actions
    if actions(row,1) == -1 || actions(row,2) == -1
        continue;
    end
    if E(actions(row,1),actions(row,2)) == "obstacle"
        actions(row,:) = [-1 -1];
    end
end

% convert r,c into s
temp = zeros(n_actions,1);
for row = 1:n_actions
          % s = (r-1)n + c
    temp(row) = (actions(row,1)-1)*n + actions(row,2);
    if temp(row) <= 0
        temp(row) = 0;
    end    
end

actions = temp;

end