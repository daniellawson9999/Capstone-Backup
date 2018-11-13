function [state] = gamestate(game)
% state=:  -1 if no one has 3 in a row, if 1, 1 has won, 2 if 2, 2 has won
% and 3 if there is a tie

state = -1;

for i = 1:3
    if (isequal(game(i,:),[1 1 1]) || isequal(game(:,i)', [1 1 1]))
        state = 1;
    elseif (isequal(game(i,:),[2 2 2]) || isequal(game(:,i)',[2 2 2]) )
        state = 2;
    end
end

diagonal1 = [game(1,1) game(2,2) game(3,3)];
diagonal2 = [game(1,3) game(2,2) game(3,1)];
if( isequal(diagonal1,[1 1 1]) || isequal(diagonal2,[1 1 1]))
    state = 1;
elseif (isequal(diagonal1,[2 2 2]) || isequal(diagonal2,[2 2 2]))
    state = 2;
end

moves = 0;
for i = 1:3
    for j = 1:3
        if (game(i,j) == 0)
            moves = 1;
        end
    end
end
if(~moves && state == -1)
    state = 3;
end

end

