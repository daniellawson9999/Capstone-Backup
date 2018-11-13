function [value] = getSQValue(qTable, game)
    %get all legal moves
    
    legalMoves = game == 0;
    %calculate value of each random move
    moves = zeros(3,3);
    for i = 1:3
        for j = 1:3
            if(legalMoves(i,j))
                moves(i,j) = getQValue(qTable,game,i,j);
            end
        end
    end 
    nMoves = sum(legalMoves(:));
    total = sum(moves(:));
    value = 0;
    %would have to compute transition in other circumstances
    if(nMoves ~= 0)
        value = total / nMoves;
        %the incorrect line value = sum(moves(:)) / (nMoves);
    end
end

