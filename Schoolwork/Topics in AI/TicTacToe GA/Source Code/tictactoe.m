% Author:   Joel Kemp, mrjoelkemp@gmail.com
% File:     test.m
% Purpose:  Uses a GA to find a solution to the Tic Tac Toe problem.

function tictactoe() 
    initPopSize = 9;
    maxIter = 1000;
    probMutation = 0.1;
    counter = 0;
    player = 1;         %Player for which we find the strategy
    
    fprintf('--- Tic Tac Toe Solver ---\n');
    fprintf('Settings:\n');
    fprintf('Initial Population Size:       %i\n', initPopSize);
    fprintf('Maximum number of iterations:  %i\n', maxIter);
    fprintf('Probability of Mutation:       %f\n', probMutation);
    
    % Cell Padding for cellfun 
    padding = repmat({player}, initPopSize, 1);
    
    % Initial population
    S = generatePop(initPopSize);    
    % Fitness of states for player 
    F = cellfun(@fitness, S, repmat({player}, initPopSize, 1));
    
    while (true)
        counter = counter + 1;
        if(counter >= maxIter) break; end
        
        % Perform roulette-wheel selection to select parent for new offspring
        parents = selection(S, F);
        S = crossover(parents);
        S = mutate(S, player, probMutation);

        % Fitness of states for offspring 
        F = cellfun(@fitness, S, padding);
        
        % Extract (valid) non-zero fitness states and use them to check for a win
        S2 = S(F ~= 0);
        if(numel(S2) == 0) continue; end
        
        padding2 = repmat({player}, numel(S2), 1);
        % Check if any of the states are win states
        BS = cellfun(@checkWinCondition, S2, padding2);        
        playerWon = sum(BS) > 0;                
        if(~playerWon) continue; end
        
        % Location of the win state
        idx = find(BS == 1, 1, 'first');
        fprintf('\nSolution Found!\n');
        fprintf('Exact solution found at iteration %i!\n', counter);
        printState(S2{idx});
        return;
    end
    
    fprintf('\nNo exact solution found in %i iterations!\n', maxIter);
    
    % Print out the best attempt at a solution 
    % S2 contains the last set of valid non-winning states
    state = getClosestSolution(S2, player);    
    if(~isempty(state))
        fprintf('Printing the closest solution found!\n');
        printState(state);
    else
       fprintf('Sorry, there were no valid solutions found\n'); 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function state = getClosestSolution(states, player)
    state = [];
    if(isempty(states)) return; end
    
    padding = repmat({player}, numel(states), 1);
    
    % Compute fitness of the states
    F = cellfun(@fitness, states, padding);
    
    while(true)
        maxF = max(F);
        idxMaxF = find(F == maxF, 1, 'first');
        state = states{idxMaxF};
        
        % Does the opponent win at this state with the highest fitness?
        opponentWin = checkOpponentWin(state, player);
        
        if(~opponentWin) break; end
       
        % Set that state's fitness to 0 to prevent it 
        % from being used and try again.
        F(idxMaxF) = [];                
    end
end

function B = checkWinCondition(state, player)
% Purpose:  Checks if the board state contains a winning condition for the player.
% Returns:  True if the state contains a winning condition, false otherwise.
% Notes:    In the off chance where both players win, we make sure this 
%           is not a win state.
    [maxRowScore maxColScore maxDiagScore] = getStateScores(state, player);
    playerWon = maxRowScore == 3 || maxColScore == 3 || maxDiagScore == 3;
    
    opponentWon = checkOpponentWin(state, player);
    
    if(opponentWon)
        B = false;
    else
        B = playerWon;
    end
end

function B = checkOpponentWin(state, player)
% Purpose:  Checks if the player's opponent wins in the passed state.
% Returns:  True if the opponent wins, false otherwise.
    if(player == 1) opponent = 2;
    else            opponent = 1;
    end
   
    [maxRowScore maxColScore maxDiagScore] = getStateScores(state, opponent);
    B = maxRowScore == 3 || maxColScore == 3 || maxDiagScore == 3;
end
function S = generatePop(initPopSize)
% Purpose:  Generates a population of strings representing possible states of the game
%           board.
% Returns:  A vertical cell matrix of the generated board states (3x3 numerics).
% Notes:    
%           Board State Values:
%           0 - Empty
%           1 - Player X
%           2 - Player O
    S = cell(initPopSize, 1);    
    % Randomly generate initPop strings
    for k = 1 : initPopSize        
        % Create a 3x3 array of random integers from 0 to 2      
        state = randi([0 2], 3);
        S{k} = state;
    end
end




