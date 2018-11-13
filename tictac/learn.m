clear;

initialQ = 0;
%11 dimensional matrix...
qTable = ones(3,3,3,3,3,3,3,3,3,3,3) * initialQ;
%qTable = zeros(2000000,1);
% number of games to play
games = 500000;
gamma = 1;
learningR = .8;
epsilon = 1;
decayRate =  1/games;
%maybe not necessary
minEpsilon = .01;

visualize = false;
delay = 0;
% learns using 1 = its own piece, 2 = other player

testGames = 1000;
gamesWon = 0;
gamesLost = 0;

test = true;

training = true;
i = 1;
while training
    %initialize game
    game = [0 0 0;
            0 0 0;
            0 0 0];
    % randomly chose a player to start first    
    
    if (visualize)
        fprintf("%d going first\n",start);
    end
    % if the other player starts first, give them a randon move
    start = randi(2);
    if (start == 2)
        [row, col] = randomMove(game == 0);
        game(row,col) = 2;
    end
    playing = true;
    
    if(visualize)
        displayBoard(game);
    end
     % begin playing / learning
    while playing
        pause(delay);
        r = rand();
   
        mRow = 0;
        mCol = 0;

        if r < epsilon
            % exploration
            [mRow, mCol]  = randomMove(game == 0);
        else
            %greedy action (logic moved to other functions for readibility)
            [mRow, mCol] =  greedyAction(qTable,game);
        end
        % obtain new game (the new state)
        
        nGame = game;
        nGame(mRow,mCol) = 1;
        if(visualize)
            displayBoard(nGame);
            pause(delay);
        end
        % simulate the opponent's action by a randomMove (if there is another move
        if (gamestate(nGame) == -1)
            [rRow, rCol] = randomMove(nGame == 0);
            nGame(rRow,rCol) = 2;
        end
        %see if there is a reward (win/loss at the new state)
        % will equal 0 for all other actions
        reward = getReward(nGame);
        
 
        [~, ~, mnValue] =  greedyAction(qTable,nGame);
        
        % update q(s,a) (the q function!)
        s_a = getQIndex(qTable,game,mRow,mCol);
        qTable(s_a) = (1-learningR)*qTable(s_a) + learningR*(reward + gamma * mnValue);
        
        %update state
        game = nGame;
        %visualize new state
        if(visualize)
            displayBoard(game);
        end
        
        
        % check if a game is over and stop the current game if so
        state = gamestate(game);
        if(state ~= -1)
            playing = false;
            if(visualize)
                fprintf("gamestate is %d\n",state);
            end
        end
        
    end 
    %reduce epsilon
    newEpsilon = epsilon - decayRate;
    epsilon = max([minEpsilon newEpsilon]);
    fprintf("%d\n",i);
    i = i + 1;
    if i > games
        training = false;
    end
end
%simulate x testGames if test is true
if(test)
    games = testGames;
    for i = 1:games
        playing = true;
        game = zeros(3,3);
        move = randi(2);
        while playing
            if(move == 1)
                [row, col] =  greedyAction(qTable,game);
                game(row,col) = 1;
                move = 2;
            else
                [row, col] = randomMove(game == 0);
                game(row, col) = 2;
                move = 1;
            end
           
            state = gamestate(game);
            if(state ~= -1)
                playing = false;
                if(state == 1)
                    gamesWon = gamesWon + 1;
                end
                if(state == 2)
                    gamesLost = gamesLost + 1;
                end
            end
        end
    end
    fprintf("%d test games played, %.2f%% won, %.2f%% lost. and %.2f%% tied\n", ...
    games,gamesWon/games*100,gamesLost/games*100,(games - gamesWon -gamesLost)/games*100);
end

save('data.mat','qTable');