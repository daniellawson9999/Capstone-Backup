clear;
load('data.mat');

sz = length(environment);

% get a random starting position
s = randi(sz^2);
r = ceil(s/sz);
c = s - (r-1)*sz;

while environment(r,c) ~= "space"
    s = randi(sz^2);
    r = ceil(s/sz);
    c = s - (r-1)*sz;
end

n_actions = 4;


robot = [r,c];
visual = ones(sz);
visual(environment == "obstacle") = 2;
visual(environment == "end") = 3;

max_moves = sz*3;
moves = 0;
delay = .2;
while environment(robot(1),robot(2)) ~= "end" && moves < max_moves
    currentVisual = visual;
    currentVisual(robot(1),robot(2)) = 4;
    imagesc(currentVisual);
    pause(delay);
    s = (robot(1)-1)*sz + robot(2);
    %get actions
    actions = get_actions(s,environment);
    %get max action
    temp_max = q_table(s,1);
    index = 1;
    for k = 1:n_actions
        if actions(index) == 0
            temp_max = q_table(s,k);
            index = k;
        elseif q_table(s,k) > temp_max && actions(k) ~= 0
            temp_max = q_table(s,k);
            index = k;
        end
    end
    % update state
    s = actions(index);
    % update robot location
    r = ceil(s/sz);
    c = s - (r-1)*sz;
    robot = [r c];
    moves = moves + 1;
end
endVisual = visual;
endVisual(robot(1),robot(2)) = 4;
imagesc(endVisual);
