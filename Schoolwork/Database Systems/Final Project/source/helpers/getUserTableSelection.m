function table = getUserTableSelection(database)
% Purpose: Presents the user with a menu of tables from the database, grabs their
% choice, and returns the structue of the table that they chose.
    table = [];
    
    tableName = showTableSelectionMenu(database);
    
    if(isempty(tableName)) return; end
    
    % Get the index of the table within the database
    index = getTableIndex(database, tableName);
    table = database{index};
end