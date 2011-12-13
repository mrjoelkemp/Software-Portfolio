% Author:   Joel Kemp, mrjoelkemp@gmail.com
% Project:  Database Systems 1, Fall 2011 Final Project
% File:     constraints.m
% Purpose:  Allows a user to define constraints (conditions, FDs, and MVDs)
%           for an existing table in the database.
% Returns:  A modified table structure with the captured constraints.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Entry Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [database table] = constraints(database, table)
% Purpose:      Adds a list of constraints
% Precondition: table is the current table structure. We use this to verify the
%               attributes included in the constraints.
% Returns:      The modified table with the inclusion of the constraints.
%               The modified database containing the newly modified table.

    % Grab the existing set of constraints
    % Table initialized with Constraint() obj, so we're safe.
    constraints = table.constraints;
  
    cmchoice = showAddConstraintsMenu(table.name);
    while(cmchoice ~= 5)
        switch cmchoice
            case 1 % Boolean Conditions
                printAttributeList(table.name, table.schema);
                constraints.conditions = inputBooleanConditions(constraints.conditions, table.schema);                                  
                fprintf('Conditions saved...\n');   
                printConditionList(constraints.conditions);
            case 2 % FDs
                constraints.fds = inputFunctionalDependencies(constraints.fds, table.schema); 
                fprintf('FDs saved...\n');
                printFDList(constraints.fds);
            case 3 % MVDs
                if(isempty(constraints.fds))
                    fprintf('You need to define FDs first!\n');
                else
                    printAttributeList(table.name, table.schema);                
                    printFDList(constraints.fds);
                    constraints.mvds = inputMultiValueDependencies(constraints.mvds, constraints.fds, table.schema);
                    fprintf('MVDs saved...\n');   
                    % Check if the table is 4th normal form!
                    constraints.mvds = is4thNormalForm(constraints.mvds, constraints.fds, table.schema);
                    printMVDList(constraints.mvds);
                end
            case 4 % Keys
                printAttributeList(table.name, table.schema);   
                if(~isempty(constraints.fds))
                    printFDList(constraints.fds);
                end
                constraints.keys = inputKeys(constraints.keys, constraints.fds, table.schema);
                if(~isempty(constraints.keys))
                    printKeyList(constraints.keys);   
                end
        end
        table.constraints = constraints;
        % Save the changes
        index = getTableIndex(database, table.name);
        database{index} = table;
        saveDatabase(database);
        cmchoice = showAddConstraintsMenu(table.name);
    end    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Boolean Condition Helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function conditions = inputBooleanConditions(conds, schema)
% Purpose:  Allows the user to input boolean conditions and returns a list of
%           the conditions as a 3-element structure.
% Returns:  A cell matrix of Condition structures, one for each 
%           user-defined boolean condition.
% Note: 
%           Validation is not done in this function. We only allow the user to
%           define the conditions and afterward, we check for validity and
%           overlapping/redundant conditions. 
%           
%           This function checks for basic validation:
%               1. Incorrect Syntax
%               2. Duplicate Conditions
%               3. Non-existent Attributes: Requires schema
%           The real validation is done in validateBooleanConditions().
%
%           If either of the aforementioned validation checks are false, then the
%           function continues to loop, asking the user to re-enter their
%           condition.
%
%           We don't support operator precedence nor parentheses, 
%           so A < 5 AND A > 2 OR A > 1 is not allowed.
%           Similarly, we suggest grouping conditions by attribute:

    conditions = conds;   
    counter = 1;               % Next Storage location
    if(~isempty(conditions)) 
        counter = numel(conditions(:,1)) + 1;
    end
    
    fprintf('\n%s\n', '--- Boolean Conditions ---');
    fprintf('%s\n','Supported Operators: <, >, <>, ==, <=, >=, AND, OR');
    fprintf('%s\n', 'Enter ''done'' when finished.');
    while(true)
        row = input('Condition: ', 's');
        % Entering 'done' ends the definition.
        if(strcmpi(row, 'done')) break; end
        
        % Parse the input into strings
        tokenized = textscan(row, '%s');
        tokenized = tokenized{:};
        numTokens = numel(tokenized(:,1));
        
        % Check if there's a valid number of clauses
        if(~isValidNumberConditions(numTokens)) continue; end
        
        % Parse the input into a list of conditions and boolean operators
        parsedConds = parseConditionInput(tokenized);        
        
        % Check if the parsed conditions have duplicates or duplicate existing conditions
        if(hasDuplicates(parsedConds, conditions)) continue; end
        
        % Check if all of the parsed conditions' attributes are valid
        if(~validateConditionAttributes(parsedConds, schema)) continue; end;
              
        % Validate logical operators and boolean operators
        if(~validateOperators(parsedConds)) continue; end
        
        % Verify that the operator is valid for the attribute's type
        if(~validateAttributeOperator(parsedConds, schema)) continue; end
       
        % Verify that the type of the rhs agrees with the attribute type
        if(~validateAttributeValue(parsedConds, schema)) continue; end
        
        % Check for overlapping conditions (HARD)
        if(~validateConflictingConditions(parsedConds, conditions, schema)) 
            printConditionList(conditions);
            continue; 
        end
        
        % Store the condition in the a column-wise conditions matrix
        conditions{counter, 1} = parsedConds;          
        counter = counter + 1;
        printConditionList(conditions);
    end
end

function B = validateConflictingConditions(condList, conditions, schema)
% Purpose:  Check if the condList has conflict with itself and other conditions.
% Precondition:
%           condList:   Parsed list of last entered, user-defined conditions
%                       condList contains conditions about a single attribute!
%           conditions: List of previously stored conditions.
%           schema:     Hashmap of attribute to datatype mapping
% Note:
%           Only the AND conditions can cause an conflict. Isolated conditions 
%           about the same attribute can also cause conflict.
    B = true;        
    % If the list is empty and there's a single condition, then there's nothing to check
    % Otherwise if it's empty but we have a chained condition, the list is the cond 
    % Otherwise, we have existing conditions, so append the cond or cond chain
    if((isempty(conditions) || isempty(conditions{1})) && numel(condList) == 1) 
        return;
    elseif(isempty(conditions) || isempty(conditions{1}))
        conditions{1} = condList;
    else
        conditions{numel(conditions) + 1, 1} = condList;
    end
    
    % Get the attribute in question
    % Since the condList deals with conditions about a single attribute, we don't
    %   have to worry about multiple attributes to check for.
    conds = extractConditionsFromChain(condList);
    attrib = conds{1}.lhs;  % Grab the first attribute
    type = schema.get(attrib);    
    
    % Grab all conditions (anded or isolated) in the set of conditions for the attrib
    % This implicitly adds conds to the list of conditions to be processed
    condsForAttrib = getAndedConditionsForAttribute(attrib, conditions);
        
    numConds = numel(condsForAttrib(:,1));
    % If there's only one condition, then nchoose2 will fail on input (1).
    if(numConds < 2) return; end
    
    % Set of values to prove conflict. Used in eval().
    % Arbitrarily large for possible RHS values
    matrix = -1000:1:1000;
    
    % Generate the set of unique pairings amongst the members of the set
    combs = nchoose2(1:numConds);
    for k = 1: numel(combs(:,1))
        curCombRow = combs(k, :);
        % Get combination conditions
        c1 = condsForAttrib{curCombRow(1)};
        c2 = condsForAttrib{curCombRow(2)};        
        if(strcmpi(type, 'int'))
%             statement = ['find(' 'matrix' c1.operator int2str(c1.rhs) ' & matrix' c2.operator int2str(c2.rhs) ');'];
            statement = ['find(' 'matrix' c1.operator c1.rhs ' & matrix' c2.operator c2.rhs ');'];
        
            % Get the member of matrix satisfying the joint condition
            a = eval(statement);
            % If the matrix is empty, then there's a conflict
            if(isempty(a))
                fprintf('Conflicting conditions: %s %s %s, %s %s %s\n', c1.lhs, c1.operator, c1.rhs,...
                    c2.lhs, c2.operator, c2.rhs);
                B = false;
                return;
            end
        elseif(strcmpi(type, 'string'))
            % If the operator for both conditions is ==, then the values can't be
            % different. B == 5 and B == 6 makes no sense.
            if(strcmpi(c1.lhs, c2.lhs) && strcmpi(c1.operator, c2.operator))
                fprintf('Conflicting conditions: %s %s %s, %s %s %s\n', c1.lhs, c1.operator, c1.rhs,...
                    c2.lhs, c2.operator, c2.rhs);
                B = false;
                return;
            % If the lhs and rhs sides match, the operators can't be different
            elseif(strcmpi(c1.lhs, c2.lhs) && strcmpi(c1.rhs, c2.rhs) && ~strcmpi(c1.operator, c2.operator))
                fprintf('Conflicting conditions: %s %s %s, %s %s %s\n', c1.lhs, c1.operator, c1.rhs,...
                    c2.lhs, c2.operator, c2.rhs);
                B = false;
                return;
            end       
       end
    end
end

function condsForAttrib = getAndedConditionsForAttribute(attrib, conditions)
% Purpose:  Gathers all of the conditions (isolated and ANDed) for the 
%           attribute passed within the list of conditions.
% Returns:  A column-wise cell matrix of conditions and condition chains pertaining
%           to the passed attribute. 
    condsForAttrib = cell(1,1);
    counter = 1;
    numRows = numel(conditions(:,1));
    for k = 1: numRows
        row = conditions(k, :);
        % If it's a cell, it is a chained condition, so get the insides, however deep
        if(iscell(row)) row = row{:}; end
        numClauses = numel(row);
        isChain = numClauses > 1;
        % If the row is an isolated condition
        if(~isChain)
            if(~isstruct(row)) row = row{:}; end
            % Check if it involves the attrib in question
            if(~strcmpi(row.lhs, attrib)) continue; end
            condsForAttrib{counter, 1} = row;    
            counter = counter + 1;
        % Else, if it's a chained condition
        else            
            % Store all the conditions separately for combinations
            if(containsBoolOpWithinConditionChain(row, 'AND'))
               cs = extractConditionsFromChain(row);
               for i = 1:numel(cs)
                   c = cs{i};
                   if(~isstruct(c)) c = c{:}; end
                   if(~strcmpi(c.lhs, attrib)) continue; end
                   condsForAttrib{counter, 1} = c;
                   counter = counter + 1; 
               end
            end
        end
    end

end

function B = containsBoolOpWithinConditionChain(condition, boolOp)
% Purpose:  Determines if the passed condition chain contains the passed boolean
%           operation.
% Precond:  boolOp can be 'AND' or 'OR'
% Returns:  True if the passed condition contains the boolOp, false otherwise.
    B = false;    
    numClauses = numel(condition);
    
    isChain = numClauses > 1;
    if(~isChain) return; end        
    
    % For each clause
    for j = 1:numClauses
        % Structs are conditions, not bool ops
        if(isstruct(condition{j})) continue; end
        
        if(ismember({boolOp}, condition(j)))    %Cell form of ismember
            B = true;
            break;
        end
    end
end

function B = validateAttributeValue(condList, schema)
% Purpose:  Checks if the condition's (RHS) value is valid for the attribute's type
% Returns:  True if all attribs and their values agree, false otherwise.
% Notes:
%           strings can have alphanumeric chars
%           int can only have numbers
    B = true;
    conds = extractConditionsFromChain(condList);
    for k = 1: numel(conds)
        c = conds{k};
        attrib = c.lhs;
        value = c.rhs;
        type = schema.get(attrib);

        if(strcmpi(type, 'int'))          
            % ASCII 39 is a single quote
            hasQuotes = ismember(char(39), value) > 0;
            % Whether or not the value represent a number
            % Two or more digits produce a vector of bools 
            isDigit = sum(isstrprop(value, 'digit')) == numel(value);

            if(hasQuotes || ~isDigit)
                fprintf('%s %s\n', 'Not a number:', value);
                B = false;
            end
            
        elseif(strcmpi(type, 'string'))
            isAlphaNum = isstrprop(value, 'alphanum');             
            if(~isAlphaNum)
                fprintf('%s %s\n', 'Not a string:', value);
                B = false;
            end
        end
    end
end

function B = validateAttributeOperator(condList, schema)
% Purpose:  Checks if each condition's operator is valid for the attribute's type
% Preconditions:
%           condList: list of conditions and boolean operators
%           schema: hashmap of attributes mapped to their datatypes
% Returns:  True if all attributes and operators agree, false otherwise.
% Notes:
%           strings can only use == and <>
%           ints can use all of the operators

    B = true;
    % Normally a cell of strings, but this works since the ops have same length
    stringOps = ['=='; '<>'];
    
    %Extract the conditions from the condList
    conds = extractConditionsFromChain(condList);
    for k = 1:numel(conds)
        c = conds{k};
        attrib = c.lhs;
        op = c.operator;
        type = schema.get(attrib);
        
        if(strcmpi(type, 'int')) continue; end
        
        isValid = ismember(op, stringOps, 'rows') > 0;
        
        if(isValid) continue; end
        
        fprintf('%s %s\n%s\n','Invalid String Operator:', op, 'Expected: == or <>');
        B = false;
        break;
    end
end

function B = validateOperators(condList)
% Purpose:  Validates the logical operators and boolean operators.
% Precondition:
%           condList is a cell matrix of conditions and boolean operators
% Returns:  True if the operators validate, false otherwise.
% Notes:    Boolean operators: 'AND' 'OR'
%           Logical Operators: <, >, <>, ==, <=, >=
    B = true;

    logicalOps = {'<'; '>'; '=='; '<>'; '<='; '>='};
    boolOps = {'AND'; 'OR'};
    
    % Validate the conditions' logical operators
    conds = extractConditionsFromChain(condList);
    for k = 1:numel(conds)
        op = conds{k}.operator;
        opValid = ismember(op, logicalOps) > 0;
        if(opValid) continue; end        
        fprintf('%s %s\n', 'Logical operator invalid:', op);
        B = false;
        return;          
    end
    
    % Validate the boolean operators separating the conditions
    bools = extractBooleanOperatorsFromChain(condList);
    for k = 1:numel(bools)
       bop = bools{k};
       bopValid = ismember(bop, boolOps) > 0;
       if(bopValid) continue; end
       fprintf('%s %s\n', 'Boolean operator invalid:', bop);
       B = false;
       return;
    end
end

function B = hasDuplicates(parsedConds, conditions)
% Purpose:  Checks if the parsed condition string has internal duplicate conditions
%           and whether or not the conditions of the parsed condition string duplicate
%           conditions in the passed condition list.
% Preconditions:
%           parsedConds: Cell matrix of conditions and boolean op strings ('AND', 'OR')
%           conditions: A list of conditions and boolean operators
% Returns:  True if there was a duplicate, false otherwise.
    B = false;
    % Extract the structures from the condition string
    conds = extractConditionsFromChain(parsedConds);
    numConds = numel(conds);
    
    % If there are no other conditions, just do an internal check for dups
    if(isempty(conditions) || isempty(conditions{1}))
        for k = 1: (numConds - 1)  %-1 since we're looking at the neighbors
            c = conds{k};
            rest = conds((k+1):end);
            % Current condition is found again in the condition string or 
            % in the existing list of conditions
            internalDup = isDuplicate(c, rest);           
            if(~internalDup) continue; end
            fprintf('%s %s %s %s\n', 'Duplicate condition:', c.lhs, c.operator, c.rhs);
            B = true;           
        end
        return;
    end
    
    numConditionsInList = numel(conditions(:,1));
    for j = 1:numConditionsInList
        curCondition = conditions{j};
        % Extract the structures from the condition list
        curConditionStructList = extractConditionsFromChain(curCondition);
        % Check if the multiple condition string has internal duplicates 
        for k = 1: numConds
           c = conds{k};
           % If the parsed condition is chained, then check for internal dups
           if(numConds > 1)
               rest = conds((k+1):end);
               % Current condition is found again in the condition string or 
               % in the existing list of conditions
               internalDup = isDuplicate(c, rest);
               if(internalDup)
                   fprintf('%s %s %s %s\n', 'Duplicate condition:', c.lhs, c.operator, c.rhs);
                   B = true;
                   return;
               end
           end
           dupWithOthers = isDuplicate(c, curConditionStructList);
           if(dupWithOthers)
               fprintf('%s %s %s %s\n', 'Duplicate condition:', c.lhs, c.operator, c.rhs);
               B = true;
               return;
           end          
        end   
    end
end

function B = validateConditionAttributes(parsedConds, schema)
% Purpose:  Checks whether or not the parsed condition string's conditions contain
%           attributes that exist in the table's schema.
% Returns:  True if the attributes validate, false otherwise.
    B = true;
    % Extract the structures from the condition string
%     idx = cellfun(@isstruct, parsedConds, 'UniformOutput', true);
%     conds = parsedConds(idx);
    conds = extractConditionsFromChain(parsedConds);
    
    % For each entry in the parsed condition string
    for k = 1: numel(conds)
        c = conds{k};        
        % Validate the condition
        hasValidAttribs = validateAttribute(c.lhs, schema);
        if(hasValidAttribs) continue; end
        B = false;
        break;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Functional Dependency Helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fds = inputFunctionalDependencies(fdList, schema)
% Purpose:  Allows the user to input Functional Dependencies and returns a 
%           list of the FDs as a cell matrix of 2-element (dependency) structures.
% Returns:  A cell matrix of Dependency structures, one for each 
%           user-defined functional dependency.
% Note: 
%           Validation is not done in this function. We only allow the user to
%           define the conditions and afterward, we check for validity.
%     fds = cell(1, 1);
    counter = 1;    % Next storage location
    fds = fdList;
    if(~isempty(fds))
        counter = numel(fds(:,1)) + 1;               
    end
    
    fprintf('\n%s\n', '--- Functional Dependencies ---');
    fprintf('%s\n','Syntax: Attrib -> Attrib');
    fprintf('%s\n', 'Enter ''done'' when finished.');
    while(true)
        row = input('FD: ', 's');
        % Entering 'done' ends the definition.
        if(strcmpi(row, 'done')) break; end
        
        % Parse the row by whitespaces
        tokenized = textscan(row, '%s');
        tokenized = tokenized{:};
        
        % If the condition does not have three parts, show error and skip. 
        % The middle element should be the ->
        if(numel(tokenized) < 3 || ~strcmpi(tokenized{2}, '->'))
            fprintf('%s\n', 'Incorrect Syntax! Expected: Attrib -> Attrib');
            continue;
        end       
        
        % Populate a condition structure with the parsed FD
        dep = Dependency(upper(tokenized{1}), upper(tokenized{3}));
        % Generate non-trivial fds from the user's FD
        depList = convertToStandardFD(dep);
        numDep = numel(depList(:,1));
        
        for k = 1: numDep
            dep = depList{k};
            if(~validateFD(dep, schema, fds)) continue; end
            
            % Store the condition in the fd matrix
            fds{counter, 1} = dep;        
            counter = counter + 1;
            
            % Generate the Transitive dependencies for the revised set
            genFDs = generateTransitiveDependencies(fds);
            empty = isempty(genFDs) || isempty(genFDs{1});
            if(~empty)
                for j = 1:numel(genFDs)
                    d = genFDs{j};
                    if(~validateFD(d, schema, fds)) continue; end
                    % Store the condition in the conditions matrix
                    fds{counter, 1} = d;        
                    counter = counter + 1;
                end
            end
            printFDList(fds);
        end
    end
end

function B = validateFD(d, schema, fds)
% Purpose:  Validates the attributes of the passed dependency D against the schema.
%           Also checks if the dependency is a duplicate in the list of existing fds.
% Returns:  True if the dependency validates, false otherwise.
    B = true;
    if(iscell(d)) d = d{:}; end
        
    % Validate attributes on lhs and rhs
    if(~validateAttribute(d.lhs, schema) || ~validateAttribute(d.rhs, schema)) 
        B = false; 
        return;
    end

    % Check for duplicates
    if(isDuplicate(d, fds)) 
        fprintf('Duplicate FD: %s -> %s\n', d.lhs, d.rhs); 
        printFDList(fds);
        B = false;
    end
end

function F = convertToStandardFD(fd)
% Purpose:  Non-trivializes the passed FD and returns a list of generated, standard
%           functional dependencies.
% Returns:  Column cell matrix of dependencies
    F = cell(1,1);
    counter = 1;
    numRHSAttrib = numel(fd.rhs);
    rhs = fd.rhs;
    
    if(numRHSAttrib == 1) 
        F{counter} = fd; 
        return;
    end
    
    for k = 1: numRHSAttrib
        curRHSAttrib = rhs(k); 
        dep = Dependency();
        dep.lhs = fd.lhs;
        dep.rhs = curRHSAttrib;
        F{counter, 1} = dep;
        counter = counter + 1;
    end    
end

function F = generateTransitiveDependencies(fds)
% Purpose:  Generates a list of transitive dependencies from the set of fds.
% Precond:  fds is a column cell matrix of dependencies.
% Notes:    We do this so that we have a complete picture with which to deny FDs that 
%           may duplicate implicit, transitive dependencies, and MVDs which may be
%           trivialized by one of these fds.    
    F = cell(1,1);
    counter = 1;
    numFDs = numel(fds(:,1));
    
    % Trivial case
    if(numFDs == 1) return; end
    
    fprintf('...Generating Transitive Dependencies...\n');
    % Create a structure array to hold the structs extracted from the cell matrix
    fdStructs = [fds{:}];
    
    % Get column matrix of left hand sides
    % Columns are easier on pen-and-paper. Doesn't have to be column vectors though.
    lhsList = [fdStructs(:).lhs]';
    rhsList = [fdStructs(:).rhs]';
    
    % Find where the rhs contains attributes on the lhs
    idx = ismember(lhsList, rhsList, 'rows');
    % Get the attribs that exist on both sides
    attribs = lhsList(idx);
    
    % Generate the transitive dependencies
    numGenFD = 0;
    for k = 1: numel(attribs)
        % The current lhs attrib
        A = attribs(k);                       
        % Get the rhs attribs associated with the current attrib
        rhsAttribsForA = rhsList(A == lhsList);       
        % Get the lhs attribs for the associated fds
        assattribs = lhsList(A == rhsList);
        for j = 1:numel(assattribs)
            asa = assattribs(j);            
            % For each rhs attrib associated with the transitive attrib
            for m = 1: numel(rhsAttribsForA)
                % Create a new fd
                tfd = Dependency(asa, rhsAttribsForA(m));
                F{counter, 1} = tfd;
                counter = counter + 1;
                numGenFD = numGenFD + 1;
            end
        end 
    end
    
    if      (numGenFD == 0) return;
    elseif  (numGenFD == 1) fprintf('%i transitive dependency generated!\n', numGenFD);
    else    fprintf('%i transitive dependencies generated!\n', numGenFD);
    end
    
end

function printFDList(fdList)
% Purpose:  Prints the list of functional dependencies.
% Precond:  fdList: Column cell matrix of dependencies
    fprintf('\n--- FD List Print ---\n');
    numFD = numel(fdList(:,1));
    for k = 1: numFD
        fd = fdList{k};
        fprintf('%s -> %s\n', fd.lhs, fd.rhs);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MultiValue Dependency Helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mvds = inputMultiValueDependencies(mvdList, fds, schema)
% Purpose:  Allows the user to input MultiValue Dependencies and returns a 
%           list of the MVDs as a cell matrix of 2-element (dependency) structures.
% Returns:  A cell matrix of Dependency structures, one for each 
%           user-defined multivalue dependency.
% Note: 
%           Validation is not done in this function. We only allow the user to
%           define the conditions and afterward, we check for validity.
    mvds = mvdList;
    counter = 1;        % Next storage location
    if(~isempty(mvds) && ~isempty(mvds{1}))
       counter = numel(mvds(:,1)) + 1; 
    end
    
    fprintf('\n%s\n', '--- MultiValue Dependencies ---');
    fprintf('%s\n','Syntax: Attrib ->-> Attrib');
    fprintf('%s\n', 'Enter ''done'' when finished.');
    while(true)
        row = input('MVD: ', 's');
        % Entering 'done' ends the definition.
        if(strcmpi(row, 'done')) break; end
        
        % Parse the row by whitespaces
        tokenized = textscan(row, '%s');
        tokenized = tokenized{:};
        
        % Check if the condition does not have three parts
        % Check if the middle element is not the mvd symbol ->->
        if(numel(tokenized) < 3 || ~strcmpi(tokenized{2}, '->->'))
            fprintf('%s\n', 'Incorrect Syntax! Expected: Attrib ->-> Attrib');
            continue;
        end
        
        % Populate a dependency structure with the parsed mvd
        dep = Dependency(upper(tokenized{1}), upper(tokenized{3}));
        
        % Convert to standard form
        % The FD function works just as well since we only use the lhs and rhs
        mvdList = convertToStandardFD(dep);
        numMVDs = numel(mvdList(:,1));
        
        % For each mvd
        for k = 1 : numMVDs
            dep = mvdList{k};
            
            % Validate attributes on lhs and rhs
            if(~validateAttribute(dep.lhs, schema) || ~validateAttribute(dep.rhs, schema)) continue; end

            % Check for duplicates in list of mvds
            if(isDuplicate(dep, mvds)) 
                fprintf('Duplicate MVD: %s ->-> %s\n', dep.lhs, dep.rhs); 
                printMVDList(mvds);
                continue;
            end
            
            % Check that it's not trivialized by an FD
            if(trivializedByFD(dep, fds)) continue; end
            
            %Store the condition in the mvd matrix
            mvds{counter, 1} = dep;        
            counter = counter + 1;            
            printMVDList(mvds);
        end        
    end
end

function trivial = trivializedByFD(mvd, fds)
% Purpose:  Checks if the passed mvd is trivialized/duplicated by an fd in the list.
% Returns:  True if the mvd is trivialized and should be skipped, false otherwise. 
% Notes:    An MVD is trivial if an FD exists with the its lhs and rhs attribs.
    % Get arrays of the structures
    fdStructs = [fds{:}];    
    % String representation of the mvd
    mvdpair = [mvd.lhs mvd.rhs];
    
    % Get a column vector of FD strings [lhs rhs]
    lhs = [fdStructs(:).lhs];
    rhs = [fdStructs(:).rhs];
    fdpairs = [lhs(:) rhs(:)];
    
    trivial = ismember(mvdpair, fdpairs, 'rows') > 0;  
    if(~trivial) return; end
    fprintf('%s ->-> %s trivialized by %s -> %s\n', mvd.lhs, mvd.rhs, mvd.lhs, mvd.rhs);
end

function printMVDList(mvdList)
% Purpose:  Prints the list of multi-value dependencies.
% Precond:  mvdList: Column cell matrix of dependencies
    if(isempty(mvdList) || (iscell(mvdList) && isempty(mvdList{1}))) return; end
    fprintf('\n--- MVD List Print ---\n');
    numMVD = numel(mvdList(:,1));
    for k = 1: numMVD
        mvd = mvdList{k};
        fprintf('%s ->-> %s\n', mvd.lhs, mvd.rhs);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Key Helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function keys = inputKeys(keyList, fds, schema)
% Purpose: Allows the user to input attribute keys. Performs validation checks to
% make sure the key has valid attributes, is in fact a key.

    keys = keyList;
    counter = 1;
    if(~isempty(keyList))
       counter = numel(keys(:,1)) + 1; 
    end
    
    fprintf('\n%s\n', '--- Keys ---');
    fprintf('%s\n','Syntax: Attributes');
    fprintf('%s\n', 'Enter ''done'' when finished.');
    while(true)
        key = input('Key: ', 's');
        % Entering 'done' ends the definition.
        if(strcmpi(key, 'done')) break; end
        
        % Validate the attributes of the key
        if(~validateKeyAttributes(key, schema)) continue; end
        
        % Check for key duplication within set of keys
        if(isDuplicateKey(key, keys)) continue; end
        
        % Validate the key
        if(~validateKey(key, fds, schema, false)) continue; end            
        
        % Store the key
        keys{counter} = key;
        counter = counter + 1;
        printKeyList(keys);
    end
end

function B = isDuplicateKey(key, keys)
% Purpose: Checks whether or not the key exists in the set of keys.
% Returns: True if it's a duplicate key, false otherwise.
    B = false;
    if(isempty(keys)) return; end
    
    dup = ismember({key}, keys) > 0;
    if(~dup) return; end
    
    fprintf('Duplicate Key: %s\n', key);
    B = true;    
end

function B = validateKeyAttributes(key, schema)
% Purpose:  Validates every attribute (char) within the key.
% Returns:  True if the entire key validates, false otherwise.
    B = true;
    for k = 1:numel(key)            
        % For every attribute of the key, validate it
        attrib = key(k);
        if(~validateAttribute(attrib, schema)) 
            fprintf('Not a valid attribute: %s\n', attrib);
            B = false;
            continue; 
        end
    end
end

function B = validateKey(key, fds, schema, suppressOutput)
% Purpose:  Computes the closure of the key against the set of fds to verify if the
%           key is indeed a valid key.
% Preconds: 
%           key is a string of attributes
%           constraints is a constraint structure
%           schema is an attribute to datatype mapping.
% Returns:  True if the key is valid, false otherwise.
% Notes:    If the constraints' list of FD's is empty, then the key should be
%           contain all of the attributes. 
%           The legacy function computeclosure() is used from
%           the first programming assignment.
    B = true;
    %Get the list of schema attributes
    allSchemaAttribs = keyset2char(schema.keySet());
       
    %If there are no FDs listed
    if(isempty(fds))
       %If the key doesn't contain all of the table's attributes
       if(~strcmpi(allSchemaAttribs, key))
           %The key is not valid
           B = false;
           if(~suppressOutput) fprintf('Key Not Valid!\n'); end
           return;
       end
    end
    
    % Compute the closure of the key
    % Get a column vectors of the fd attributes in the list. 
    fdstructs = [fds{:}];
    lhs = [fdstructs(:).lhs]';
    rhs = [fdstructs(:).rhs]';
    
    closure = computeclosure(key, lhs, rhs);
    
    % If the closure is not the set of attributes, then it's not valid.
    % strcmp needs the key to be defined in the order of the attribs. We'll use
    % ismember() to verify that all members of the key exist in the set of attribs.
    countMatches = sum(ismember(allSchemaAttribs, closure));
    allAttribsExist = countMatches == numel(allSchemaAttribs);
    if(~allAttribsExist)
        if(~suppressOutput)
            fprintf('Closure of the supplied key: %s\n', closure);
            fprintf('Expected closure: %s\n', allSchemaAttribs);
            fprintf('Not a valid key: %s\n', key);
        end
        B = false;
    end
end

function printKeyList(keys)
% Precond: keys: column cell matrix of strings
    fprintf('\n--- Key List Print ---\n');
    cellfun(@(key) fprintf('%s\n', key), keys);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               General Helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function B = isDuplicate(entity, entities)
% Purpose:  Determines if the passed entity is a duplicate in the list of
%           entities passed.
% Precond:  entity: any structure
%           entities: cell matrix of structures
% Returns:  True if the entity is a duplicate. False otherwise.
    B = false;
    
    % If the list is empty, then there's nothing to check
    if(isempty(entities) || isempty(entities{1})) return; end
    % Convert entity from a structure to a column cell matrix of strings
    E = struct2cell(entity);
    % Convert entity list from cell matrix of structures to cells of strings
    ECL = cellfun(@struct2cell, entities, 'UniformOutput', false);
    
    for k = 1:numel(ECL)
        % Get the current cell of strings
        ec = ECL{k};
        % The number of strings matching between the two cells
        numMatches = sum(ismember(E, ec));
        % If the entire entity matches, we have a duplicate!
        isDup = numMatches == numel(E);
        if(~isDup) continue; end
        
        % We won't print a detailed msg since we don't 
        % know the structure of entity.
        fprintf('%s\n', 'Duplicate not accepted!');
        B = true;
        return;           
    end
end

function printAttributeList(name, schema)
% Purpose:  Prints the table's name and set of attributes inline.
% Format:   TableName:[Attrib, Attrib, ... ]
    fprintf('\n--- Attributes for table %s ---\n', name);
    keys = char(schema.keySet());
    fprintf('%s\n', keys);    
end

function mvdList = is4thNormalForm(mvds, fds, schema)
% Purpose:  Checks if the table is in 4th normal form.
% Returns:  A set of MVDs that makes the table 4th NF.
% Note:     4th Normal Form is defined with the constraints:
%               1. Each LHS of the MVDs must be a key or superkey
%               Since the user won't supply all possible keys, we need to check if
%               the lhs of each mvd could be a key. We use the closure for this.
%           Superkey is where the key is part of the LHS for a given mvd.
    mvdList = cell(1,1);
    counter = 1;
    % Trivial Case where there are no fds
    if(isempty(mvds) || (iscell(mvds) && isempty(mvds{1}))) return; end
    
    fprintf('\n...Checking for 4th normal form...\n');
    
    for k = 1: numel(mvds(:,1))
       mvd = mvds{k};
       % Check if the mvd's lhs makes for a valid key 
       % Keys yield a closure equal to the set of all attribs for the table based on
       % the set of fds defined.
       if(~validateKey(mvd.lhs, fds, schema, true))
           fprintf('Warning: Table is not 4th Normal Form!\n');
           fprintf('MVD Violation: %s ->-> %s\n', mvd.lhs, mvd.rhs);
           fprintf('...Deleting the violation...\n');
           % Tag the violation
           mvds{k} = '0';
       end
    end
    
    % Remove all tagged violations
    numMVDs = numel(mvds(:,1));
    for k = 1: numMVDs
        mvd = mvds{k};
        % Keep structs (untagged elements)
        if(isstruct(mvd)) 
            mvdList{counter} = mvd; 
            counter = counter + 1;
        end        
    end
end