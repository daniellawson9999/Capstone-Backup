function [reward] = getReward(game)
    state = gamestate(game);
    % no reward if the game is tied or has not ended (state -1 or 3)
    reward = 0;
    % for winning
    if(state == 1)
        reward = 10;
    end
    % for losing
    if(state == 2)
        reward = -10;
    end
    if(state == 3)
       %reward = 0;
    end
end

