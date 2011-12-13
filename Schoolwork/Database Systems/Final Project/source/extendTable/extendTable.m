% Author:   Joel Kemp, mrjoelkemp@gmail.com
% Project:  Database Systems 1, Fall 2011 Final Project
% File:     extendTable.m
% Purpose:  Allows a user to extend the table by adding constraints
%           and tuples to an existing table in the database.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Entry Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function database = extendTable(database, table)
% Purpose:  Faciltaties the extending of a table identified by the passed
%           tableName in the passed database collection of table structs.
% Preconds: 
%           table: The table structure to be modified
% Returns:  The modified table structure with included constraints, and tuples.

    temchoice = showTableExtensionMenu();
    while(temchoice ~= 3)
        switch temchoice
            case 1 % Add Constraints
                [database, table] = constraints(database, table);
            case 2 % Add Tuples
                table.tuples = inputTuples(table.tuples, table.constraints, table.schema);
                printTuplesList(table.tuples, table.schema);
        end
        index = getTableIndex(database, table.name);
        database{index} = table;
        saveDatabase(database);
        temchoice = showTableExtensionMenu();
    end
end

function choice = showTableExtensionMenu()
% Purpose: Shows the table extension menu and returns the user's choice
% Returns: The integer value of the user's choice
    fprintf('\n%s\n', '--- Table Extension Menu ---');
    fprintf('%s\n', '1. Add Constraints (Conditions, FDs, MVDs, Keys)');
    fprintf('%s\n', '2. Add Data Tuples');
    fprintf('%s\n', '3. DONE');
    choice = getValidMenuChoice(1, 3);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Tuple Helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function tuplesList = inputTuples(tuples, constraints, schema)
% Purpose:  Grabs tuple input from the user as a row of values
% Precond:  tuples: a column array of structures. NOT A CELL MATRIX!
% Returns:  A kx1 array of structs where k is the number of supplied tuples.
%           The structs are dynamically created based on the attributes for the
%           table. This was done due to the fact that keeping a simple row vector of
%           strings (a string per attribute) was troublesome; it is impossible to
%           keep an array like ['5' 'Joel' '20'] without the automatic conversion to
%           ['5Joel20']. 
%           
%           To avoid this concatenation, we create a tuple struct where
%           the number of members is equal to the number of attributes for the table.
%           We can then access and write to the struct dynamically!
% 
%           tuples is initialized with an empty struct, so it's not "empty" but it
%           shouldn't be considered to have an existing element. We can detect the empty
%           struct using the fieldnames() function that returns a set of field names for
%           the given struct. This will yield the empty set when called on the first tuple.

    counter = 1; % Storage location
    
    % Check if tuples contains previous tuples
    if(~isempty(fieldnames(tuples(1))))
        counter = numel(tuples(:,1)) + 1;
    end
    
    fprintf('\n%s\n', '--- Add Data Tuples ---');
    fprintf('%s\n', 'Enter ''done'' when finished.');

    % Output a pretty list of the attributes to guide user input
    attribs = keyset2char(schema.keySet()); 
    fprintf('\t');   
    printPrettyAttributes(attribs);
    
    % Get the datatypes of all of the attributes in the table
    types = arrayfun(@(attrib) schema.get(attrib), attribs, 'UniformOutput', false);
        
    while(true)
        tuple = input('Tuple: ', 's');
        if(strcmpi(tuple, 'done')) break; end
        
        % Parse the input into strings
        tokenized = textscan(tuple, '%s');
        % We want row vectors, so transpose
        tokenized = tokenized{:};        
        
        %Check if the proper number of values has been provided
        if(~hasEnoughValues(tokenized, attribs)) continue; end        
        
        % Check if each input is valid for the type of its associated attrib
        if(violatesTypes(tokenized, types, attribs)) continue; end
        
        % Convert the tokens into a tuple struct
        tuple = getTupleFromStrings(tokenized, attribs);         
        
        % Check if the tuple violates the constraints
        if(violatesConstraints(tuple, tuples, constraints, attribs, schema)) continue; end
        
        if(counter == 1)
            tuples = tuple; % Avoids struct assignment mismatch
        else
            tuples(counter, 1) = tuple;
        end
        counter = counter + 1;
        printTuplesList(tuples, schema);
    end
    tuplesList = tuples;
end

function B = hasEnoughValues(tokens, attribs)
% Purpose: Determines if the passed tokens have a value for every attribute.
% Returns: True if the tuple has enough values, false otherwise.
    B = true;
    if(numel(tokens) ~= numel(attribs)) 
        fprintf('Tuple is missing data.\n');
        B = false;
    end
end

function B = violatesTypes(tokens, types, tableAttribs)
% Purpose:  Checks if each value in the set of tokens agrees with the 
%           type pertaining to the attributes associated with each datum in the tuple.
% Precond:  tokens: cell matrix
%           types: cell matrix
%           tableAttribs: char array (since attribs are single, uppercase chars)
% Example: 
%           Tuple: [9, 'Joel', 20];
%           Types: [int, string, int];
%           Each datum agrees with the type, so this tuple does not violate types.
% Returns:  True if the tuple violates the datatypes, false otherwise.
    B = false;
    
    for k = 1: numel(types)
       type = types{k};
       value = tokens{k};
       attrib = tableAttribs(k);
       % Check the datatype for the attribute
       if(strcmpi(type, 'int'))
           % Check if all chars in the value are numbers
           isDigit = sum(isstrprop(value, 'digit')) == numel(value);
           if(~isDigit)
               fprintf('%s is not valid for attribute %s of type %s\n', value, attrib, type);
               B = true;
           end
       elseif(strcmpi(type, 'string'))
           % Check if the value is a string
           isAlphaNum = sum(isstrprop(value, 'alphanum')) == numel(value);
           if(~isAlphaNum)
               fprintf('%s is not valid for attribute %s of type %s\n', value, attrib, type);
               B = true;
           end
       end       
    end
end

function B = violatesConstraints(tuple, tuples, constraints, attribs, schema)
% Purpose:  Checks if the passed tuple violates the constraints in relation to the
%           other tuples in the passed set. Checks against the conditions, fds, 
%           and mvds.
% Precond:  constraints: Constraint struct containing conditions, fds, mvds, and keys
%           tuple: dynamic structure where members are indexed by attribs
% Returns:  True if the tuple violates the constraints
    B = false;
    tuples2 = tuples;   % Working copy
    keys = constraints.keys;
    conditions = constraints.conditions;
    fds = constraints.fds;
    mvds = constraints.mvds;
    
    % Add the tuple to the set of tuples to see if there are potential violations
    % We know that the current set of tuples are valid, so any violations are a
    % result of the newly added tuple.
    
    % If we don't use different subscripts, we have a dimension mismatch...
    if(isempty(fieldnames(tuples2)))
        tuples2 = tuple;
    else
        numTuples = numel(tuples2(:,1));
        tuples2(numTuples + 1, 1) = tuple;
    end
    
    
    % Check tuple against set of conditions
    % For conditions, you only care about the tuple in question, not the existing set
    % of tuples. We know that each tuple in the set of tuples had been checked for
    % violating conditions.
    if(violatesConditions(tuple, conditions)) 
        B = true;
        return;
    end
    
    % If the set of tuples only contains a single element, then there's no way that
    % it can violate the keys, fds, nor mvds!
    if(numel(tuples2) ~= 1)         
        % Check tuples against set of keys
        if(violatesKeys(tuples2, keys, attribs)) 
            B = true; 
            return;
        end

        % Check tuple against set of fds
        if(violatesFDs(tuples2, fds))
            B = true;
            return;
        end
        
        % Check tuples against the set of mvds
        if(violatesMVDs(tuples2, mvds, schema))
            B = true;
            return;
        end
    end    
end

function B = violatesKeys(tuples, keys, attribs)
% Purpose:  Checks whether or not the tuples violate the keys.
% Returns:  True if the tuples violate the keys, false otherwise.
    B = false;
    numTuples = numel(tuples(:,1));
    for k = 1: numel(keys(:,1))
        key = keys{k};
        % Get the attribute column indices corresponding to the key
        idx = ismember(attribs, key);
        % Get the columns values for the attribs in the key
        columns = cell(1, sum(idx));
        counter = 1;
        for j = 1:numel(idx)
            attrib = attribs(j);
            if(idx(j) == 0) continue; end             
            % Get the column of values where idx is 1
            vals = getTupleColumnValues(tuples, attrib);
            % Store in a row vector
            columns{counter} = vals;
            counter = counter + 1;
        end
        
        % If there are duplicate rows, then the tuples violates the keys
        % The idea here is that you can simply join all of the columns together to
        % create a combined column of keys. If any rows in this combined column are 
        % duplicates, then there are duplicate keys, which is not allowed!
        combined = cell(numTuples, 1);       
        for j = 1 : numTuples           
            % for each column, concatenate its value to the row
            for m = 1: numel(columns)
                col = columns{m};
                if(isempty(combined{j,1}))
                    combined{j,1} = col{j,1};
                else
                    combined{j,1} = [combined{j,1} ',' col{j,1}];
                end
            end
        end
        
        % Get the unique rows of combined
        urows = unique(combined);
        hasDuplicate = numel(urows) ~= numTuples;
        % If the number of unique rows is smaller than the total # rows
        if(hasDuplicate)
            % We have a duplicate!
            fprintf('Duplicate tuple for key %s detected!\n', key);
            fprintf('...Ignoring Duplicate...\n');
            B = true;
            return;
        end
    end
end

function B = violatesConditions(tuple, conditions)
% Purpose:  Checks whether or not the tuple's data violates the conditions.
% Returns:  True if the tuple violates the conditions, false otherwise.
% Notes:    Chained conditions have at most one boolean operator!
    B = false;
    for k = 1 : numel(conditions(:,1))
       cond = conditions{k};
       isChain = numel(cond) ~= 1;
       
       if(~isChain)
           % Check if tuple violates the condition
           violates = violatesCondition(tuple, cond);
           if(violates) 
               B = true;
               c = cond{:};
               fprintf('Condition ''%s %s %s'' violated for value %s for attribute %s!\n',...
                    c.lhs, c.operator, c.rhs, tuple.(c.lhs), c.lhs);
               return;
           end
       %Otherwise it's a chain
       else
           % Get the boolean operator
           boolOp = extractBooleanOperatorsFromChain(cond);
           % Extract the conditions  
           chainConds = extractConditionsFromChain(cond);
           numChainConds = numel(chainConds);
           tups = repmat({tuple}, 1, numel(chainConds));
           % Check each condition for violations.
           violations = cellfun(@violatesCondition, tups, chainConds, 'UniformOutput', true);
           numViolations = sum(violations);
           andViolated = 0;
           orViolated = 0;
           if(isequal(boolOp, {'AND'}))
               % If a condition was violated, then the AND was violated
               andViolated = numViolations ~= 0;               
           % Otherwise, the boolean operator is an 'OR'
           else               
               % If at least 1 passes, then the OR is not violated!                
               orViolated = numViolations == numChainConds;
           end
           if(andViolated || orViolated)
               B = true;
               fprintf('Condition violated: ');
               printConditionChain(cond);
               return;
           end
       end
    end
end

function B = violatesCondition(tuple, condition)
% Purpose:  Checks if the passed tuple struct violates a single condition.
% Precond:  Condition is a Condition structure.
% Returns:  True if the tuple violates the condition, false otherwise.
% Notes:    We have to change <> to ~= to be a valid matlab operator
%           If the datatype is non-numeric, then we need to wrap the vals in quotes.
    B = false;
    
    % If it's a cell, de-nest it to get the struct
    if(iscell(condition)) condition = condition{:}; end
    
    attrib = condition.lhs;
    
    op = condition.operator;
    
    condVal = condition.rhs;
    isDigit = sum(isstrprop(condVal, 'digit')) == numel(condVal);
    if(~isDigit) 
        % Wrap in single quotes
        condVal = ['''' condVal ''''];
    end
        
    % Tuple for value for the condition's attrib
    valForAttrib = tuple.(attrib);
    isDigit = sum(isstrprop(valForAttrib, 'digit')) == numel(valForAttrib);
    if(~isDigit) 
        % Wrap in single quotes
        valForAttrib = ['''' valForAttrib ''''];
    end
    
    % String to test the condition
    % Example:  Condition = A > 5
    %           tuple.A = 5
    %           S = '5 > 5'  
    % Strings have to be of equal length unless we use the isequal() function.
    % We can use this for numbers and strings, so we create the appropriate string
    % based on the boolean operator.
    if(strcmpi(op, '=='))
        S = ['isequal(' valForAttrib ',' condVal ')'];
    elseif(strcmpi(op, '<>'))
        S = ['~isequal(' valForAttrib ',' condVal ')'];
    else
        S = [valForAttrib op condVal];
    end
    
    isValid = eval(S);
    
    if(~isValid)
%        fprintf('Condition ''%s %s %s'' violated for value %s for attribute %s!\n',...
%            attrib, condition.operator, condition.rhs, tuple.(attrib), attrib);
       B = true;
    end
end

function B = violatesFDs(tuples, fds)
% Purpose:  Checks if the tuples list violates the list of fds.
% Returns:  True if the tuples violate the fds, false otherwise.
% Notes:    An FD is violated when tuples agree on the lhs but not on the rhs.
%           This only assumes single attrib lhs.
    B = false;
    
    % For each FD
    for k = 1: numel(fds(:,1))
        fd = fds{k};
        % Get attribs associated with the fd
        lhs = fd.lhs;
        rhs = fd.rhs;        
        lhsCol = getTupleColumnValues(tuples, lhs);
        rhsCol = getTupleColumnValues(tuples, rhs);        
        % Find all the repeating values
        % unique() wouldn't work well.
        repeats = cell(1);
        counter = 1;
        for m = 1 : numel(lhsCol)
           val = lhsCol{m};
           idx = ismember(lhsCol, {val});
           isRepeat = sum(idx) > 1;
           
           if(isempty(repeats{1})) 
               alreadyThere = false;
           else
               alreadyThere = ismember({val}, repeats) > 0;
           end
           
           if(isRepeat && ~alreadyThere)
               repeats{counter} = val;
               counter = counter + 1;
           end
        end        
        
        if(isempty(repeats{1})) continue; end
        
        % For each repeat
        for j = 1: numel(repeats)
            rval = repeats{j};
            % Get the locations for the current repeat within the lhs
            idx = ismember(lhsCol, {rval});
            % Pull out the values from the rhs for the current repeat
            rhsVals = rhsCol(idx == 1);
            u = unique(rhsVals);
            % If you can get more than 1 unique value, then the rhs 
            % didn't have the same values. Unique() returns at least 1 element, even
            % if the set is all duplicates.
            fdViolated = numel(u) > 1;
            if(fdViolated)
               fprintf('FD Violated: %s -> %s\n', lhs, rhs); 
               B = true;
               return;
            end
        end        
    end    
end

function tuple = getTupleFromStrings(tokenized, attribs)
% Purpose:  Takes in a column cell matrix of strings pertaining to the user's supplied
%           tuple values and returns a dynamic structure (based on the table's attribute
%           listing) that stores each value in the corresponding column.
% Returns:  A structure representing a tuple.
% Format:   If the attribs for the table are ABC with tokens: ['5';'Joel';'20'] then
%           the created structure is as follows:
%           tuple.A = '5';
%           tuple.B = 'Joel';
%           tuple.C = '20';
%
%           The tuple has members corresponding to the attributes and values for
%           those members equal to the values supplied for the respective columns.
%
%           You can visualize tuple like:
%             A      B       C
%          [ '5' | 'Joel' | '20' ]
    tuple = struct();
    for k = 1:numel(attribs)
        attrib = attribs(k);
        tuple.(attrib) = tokenized{k};
    end
end