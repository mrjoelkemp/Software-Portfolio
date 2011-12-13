function colvals = getMultipleTupleColumnValues(tuples, attribs)
% Purpose:  Grabs the column values for each attribute and combines the columns into 
%           a 1xK cell matrix, where K is the number of attributes.
% Precond:  Tuples is a structure array.
%           attribs is a string of uppercase characters.
% Returns:  A 1xK cell matrix, where K is the number of attributes and each inner
%           value pertains to an attribute's column value.
%             A   B   C
%           {'5' '6' 'D'
%            '5' '6' 'D'
%            '5' '6' 'D'
%            '5' '6' 'D'}
    colvals = cell(1);
    for k = 1: numel(attribs)
        % Get the current attribute
        a = attribs(k);
        % Get the column values for the current attribute
        cola = getTupleColumnValues(tuples, a);
        
        % Append this to the list of values
        colvals{k} = cola;        
    end
    
    % At this point, we have:
    %    A      B      C
    % {{Kx1}, {Mx1}, {Nx1}}    
    
    % De-nest the inner cells
    colvals = [colvals{:}];
end