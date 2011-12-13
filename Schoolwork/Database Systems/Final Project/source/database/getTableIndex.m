function index = getTableIndex(database, tableName)
% Purpose: Determines the location of the table structure with a name equal
%   to the passed tableName.
% Precondition: database is a cell matrix
% Returns: An integer index within the database.
    index = -1;
    for k = 1 : numel(database)
        if(isempty(database{k})) break; end
        
        t = database{k};    
        if(strcmp(t.name, tableName))
            index = k;
            break;
        end
    end    
end