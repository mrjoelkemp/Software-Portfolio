function printCondition(condition, newline)
% Purpose:  Prints a single condition's parts to the console.
% Precond:  newline is a boolean determine whether or not we should break to a new
%           line after printing the condition.
% Note:     With newline, we can use this to print a chain.
    if(iscell(condition)) condition = condition{:}; end
    fprintf('%s %s %s', condition.lhs, condition.operator, condition.rhs);
    if(newline)
        fprintf('\n');
    end
end