clear;

% rewards
reward = -1;
endReward = 100;


% size of environment
sz = 8;

% create environment
environment = repelem("space",sz,sz);
environment(1:3,6) = repelem("obstacle",3);
environment(3:6, 3) = repelem("obstacle",4);
environment(1,8) = "end";
end_location = 8;

% matrix for vizualizing the environment
visual = ones(length(environment));
visual(environment == "obstacle") = 2;
visual(environment == "end") = 3;

% create reward matrix
rewards = zeros(sz);
rewards(environment == "space") = reward;
rewards(environment == "end") = endReward;
% unroll the rewards for easier use
rewards = rewards';
rewards = rewards(:);
% create q-table,
 

% other paramaters
initial_q = -3;
iterations = 50;
start_location = 20; %if running randomly, value does not matter
max_moves = 2*sz^2;
learning_r = .7; %learning rate
gamma = .9;
start_epsilon = 1;
epsilon = 1;
decay_rate = 1/iterations; 
min_epsilon = .01;

%other counters
training = true;
i = 1;
delay = .01;
%constants
n_actions = 4;

%q table
q_table = ones(sz^2, 4)*initial_q;

while training
    i
    move = true;
    % move counter
    m = 1;
    %s = start_location;
    % get a random starting location
    s = randi(sz^2);
    r = ceil(s/sz);
    c = s - (r-1)*sz;
    while environment(r,c) ~= "space"
        s = randi(sz^2);
        r = ceil(s/sz);
        c = s - (r-1)*sz;
    end
    % vizualize starting state
    
    currentVisual = visual;
    currentVisual(r,c) = 4;
    imagesc(currentVisual);
    while move
        %delay
        pause(delay);
      
        %algorithm here
        
        % choose an action (using an e-greedy strategy)
        r = rand();
        
        % observe possible actions
        actions = get_actions(s,environment);
        % integer 1-4 representing action choice
        action = 0;
        
        % random action
     
        if r < epsilon
            %fprintf("explore");
            %randomly select a legal action
            rI = randi(4);
            while actions(rI) == 0
                rI = randi(4);
            end
            action = rI;
        % greedy action
        else
            %fprintf("greedy");
            % [temp, action] = max(q_table(s,:)); can not be used b/c illegal moves are then selected
            q_actions = zeros(n_actions,1);
            for n = 1:n_actions
                q_actions(n) = q_table(s,n);
            end
            % get the index of the max action
            temp_max = q_actions(1);
            index = 1;
            for k = 1:n_actions
                if actions(index) == 0
                    temp_max = q_actions(k);
                    index = k;
                elseif q_actions(k) > temp_max && actions(k) ~= 0
                    temp_max = q_actions(k);
                    index = k;
                end
            end
            action = index;
        end
        % observe outcome of action
        s_n = actions(action);
        reward = rewards(s_n);
        
        %obtain max at new state
        max_n = q_table(s_n,1);
        index_n = 1;
        actions_n = get_actions(s_n,environment);
        for n = 1:size(actions_n,1)
            if actions_n(index_n) == 0
                max_n = q_table(s_n,n);
                index_n = n;
            elseif q_table(s_n,n) > max_n && actions_n(n) ~= 0
                max_n = q_table(s_n,n);
                inex_n = n;
            end
        end
        %gives you a valid max_n^
        % update q(s,a)!
        q_table(s,action) = (1-learning_r)*q_table(s,action) + learning_r*(reward + gamma * max_n);
        
        % update state
        s = s_n;
        
        % vizualize new state
        r = ceil(s/sz);
        c = s - (r-1)*sz;
        currentVisual = visual;
        currentVisual(r,c) = 4;
        imagesc(currentVisual);
        
        
        m = m + 1;
        if m > max_moves
            move = false;
        end
        if s == end_location
            move = false;
        end
    end
    %reduce epsilon
    new_epsilon = epsilon - decay_rate;
    epsilon = max([min_epsilon new_epsilon ])
    pause(delay);
    i = i + 1;
    if i > iterations
        training = false;
    end
end

save('data.mat','environment','q_table', 'start_location');