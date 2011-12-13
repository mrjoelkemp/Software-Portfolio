function printConditionList(conditions)
% Purpose: Prints the condition list vertically.
    if(isempty(conditions)) return; end
    
    fprintf('\n%s\n', '--- Condition List Print ---');
   
    numRows = numel(conditions(:,1));
    for k = 1 : numRows
        row = conditions(k,:);
        if(iscell(row)) row = row{:}; end
        numClauses = numel(row);
        isChain = numClauses > 1;
        if(~isChain)
            printCondition(row, true);
        else
            printConditionChain(row);
        end       
    end
end
