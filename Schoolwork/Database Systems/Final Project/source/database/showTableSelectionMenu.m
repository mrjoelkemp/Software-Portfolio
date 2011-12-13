function tableName = showTableSelectionMenu(database)
% Purpose:  Prints a list of the defined tables in the current database, and
%           asks a user to select one of the tables for extension.
% Returns:  The name of the selected table.
    tableName = [];
    if(isempty(database{1})) 
            fprintf('Sorry, no tables exist!\n');
            return; 
    end
        
    fprintf('\n%s\n', '--- Table Selection ---');
    fprintf('%s\n', 'Please select a table!');
    for k = 1:numel(database)
        t = database{k};
        if(isempty(t)) continue; end
        fprintf('%i. %s\n', k, t.name);
    end
    
    choice = getValidMenuChoice(1, k);   
    t = database{choice};
    tableName = t.name;
end