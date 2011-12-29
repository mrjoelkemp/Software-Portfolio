% Author:   Joel Kemp, mrjoelkemp@gmail.com
% File:     fitness.m
% Purpose:  Evaluates the fitness of the passed board state for the passed player.
% Precond:  boardState is a 3x3 numeric array
%           player is a 1 (X) or 2 (O)
% Returns:  A numeric score representing the fitness of the generated state for the 
%           desired player.
% Notes:    The fitness is the potential number of winning conditions for the given
%           player in rows, columns, and diagonals. Higher fitness scores mean that
%           the player is closer to winning.


function score = fitness(boardState, player)
    score = 0;
    
    % Make sure the difference between the number of markers for both players is 1
    idxX = ismember(boardState, 1);
    idxO = ismember(boardState, 2);
    sumRowsX = sum(idxX, 2);
    sumRowsO = sum(idxO, 2);
    numMovesX = sum(sumRowsX);
    numMovesO = sum(sumRowsO);
    
    correctNumMoves = abs(numMovesX - numMovesO) <= 1;
    if(~correctNumMoves) return; end
    
    [maxRowScore maxColScore maxDiagScore] = getStateScores(boardState, player);
    
    % The final fitness score is the sum of the different scores
    score = sum([maxRowScore maxColScore maxDiagScore]);    
end