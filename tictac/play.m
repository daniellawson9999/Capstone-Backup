clear;
% loads q table
load('data.mat');

%initialize game
game = zeros(3,3);

fprintf("you are O, the computer is X\n");
moves = true;


displayBoard(game);

move = randi(2);
% one player randomly goes first
if(move == 1)
    fprintf("the computer goes first\n");
else
    fprintf("you go first\n");
end

while(moves)
    if(move == 1)
        [row col] = greedyAction(qTable,game);
        fprintf("computer move: %d %d\n",row,col);
        game(row,col) = 1;
        move = 2;
    elseif(move == 2)
        str = input("enter your move: r c","s");
        row = str2double(str(1));
        col = str2double(str(3));
        game(row,col) = 2;
        move = 1;
    end
    displayBoard(game);
    moves = false;
    switch(gamestate(game))
        case 1
            fprintf("the computer wins\n");
        case 2
            fprintf("you win\n");
        case 3
            fprintf("draw\n");
        case -1
            moves = true;
    end
     
end