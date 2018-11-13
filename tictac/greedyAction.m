function [mRow, mCol, mValue] = greedyAction(qTable,game)
    mValue = -Inf;
    mRow = 0;
    mCol = 0;
    %determine the best q value of actions at current state
    for i = 1:3
        for j = 1:3
            %if a move is legal, look up and store the value from getQValue
            val = getQValue(qTable,game,i,j);
            if((val >= mValue) && (game(i,j) == 0))
                mRow = i;
                mCol = j;
                mValue = val;
            end
        end
    end
end

