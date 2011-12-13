function printConditionChain(condition)
% Purpose:  Prints a condition chain inline.
    numClauses = numel(condition);
    for j = 1:numClauses
        clause = condition{j};
        if(isstruct(clause))
            printCondition(clause, false);
        else
            fprintf(' %s ', clause);
        end
    end
    fprintf('\n');
end