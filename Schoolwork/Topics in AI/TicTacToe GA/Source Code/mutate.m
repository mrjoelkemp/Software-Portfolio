% Author:   Joel Kemp, mrjoelkemp@gmail.com
% File:     mutate.m
% Purpose:  Performs a mutation on the state by playing on a blank.
% Precond:  probMutate is a float representing the probability of mutation 
%           for all states.
% Returns:  The mutated state.

function states = mutate(states, player, probMutate)
    % Roulette-wheel a state to mutate
    weights = repmat(probMutate, numel(states(:,1)), 1);
    chosen = rouletteWheel(weights);
    state = states{chosen};
    
    % Get the location of the blanks
    idx = ismember(state, 0);    
    blankLocations = find(idx == 1);
    
    if(numel(blankLocations) == 0) return; end
    
    % Choose a blank to turn on
    randLoc = randi(numel(blankLocations), 1);    
    blankToPlay = blankLocations(randLoc);
    state(blankToPlay) = player;
    
    % Store the mutated state back into the collection
    states{chosen} = state;
end