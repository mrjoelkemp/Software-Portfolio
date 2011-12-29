% Author: Joel Kemp, mrjoelkemp@gmail.com
% File: printState.m
% Purpose: Prints the state as a 2D grid to the console.

function printState(state)
    numRows = numel(state(:,1));
    numCols = numel(state(1,:));
    
    printDashes(numCols);
    
    for k = 1 : numRows
        r = state(k,:);
        
        fprintf('|');
        
        % Print the row of markers
        for j = 1 : numCols
            % Convert to the appropriate marker
            marker = ' ';
            val = r(j);
            if      (val == 2) marker = 'O';
            elseif  (val == 1) marker = 'X';
            end

            fprintf(' %s |', marker);
        end
        
        fprintf('\n');
        
        % Print a row of dashes
        printDashes(numCols);
        
        fprintf('\n');
    end
end

function printRow(r)

end

function printDashes(numCols)

    fprintf(' ');
    % Print a row of dashes
    for j = 1 : numCols
       fprintf('--- '); 
    end
    
    fprintf('\n');
end