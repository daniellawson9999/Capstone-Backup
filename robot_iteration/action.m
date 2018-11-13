function [ actions ] = action(r,c,S)
% where r =  row index of current state, c = col index of of current state
% S contains all states (and non-states? marked by obstacle)
% and actions is the set of available actions at state S(r,c)

actions = [];
if S(r,c) == "obstacle" || S(r,c)  == "end"
    return
end
% create a matrix of possible actions (right, left, up, down)
actions = [r-1 c; r+1 c; r c+1; r c-1];

% constrain actions to those inside the matrix
valid = actions > 0 & actions < 9;
valid = (valid(:,1) +valid(:,2)) == 2;
actions = actions(valid == 1,:);

% remove actions that result in moving towards an obstacle
for row = 1:size(actions,1)
    if row > size(actions)
        break
    end
    if S(actions(row,1),actions(row,2)) == "obstacle"
        actions(row,:) = [];
    end
end

end