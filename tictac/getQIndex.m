function [index] = getQIndex(qTable,game,row,col)
    %increase the value of each state by one due to 1 based indexing
    
    game = game + 1;
    index = sub2ind(size(qTable),game(1,1),game(1,2),game(1,3),game(2,1),game(2,2), ...
        game(2,3),game(3,1),game(3,2),game(3,3),row,col);
        
    %{
    index = 1;
    n = 0;
    for i = 1:3
        for j = 1:3
            value = game(i,j);
            index = index + value * (3^n);
            n = n + 1;
        end
    end
    %}
end

