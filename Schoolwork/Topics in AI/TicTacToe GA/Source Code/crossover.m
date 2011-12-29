% Author:   Joel Kemp, mrjoelkemp@gmail.com
% File:     crossover.m
% Purpose:  Simulates a crossing of the chromosomes by swapping a row from each state
%           with a randomly chosen partner.
% Returns:  A set of crossed states.

function S = crossover(states)
    numStates = numel(states(:,1));
    
    % Generate a list of mates (one per state)
    mates = randi(numStates, numStates, 1);
    
    S = cell(numStates, 1);
    for k = 1 : numStates
        mate = mates(k);
        state1 = states{k};
        state2 = states{mate};
        S{k} = crossStates(state1, state2);
    end    
end

function state1 = crossStates(state1, state2)
% Purpose: Exchanges a randomly chosen row from state2 to state1. 
% Returns: The crossed state.

    % The locations of the rows to be swapped
    state1rowidx = randi(numel(state1(:,1)), 1);
    state2rowidx = randi(numel(state2(:,1)), 1);
    
    % The row values to be swapped
    rowState2 = state2(state2rowidx,:);
    
    % Swap the row between states
    state1(state1rowidx,:) = rowState2;
end