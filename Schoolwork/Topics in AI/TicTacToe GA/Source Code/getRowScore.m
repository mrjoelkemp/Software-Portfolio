% Author:   Joel Kemp, mrjoelkemp@gmail.com
% Purpose:  Computes the fitness/score of the state's row for a given player.
% Returns:  A numerical score representing the fitness.
% Notes:    3 = highest fitness; 0 = lowest fitness

function score = getRowScore(row, player)
    score = 0;
    
    idx = ismember(row, player);
    numMarkersInRow = sum(idx);
    containsEmpty = ismember(0, row) > 0;
    
    % If there are no places to play and now a win condition, then throw it out
    isBadRow = ~containsEmpty && numMarkersInRow < 3;
    if(isBadRow) return; end

    % Otherwise, the row contains a playable spot and has some number of markers
    score = numMarkersInRow;
end