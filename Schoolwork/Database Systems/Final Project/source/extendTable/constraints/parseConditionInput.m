function C = parseConditionInput(tokenized)
% Purpose:  Takes in a user condition definition and parses it into a single or
%           multiple condition structures.
% Precondition: 
%           tokenized is a valid condition statement and is also a
%           column, cell vector of strings.
% Returns:  A cell matrix whose columns contain conditions and boolean operators
    
    numStrings = numel(tokenized);
    C = cell(1,1);
    counter = 1;
    
    % If we have a single condition
    if(numStrings == 3)
        cond = Condition(tokenized{1}, tokenized{2}, tokenized{3});
        % Extract it into a condition
        C{counter} = cond;
        return;
    end
    
    % Extract the multiple conditions
    k = 1;
    while(true)
        boolOp = [];    % Reset each iteration
        cond = Condition(tokenized{k}, tokenized{k+1}, tokenized{k+2}); 
        isAnythingLeft = numStrings - (k+3) >= 0;
        if(isAnythingLeft)
            boolOp = tokenized{k+3};
            % Skip the boolean operator
            k = k + 1;
        end
        % Store the condition and boolean operator 
        C{counter} = cond;
        counter = counter + 1;
        if(~isempty(boolOp))
            C{counter} = boolOp;  
            counter = counter + 1;
        end
        % Skip the conditions
        k = k + 3;
        
        if(k >= numStrings) break; end
    end    
    
end
