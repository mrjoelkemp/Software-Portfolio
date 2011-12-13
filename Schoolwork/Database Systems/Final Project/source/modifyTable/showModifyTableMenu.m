function choice = showModifyTableMenu(tableName)
% Purpose: Shows the modify table menu and returns the user's choice.
% Returns: The integer value of the user's choice
    fprintf('\n%s\n', '--- Modification Menu ---');
    fprintf('Please select what to modify for table ''%s''!\n', tableName);
    fprintf('%s\n', '1. Delete Tuples');
    fprintf('%s\n', '2. Cross Join');
    fprintf('%s\n', '3. Natural Join');
    fprintf('%s\n', '4. Union');
    fprintf('%s\n', '5. Intersection');
    fprintf('%s\n', '6. Difference');
    fprintf('%s\n', '7. Group Table');
    fprintf('%s\n', '8. Select by Condition');
    fprintf('%s\n', '9. DONE');
    choice = getValidMenuChoice(1, 9);
end