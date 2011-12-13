function col = getTupleColumnValues(tuples, attrib)
% Purpose:  Returns a column cell matrix of tuple values for the attribute passed.
% Precond:  tuples: Array of structures.
% Usage:    If you pass in attrib = 'A', then this function returns a column list of
%           values for that attribute.
% Note:     Has to be cell matrix passed back because of fragile char arrays!
    col = {tuples(:).(attrib)}';
end