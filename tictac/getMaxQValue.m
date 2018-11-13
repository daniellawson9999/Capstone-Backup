function [row col max] = getMaxQValue(legalActions, qActions)
    max = qActions(1,1);
    row = 1; 
    col = 1;
    for i = 1:3
        for j = 1:3
            % replace value if the current one is illegal
            if legalActions(row,col) == 0
                max = qActions(i,j);
                row = i;
                col = j;
            % change the max value if a better one is found (and legal)
            elseif (qActions(i,j) > max && legalActions(i,j) == 1)
                max = qActions(i,j);
                row = i;
                col = j;
            end
        end
    end
end

