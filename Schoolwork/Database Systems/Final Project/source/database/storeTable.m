function database = storeTable(database, table)
% Purpose: Convenience function to store a new table in the database.
% Returns: A modified database matrix with the new table appended.
    if(isempty(database{1}))
        database{1,1} = table;
    else
        numTables = numel(database);
        database{numTables + 1, 1} = table;
    end
end