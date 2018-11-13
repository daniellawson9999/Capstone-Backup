function [value] = getQValue(qTable,game,row,col)
    % get the index of the qtable
    index = getQIndex(qTable,game,row,col);
    value = qTable(index);
end

