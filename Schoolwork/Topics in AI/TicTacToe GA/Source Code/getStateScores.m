% Author:   Joel Kemp, mrjoelkemp@gmail.com
% File:     getStateScores.m
% Purpose:  Computes the number of markers for player along the rows, columns, and
%           diagonals. This information can be used to check for win conditions 
%           and compute the fitness of the boardstate.
% Returns:  The maximum scores along the different directions. The max score
%           indicates the greatest number of markers.

function [maxRowScore maxColScore maxDiagScore] = getStateScores(boardState, player)
    % Sum up the player's marker on the same row, col, or diagonal
    % Find the max num adjacent markers in rows
    rowScores = zeros(3,1);
    colScores = zeros(3,1);
    for k = 1 : 3
       row = boardState(k,:);
       %Make the column look like a row
       col = boardState(:,k)';
       % Get the score for the row
       rowScores(k) = getRowScore(row, player);
       colScores(k) = getRowScore(col, player);
    end
    maxRowScore = max(rowScores);
    maxColScore = max(colScores);
    
    % Transform the diagonals into row vectors to use getRowScore()
    diagScores = zeros(2, 1);
    diag1 = [boardState(1,1) boardState(2,2) boardState(3,3)];
    diag2 = [boardState(1,3) boardState(2,2) boardState(3,1)];
    diagScores(1) = getRowScore(diag1, player);
    diagScores(2) = getRowScore(diag2, player);
    maxDiagScore = max(diagScores);
end