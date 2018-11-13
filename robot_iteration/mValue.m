function [value rf cf] = mValue(r,c,environment,values)
    % get possible actions from state r,c
    actions = action(r,c,environment);
    % get values of each action
    actionsV = zeros(length(actions),1);
    % determine value of each action
    for a = 1:length(actions)
        actionsV(a) = values(actions(a,1),actions(a,2));
    end
    % return the maximum value
    [value i] = max(actionsV);
    % return index of max
    rf = actions(i,1);
    cf = actions(i,2);
end

