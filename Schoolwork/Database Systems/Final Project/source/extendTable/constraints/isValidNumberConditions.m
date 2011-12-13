function B = isValidNumberConditions(numTokens)
% Purpose:  Determines whether or not the number of tokens passed is valid for a
%           string of conditions.
% Precondition:
%           numTokens: The number of parts parsed from the condition string
% Returns:  True if the # of tokens represents a valid condition. False otherwise
% Note:     Valid conditions:
%               Attrib Operator Value
%               Attrib Operator Value AND Attrib Operator Value (one or more)
%               Attrib Operator Value OR Attrib Operator Value (one of more)
    B = true;
    notSize3 = numTokens ~= 3;
    
    % If we remove the first condition (3 tokens) from the string and observe the
    % remaining number of tokens for valid conditions, a valid string should contain
    % a number of tokens divisible by 4.
    %   Ex: A < 5 AND A > 1
    %   Removing the first condition (A < 5), we end up with 'AND A > 1' (4 tokens)
    notMult4OnceRemoved = mod((numTokens - 3), 4) ~= 0;
    if(notSize3 && notMult4OnceRemoved) 
        fprintf('%s\n', 'Condition is incomplete. Not enough clauses specified.');
        B = false;
    end
end
