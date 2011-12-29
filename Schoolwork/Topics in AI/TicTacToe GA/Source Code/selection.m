% Author:   Joel Kemp, mrjoelkemp@gmail.com
% File:     selection.m
% Purpose:  Performs an analysis of the fitness of the board states and uses a
%           roulette-wheel selection to determine the offspring for crossover.
% Returns:  A set of states chosen for crossover.

function S = selection(states, fitnessList)   
    numStates = numel(states(:,1));
    
    % Expected count of selection
    avgF = mean(fitnessList);
    EC = arrayfun(@(f) f / avgF, fitnessList);
    
    % Generate the new population via roulette wheel selection
    S = cell(1);
    for k = 1 : numStates
        choice = rouletteWheel(EC); 
        
        % Prevent negative indices
        if(choice < 0) choice = 1; end
        
        S{k, 1} = states{choice};
    end
end

