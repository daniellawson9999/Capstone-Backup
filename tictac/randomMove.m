function [row col] = randomMoves(lGame)
% where logical matrix of the possible moves
col = randi(3);
row = randi(3);

while(lGame(row,col) == 0)
    col = randi(3);
    row = randi(3);
end

end

