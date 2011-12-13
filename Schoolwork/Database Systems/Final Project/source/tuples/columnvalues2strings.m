function rowstrings = columnvalues2strings(colvals)
% Purpose:  Takes in a KxM cell matrix, where K is the number of tuples and M is the
%           number of columns/attributes and returns a comma separated Kx1 cell matrix
%           of strings representing the values in the columns.
% Precond:  colvals is a KxM cell matrix of values.
% Returns:  A Kx1 cell matrix of strings consisting of comma separated values.
% Usage:    Use this to combine tuple columns into strings for use with finding
%           unique tuples.
% Example:  
%              INPUT
%             A   B   C
%           {'5' '6' 'D'
%            '5' '6' 'D'
%            '5' '6' 'D'
%            '5' '6' 'D'}
%
%              OUTPUT
%             {'5,6,D'
%              '5,6,D'
%              '5,6,D'
%              '5,6,D'}
    rowstrings = cell(1);
    numCols = numel(colvals(1,:));
    numRows = numel(colvals(:,1));
    
    % For every row in the list of tuples
    for k = 1 : numRows
        tuple = colvals(k,:);
        rowstring = [];
        for j = 1 : numCols
            val = tuple{j};
            if(isempty(rowstring))
                rowstring = sprintf('%s', val); 
            else
                rowstring = strcat(rowstring, ',', val);
            end
        end
        rowstrings{k, 1} = rowstring;
    end

end