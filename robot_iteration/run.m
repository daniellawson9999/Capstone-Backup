load('data.mat');
robot = [1,3];
visual = ones(length(environment));
visual(environment == "obstacle") = 2;
visual(environment == "end") = 3;


while environment(robot(1),robot(2)) ~= "end"
    currentVisual = visual;
    currentVisual(robot(1),robot(2)) = 4;
    imagesc(currentVisual);
    %fprintf("press a key for next move\n");
    pause(.5);
    [v r c] = mValue(robot(1),robot(2),environment,values);
    robot = [r c];
end
endVisual = visual;
endVisual(robot(1),robot(2)) = 4;
imagesc(endVisual);