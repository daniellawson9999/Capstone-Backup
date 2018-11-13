% values for different states
value = 100;
reward = -1;
endReward = 100;


% size of environment
size = 8;


% gamma
y = .5;

% create environment
environment = repelem("space",size,size);
environment(1:3,6) = repelem("obstacle",3);
environment(3:6, 3) = repelem("obstacle",4);
environment(1,8) = "end";

% create reward matrix
rewards = zeros(size);
rewards(environment == "space") = reward;
rewards(environment == "end") = endReward;

% and value matrix
values = zeros(size);
values(environment == "space" |  environment == "end") = value;

% do value iteration
converge = zeros(size);
% iterate until all values have converged
%values
while min(converge(:)) == 0
   % store the current values
   current = values;
   % update each value
   for r = 1:size
       for c = 1:size
           if environment(r,c) ~= "obstacle" && environment(r,c) ~= "end"
               values(r,c) = rewards(r,c) + y * mValue(r,c,environment,values);
           end
       end
   end
   % store which values have converged
   converge = current == values;
   % optional
   % values
end
%values
save('data.mat','environment','rewards','values');