function types = getTypesFromSchema(schema)
% Purpose: Returns the types associated with the attributes of the passed schema.
% Precond: Schema is a hashmap
% Returns: A cell matrix of strings indicating datatypes.

    attribs = keyset2char(schema.keySet()); 

    % Get the datatypes of all of the attributes in the table
    types = arrayfun(@(attrib) schema.get(attrib), attribs, 'UniformOutput', false);
end