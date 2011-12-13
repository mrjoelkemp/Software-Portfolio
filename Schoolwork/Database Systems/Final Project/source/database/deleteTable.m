function database = deleteTable(database, table)
% Purpose: Finds the passed table within the database and deletes it.
% Returns: The modified database.
    index = getTableIndex(database, table.name);
    % Notice parens to delete cell entry, not set the value to empty
    database(index) = [];
end