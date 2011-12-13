function rowstrings = tuples2strings(tuples)
% Purpose:  Converts each tuple in the passed tuple list to a string of comma 
%           separated values.
% Returns:  A column cell matrix of strings representing each tuple.
    rowstrings = arrayfun(@struct2string, tuples, 'UniformOutput', false);
end
