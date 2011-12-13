function B = validateAttribute(attribute, schema)
% Purpose:      Validates the passed attribute against the passed schema. 
% Precondition: schema is a hashmap of attribute names to datatypes
% Returns:      True if validation is successful, false otherwise.
% Note:         If the attribute exists in the schema, validation is successful.
    B = true;
    if(numel(attribute) > 1)
        for k = 1: numel(attribute)
            a = attribute(k);
            %If the hashmap contains no entry for the current attribute
            if(isempty(schema.get(a)))
                fprintf('%s %s\n', 'Attribute not found:', a); 
                B = false;
            end    
        end
    else
        %If the hashmap contains no entry for the attribute
        if(isempty(schema.get(attribute)))
            fprintf('%s %s\n', 'Attribute not found:', attribute); 
            B = false;
        end   
    end
end
