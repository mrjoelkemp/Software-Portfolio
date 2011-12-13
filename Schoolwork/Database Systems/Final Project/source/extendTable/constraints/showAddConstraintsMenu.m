function choice = showAddConstraintsMenu(tableName)
% Purpose: Shows the constraints menu and returns the user's choice.
% Returns: The integer value of the user's choice
    fprintf('\n%s\n', '--- Constraints Menu ---');
    fprintf('Please select the constraint to add to table ''%s''!\n', tableName);
    fprintf('%s\n', '1. Boolean Conditions');
    fprintf('%s\n', '2. Functional Dependencies (FD)');
    fprintf('%s\n', '3. Multi-Value Dependencies (MVD)');
    fprintf('%s\n', '4. Keys');
    fprintf('%s\n', '5. DONE');
    choice = getValidMenuChoice(1, 5);
end