% Author:   Joel Kemp, mrjoelkemp@gmail.com
% Project:  Database Systems 1, Fall 2011 Final Project
% File:     modifyTable.m
% Purpose:  Allows the user to modify tables using set operations and conditions.
% Returns:  A modified database consisting of existing tables and intermediate tables
%           created using set operations (union, intersection, etc).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Entry Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function database = modifyTable(db, table)
% Purpose: Allows the user to perform any of the menu options.
% Precond: table is the currently selected, starting table.
% Returns: Modified database.
    database = db;
    mtchoice = showModifyTableMenu(table.name);
    while(mtchoice ~= 9)
       switch mtchoice
           case 1
                % Delete tuples from the current table
                table.tuples = deleteTuples(table.tuples, table.schema);
                % Make sure that the tuples still agree with the MVD constraints.
                [~, table.tuples] = violatesMVDs(table.tuples, table.constraints.mvds, table.schema);
                
                index = getTableIndex(database, table.name);
                database{index} = table;                
           case 2
                fprintf('\n%s\n', '--- Cross Join ---');
                fprintf('We will create a new table cross-joined with ''%s''\n', table.name);
                table2 = getUserTableSelection(database);
                crossTable = crossJoin(table, table2);
                fprintf('...Created cross-join table: %s...\n', crossTable.name);
                printTuplesList(crossTable.tuples, crossTable.schema);
                database = storeTable(database, crossTable);
           case 3
                fprintf('\n%s\n', '--- Natural Join ---');
                fprintf('We will create a new table natural-joined with ''%s''\n', table.name);
                table2 = getUserTableSelection(database);
                natJoinTable = naturalJoin(table, table2);
                fprintf('...Created natural-join table: %s...\n', natJoinTable.name);
                printTuplesList(natJoinTable.tuples, natJoinTable.schema);
                database = storeTable(database, natJoinTable);
           case 4
                fprintf('\n%s\n', '--- Union ---');
                fprintf('We will create a new table to union with ''%s''\n', table.name);
                table2 = getUserTableSelection(database);
                unionTable = union(table, table2);
                if(isempty(unionTable))
                    fprintf('Sorry, tables %s and %s have different schemas!\n', ...
                    table.name, table2.name);
                else
                    fprintf('...Created union table: %s...\n', unionTable.name);
                    printTuplesList(unionTable.tuples, unionTable.schema);
                    database = storeTable(database, unionTable);
                end
           case 5
               fprintf('\n%s\n', '--- Intersection ---');
               fprintf('We will create a new table to intersect with ''%s''\n', table.name);
               table2 = getUserTableSelection(database);
               intersectTable = intersection(table, table2);
               if(isempty(intersectTable))
                   fprintf('Sorry, tables %s and %s have different schemas!\n', ...
                       table.name, table2.name);
               else
                   fprintf('...Created intersect table: %s...\n', intersectTable.name);
                   printTuplesList(intersectTable.tuples, intersectTable.schema);
                   database = storeTable(database, intersectTable);
               end
           case 6
               fprintf('\n%s\n', '--- Difference ---');
               fprintf('We will create a new table to diff with ''%s''\n', table.name);
               table2 = getUserTableSelection(database);
               diffTable = difference(table, table2);
               if(isempty(diffTable))
                   fprintf('Sorry, tables %s and %s have different schemas!\n', ...
                       table.name, table2.name);
               else
                   fprintf('...Created diff table: %s...\n', diffTable.name);
                   printTuplesList(diffTable.tuples, diffTable.schema);
                   database = storeTable(database, diffTable);                   
               end               
           case 7
               fprintf('\n%s\n', '--- Group By ---');
               fprintf('Enter an attribute to group by!\n');
               % Ask the user to input an attribute to group by
               attrib = input('Attrib: ', 's');
               isValidAttrib = validateAttribute(attrib, table.schema);
               if(isValidAttrib)
                  % Group the current table by the chosen attribute
                  groupTable = group(table, attrib);
                  printTuplesList(groupTable.tuples, groupTable.schema);
                  database = storeTable(database, groupTable);
               end               
           case 8    
               % Get a condition and print the satisfying tuples
               selectTuples(table.tuples, table.schema);
       end        
       saveDatabase(database);
       mtchoice = showModifyTableMenu(table.name);
    end
end

function groupTable = group(table, attrib)
% Purpose:  Performs a tuple grouping on the table based on the passed attrib.
% Returns:  A table containing the grouped tuples.
% Notes:    Since we don't allow aggregation, the tuples in the grouped table will
%           simply be sorted. Metatuples will not be employed as it will 
%           render the table/view unusable by the rest of the program.

    groupTable = Table();
    groupTuples = [];
    tuples = table.tuples;
    % Fetch the column for the attrib
    attribVals = getTupleColumnValues(tuples, attrib);
    
    % Grab the unique values
    uvals = unique(attribVals);
    
    % For each unique value
    for k = 1: numel(uvals)
        % Get the cell for the current value
        val = uvals(k);
        
        % Find the location of the tuples with that value
        idx = ismember(attribVals, val);
                
        % Grab the tuples that contain the current value
        valTuples = tuples(idx);
        
        % Append those tuples to the groupedTuples
        if(isempty(groupTuples))
            groupTuples = valTuples;
        else
            groupTuples = [groupTuples; valTuples];
        end
    end
    
    groupTable.tuples = groupTuples;
    groupTable.name = [table.name ' GROUPED BY ' attrib];
    groupTable.schema = table.schema;
end

function tuplesList = deleteTuples(tuples, schema)    
    % Ask the user for a condition
    fprintf('\n--- Delete Tuples ---\n');
    fprintf('Please enter a condition for which adhering tuples will be deleted!\n');
    fprintf('We only accept single conditions with no boolean operators!\n');
    fprintf('Type ''done'' when finished!\n');
    printTuplesList(tuples, schema);
    
    while(true)
        row = input('Condition: ', 's'); 
        if(strcmpi(row, 'done')) break; end
        % Parse the input into strings
        tokenized = textscan(row, '%s');
        tokenized = tokenized{:};
        numTokens = numel(tokenized(:,1));
        
        % Check if there's a valid number of clauses
        if(~isValidNumberConditions(numTokens)) continue; end
        
        % Parse the input into a condition
        condition = parseConditionInput(tokenized);  
        
        % Delete tuples based on that condition
        tuples = deleteTuplesForCondition(tuples, condition); 
        printTuplesList(tuples, schema);
    end
    tuplesList = tuples;
end

function tuplesList = deleteTuplesForCondition(tuples, condition)
% Purpose:  Deletes tuples from the passed list based on the tuples that adhere to the
%           passed condition.
% Returns:  A list of tuples that do not satisfy the condition. The tuples that did
%           satisfy the condition were deleted.
    tuplesList = tuples;
    % Get the indices where the condition holds in the tuples list
    [~, idx] = selectbycondition(tuples, condition);
    % Delete the tuples that satisfied the condition.
    tuplesList(idx) = [];    
end

function selectTuples(tuples, schema)
% Purpose:  Captures conditions from the user and prints/selects tuples from the 
%           current table's set of tuples that satisfy the condition.
% Notes:    This function simply prints the values and doesn't store them in a view.
    % Ask the user for a condition
    fprintf('\n--- Select Tuples By Condition ---\n');
    fprintf('Please enter a condition for which adhering tuples will be printed!\n');
    fprintf('We only accept single conditions with no boolean operators!\n');
    fprintf('Type ''done'' when finished!\n');
    printTuplesList(tuples, schema);
    
    while(true)
        row = input('Condition: ', 's'); 
        if(strcmpi(row, 'done')) break; end
        % Parse the input into strings
        tokenized = textscan(row, '%s');
        tokenized = tokenized{:};
        numTokens = numel(tokenized(:,1));
        
        % Check if there's a valid number of clauses
        if(~isValidNumberConditions(numTokens)) continue; end
        
        % Parse the input into a condition
        condition = parseConditionInput(tokenized);  
        
        % Select tuples based on that condition
        [stups, ~] = selectbycondition(tuples, condition); 
        printTuplesList(stups, schema);
    end
    
end

function [tuplesList idx] = selectbycondition(tuples, condition)
% Purpose:  Finds and returns all tuples that adhere to the passed condition 
% Precond:  condition is a single condition, not a chain.
% Returns:
%           tuplesList: list of tuples satisfying the condition.
%           idx:        the location of the tuples satisfying the condition within
%                       the passed tuples list.
    % Get the struct
    if(iscell(condition)) condition = condition{:}; end
    
    attrib = condition.lhs;
    op = condition.operator;
    val = condition.rhs;
    
    % Add single quotes to val for eval()
    isDigit = sum(isstrprop(val, 'digit')) == numel(val);
    if(~isDigit)
       val = ['''' val '''']; 
    end
    
    
    % Add single quotes to string values for eval()
    attribVals = getTupleColumnValues(tuples, attrib);   
    % Holds the generated condition strings
    states = cell(numel(attribVals), 1);
    
    for k = 1 : numel(attribVals)
        v = attribVals{k};
        isDigit = sum(isstrprop(v, 'digit')) == numel(v);
        if(~isDigit)
           attribVals{k} = ['''' v '''']; 
        end
        
        if(strcmpi(op, '=='))
            states{k} = ['isequal(' attribVals{k} ',' val ')'];        
        elseif(strcmpi(op, '<>'))
            states{k} = ['~isequal(' attribVals{k} ',' val ')'];
        else
            states{k} = [attribVals{k} op val];
        end
    end
    
    
    
    % Construct a cell matrix of condition string using each of the vals
%     states = cellfun(@(aval) [aval op val], attribVals, 'UniformOutput', false);
    % Determine whether or not the conditions hold
    results = cellfun(@eval, states, 'UniformOutput', false);
    
    % Get cell of strings for the results for ismember()
    resultsString = cellfun(@(r) num2str(double(r(1))), results, 'UniformOutput', false);
    % Get the locations that of values that satisfied the condition
    % Since we grabbed the attrib column, the indices map to the original tuple list
    idx = ismember(resultsString, {'1'});
    
    % Grab the tuples whose attribute satisfied the condition
    tuplesList = tuples(idx);    
end

function joinedTable = crossJoin(table, table2)
% Purpose:  creates a view containing the cross join of two tables. A view is a table
%           with no constraints that's added to the database.
% Precond:  database: cell matrix of table structs
%           table: currently selected table
% Notes:    users can cross join with the current table as well        
    % Rename attributes if they match for both tables
    t1attribs = keyset2char(table.schema.keySet());
    t1types = getTypesFromSchema(table.schema);
    
    t2attribs = keyset2char(table2.schema.keySet());
    t2types = getTypesFromSchema(table2.schema);
    
    joinedTypes = [t1types t2types];
    sameAttribs = strcmpi(t1attribs, t2attribs);
    if(sameAttribs)
        % Rename t2's attributes by offsetting the letter by 7 letters
        % A becomes G, B becomes H, etc.
        % We can't add single quotes (prime it) because indexing works on chars
        % Hopefully, the user doesn't put Z has an attrib
        t2attribsprime = arrayfun(@(attrib) char(attrib + 7), t2attribs, 'UniformOutput', false);
        % Get a string representation
        t2attribsprime = [t2attribsprime{:}];
    else
        t2attribsprime = t2attribs;
    end
    
    t1tuples = table.tuples;
    t2tuples = table2.tuples;
    
    % Store t1's tuples
    joinedTuples = struct();
    joinedAttribs = [t1attribs t2attribsprime];

    joinedName = [table.name ' CROSS ' table2.name];
    counter = 1;
    % Each tuple needs to index t2's values by t2's attributes
    for k = 1: numel(t1tuples(:,1))
        % The current joined tuple to be extended
        tuple = t1tuples(k);
        % Build the extended tuple
        for m = 1: numel(t2tuples(:,1))
            extTuple = tuple;
            t2tuple = t2tuples(m);
            % For each t2 attribute
            for j = 1:numel(t2attribsprime)
                originalattrib = t2attribs(j);
                attribprime = t2attribsprime(j);
                % Get the value for the attrib in t2's current tuple
                t2val = t2tuple.(originalattrib);
                % Index the val into the joined tuple with 
                extTuple.(attribprime) = t2val;
            end  
            % Avoids assignment mismatch
            if(isempty(fieldnames(joinedTuples(1))))
                joinedTuples = extTuple;
                counter = counter + 1;
            else
                % Store the extended joined tuple
                joinedTuples(counter, 1) = extTuple;
                counter = counter + 1;
            end
        end        
    end
    
    % Create a new table based on the joined data
    % No constraints will be added to this new table
    joinedTable = Table();
    for k = 1:numel(joinedAttribs)
        attrib = joinedAttribs(k);
        type = joinedTypes{k};
        joinedTable.schema.put(attrib, type);
    end
    joinedTable.tuples = joinedTuples;
    joinedTable.name = joinedName;
end

function natJoinTable = naturalJoin(table, table2)
% Purpose:  creates a view containing the cross join of two tables. A view is a table
%           with no constraints that's added to the database.
% Notes:    users can cross join with the current table as well    
    t1attribs = keyset2char(table.schema.keySet());
    t1types = getTypesFromSchema(table.schema);
    t1tuples = table.tuples;
    
    t2attribs = keyset2char(table2.schema.keySet());
    t2types = getTypesFromSchema(table2.schema);
    t2tuples = table2.tuples;
    
    % Get the location of matching attributes
    idx = ismember(t1attribs, t2attribs);
    matchingAttribs = t1attribs(idx);
    
    t1colvals = cell(1);
    t2colvals = cell(1);
    for k = 1: numel(matchingAttribs)
        a = matchingAttribs(k);
        % Get the column values for the matching attributes
        t1cola = getTupleColumnValues(t1tuples, a);
        t2cola = getTupleColumnValues(t2tuples, a);
        
        %Add these to their respective lists
        t1colvals{k} = t1cola;
        t2colvals{k} = t2cola;
    end
    
    % Combine the attribute columns into a single cell matrix
    t1colvals = [t1colvals{:}];
    numt1tuples = numel(t1colvals(:,1));
    numt1cols = numel(t1colvals(1,:));
    t2colvals = [t2colvals{:}];
    numt2tuples = numel(t2colvals(:,1));
    numt2cols = numel(t2colvals(1,:));
    
    % Combine the rows of the new cell matrix into strings
    % Do each separately since they're not guaranteed to have the same number of
    % tuples.
    
    t1rowstrings = cell(numt1tuples, 1);
    t2rowstrings = cell(numt2tuples, 1);
    % For each tuple
    for j = 1:numt1tuples
        rowstring = [];
        % For each value in the current tuple
        for k = 1: numt1cols
            val = t1colvals(j, k);
            if(iscell(val)) val = val{:}; end                
            if(isempty(rowstring))
                rowstring = val;
            else
                rowstring = [rowstring ',' val];
            end           
        end
        t1rowstrings{j, 1} = rowstring;
    end
    % This should be a function, but to hell with it
    for j = 1: numt2tuples
        rowstring = [];
        % For each value in the current tuple
        for k = 1: numt2cols
            val = t2colvals(j, k);
            if(iscell(val)) val = val{:}; end                
            if(isempty(rowstring))
                rowstring = val;
            else
                rowstring = [rowstring ',' val];
            end           
        end
        t2rowstrings{j, 1} = rowstring;
    end
    % Get the locations of the matching tuples
    idx = ismember(t1rowstrings, t2rowstrings);
    
    % Extract the matching tuples
    % We're assuming that the nat join should just produce tuples from the first
    % table where the first and table have similar attributes and attribute vals.
    natTuples = table.tuples(idx);
    
    % Add the matching tuples to the newly created table
    natJoinTable = Table();
    natJoinTable.name = [table.name ' NATJOIN ' table2.name];
    for k = 1:numel(t1attribs)
       attrib = t1attribs(k);
       type = t1types{k};
       natJoinTable.schema.put(attrib, type);
    end
    natJoinTable.tuples = natTuples;
end

function unionTable = union(table1, table2)
% Purpose:  Computes the union of the two passed tables and returns a table/view with
%           tuples representing the unioned data.
% Returns:  A table instance representing the union of the two tables.
% Notes:    You can only perform union on tables with matching schemas.
%           The union is defined as the unique tuple combination of the two tables.
    unionTable = [];
    if(~tableSchemasEqual(table1, table2)) return; end
    
    % Combine Tuples
    combined = combineTuples(table1.tuples, table2.tuples);
    combstrs = tuples2strings(combined);
    [~, m, ~] = unique(combstrs);
    uniqueTuples = combined(m);
    
    % Populate the unionTable attributes
    unionTable = Table();
    unionTable.name = [table1.name ' UNION ' table2.name];
    unionTable.tuples = uniqueTuples;
    unionTable.schema = table1.schema;
end

function intersectTable = intersection(table, table2)
% Purpose:  Computes the intersection of the two tables by observing that the
%           intersection of two tables is the natural join of the two tables with the 
%           stipulation that the two tables must have the same schemas.
% Returns:  A table whose 
    intersectTable = [];
    
    if(tableSchemasEqual(table, table2))
       intersectTable = naturalJoin(table, table2); 
       intersectTable.name = [table1.name ' INTERSECT ' table2.name];
    end    
end

function diffTable = difference(table1, table2)
% Purpose:  Computes the difference of the two tables by removing the tuples of 
%           table2 from the tuples of table1. 
% Returns:  A table similar to table1 with the tuples equal to that of 
%           tuples of table2 removed.
    diffTable = [];
    if(~tableSchemasEqual(table1, table2)) return; end
    
    natJoinTable = naturalJoin(table1, table2);
    natJoinTuples = natJoinTable.tuples;
    
    % Diff Tuples = combinedTuples - natJoinTuples
    diffTuples = tupleDifference(table1.tuples, natJoinTuples);
    
    diffTable.tuples = diffTuples;
    
    diffTable.name = [table1.name ' - ' table2.name];
    diffTable.schema = table1.schema;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   Helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function difference = tupleDifference(tuples1, tuples2)
% Purpose: Subtracts the tuples of tuples 2 from tuples1.
    difference = tuples1;
    for k = numel(tuples2)
       curTuple = tuples2(k);
       difference = removeTuple(curTuple, difference);
    end
end

function tuples = removeTuple(tuple, tupleList)
% Purpose: Removes every instance of the tuple from the list of tuples
% Precond: Tuples should be a struct array
% Returns: An array of tuples without the passed tuple (if exists)
    tuples = tupleList;
    numTuples = numel(tupleList);
    for k = 1:numTuples
        curTuple = tupleList(k);
        exists = isequal(tuple, curTuple);
        if(exists)
            % Delete the current tuple from the returned list of tuples.
            tuples(k) = [];
        end            
    end
end

function combined = combineTuples(tuples1, tuples2)
% Purpose: Combines the tuples sets into one vertically large tuple set.
% Precond: tuples1 and tuples2 should have the same schemas (attributes/columns).
% Returns: A Kx1 structure array of tuples, where K = numel(tuples1) + numel(tuples2)
    combined = [tuples1; tuples2];
end

function B = tableSchemasEqual(table, table2)
% Purpose:  Checks if the schemas (attributes and datatypes)
%           of the two tables are identical.
% Returns:  True if the schemas are equal, false otherwise.
    t1attribs = keyset2char(table.schema.keySet());
    t2attribs = keyset2char(table2.schema.keySet());
    t1types = getTypesFromSchema(table.schema);
    t2types = getTypesFromSchema(table2.schema);
    attribsAgree = strcmpi(t1attribs, t2attribs);
    typesAgree = sum(ismember(t1types, t2types)) == numel(t1types);
    B = attribsAgree && typesAgree;    
end