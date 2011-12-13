function C = extractBooleanOperatorsFromChain(condList)
% Purpose: Locates and returns all non-structs in the passed matrix
% Returns: A cell matrix of strings.
    idx = cellfun(@isstruct, condList, 'UniformOutput', true);
    % Delete the structures from the list
    condList(idx) = [];
    % What's left is a list of boolean operators (strings)
    C = condList;
end