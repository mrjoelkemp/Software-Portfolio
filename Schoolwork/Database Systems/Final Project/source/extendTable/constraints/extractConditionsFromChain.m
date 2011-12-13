function C = extractConditionsFromChain(condList)
% Purpose: Locates and returns all of the structs in the passed matrix
% Returns: A cell matrix of structs.
    idx = cellfun(@isstruct, condList, 'UniformOutput', true);
    C = condList(idx);
end