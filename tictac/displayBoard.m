function [outputArg1,outputArg2] = displayBoard(game)
    shift = "               ";
    fprintf("%s X is rl\n",shift);
    for i = 1:3
        fprintf("%s-------------\n",shift);
        fprintf("%s|",shift);
        for j = 1:3
            c = " ";
            if(game(i,j) == 1)
                c = "X";
            elseif(game(i,j) == 2)
                c = "O";
            end
            fprintf(" %s |",c); 
        end
        fprintf("\n");
    end
    fprintf("%s-------------\n\n",shift);
end

