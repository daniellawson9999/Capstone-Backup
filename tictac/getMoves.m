function [ moves ] = getMoves( game )
% matrix of possible legal moves represented by a logical matrix
moves = game == 0;
end