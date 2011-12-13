function rowstring = struct2string(s)
% Purpose: Converts a structure's values into a comma separated string
% Returns: A comma separated string containing the values of the struct
    attribs = fieldnames(s);
    rowstring = [];
    for k = 1: numel(attribs)
        attrib = attribs{k};
        val = s.(attrib);
        if(isempty(rowstring))
            % If the string has nothing, take the val and make it into a string
            rowstring = sprintf('%s', val);
        else
            rowstring = strcat(rowstring, ',', val);
        end
    end
end