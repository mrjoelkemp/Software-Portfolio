%{
Author: Joel Kemp
Email: mrjoelkemp@gmail.com
Course: Database Systems Fall 2011; Assignment 1, Problem 2
Professor: Jie Wei
File: parser.m
Purpose: 
    Allows a user to define a database through tables and the table's
    respective attributes along with their datatypes.
    
    The user can then input queries about tables in the database, selecting
    attributes from a particular table and enforcing a 'where' condition to
    filter the results. 
Note:
    1. This program does not allow for tuple/row creation, so we only validate
    the syntax of the query and do not return the results of the query.

    2. We assume that table names will not be single uppercase letters.
%}

function parser()
%Purpose: Entry point of the program. Asks the user to define tables and
%   their schemas to form the database schema. This information is stored and
%   the user can query against this structure. We do not facilitate the
%   execution of the queries, but merely validate the syntax.
    
    %Grab the user-defined database (tables and their schemas)
    database = populateDatabase();  

    %Handle user querying and validation
    inputQueryValidate(database);
end

function database = populateDatabase()
%Purpose: Queries the user to define tables and their schemas that make up
%   the database's schema. 
%Returns: A java hashmap consisting of table names mapped to table schemas.
    
    %The database is a set of table schema's indexed by table names
    database = java.util.HashMap;
    
    fprintf('%s\n', '--Define Database Schema--');
    %User inputs the database schema
    while(true)       
        %User enters a table name
        tableName = input('Please enter a table name: ', 's');
        %Check if the table has already been defined
        if(~isempty(database.get(tableName)))
           fprintf('%s %s\n', 'Table Already Exists:', tableName);
           continue;
        end
        
        %If the table name is 'done', then break
        if(strcmp(tableName, 'done')) break; end;
        
        fprintf('\n%s%s\n%s\n', 'Define the schema for table: ', ... 
            tableName, 'Enter ''done'' when finished.');
        
        %The table schema is a set of datatypes indexed by attribute names.
        %Attribute names will be unique, while datatypes repeat.
        tableSchema = java.util.HashMap;
        
        %Loop to allow the user to enter attributes and datatypes
        while(true)
            %User enters an attribute name and datatype
            row = input('Attribute & Datatype: ', 's');
            %If the attribute entered is 'done', then break
            if(strcmp(row, 'done')) break; end;
            
            %Split the input into attribute and datatype by whitespace
            tokenized = textscan(row, '%s');
            tokenized = tokenized{:};
            
            %Extract the attrib and datatype of the tokenized string
            attribute = tokenized{1};
            datatype = tokenized{2};
            
            %Validate datatype
            %If the type is neither int nor char
            if(~strcmp(datatype, 'int') && ~strcmp(datatype, 'char'))
                fprintf('%s\n', 'Sorry, only ''int'' or ''char'' are acceptable datatypes');
                continue;
            end
            
            %Add the attribute datatype pair to the tableSchema map
            tableSchema.put(attribute, datatype);
        end
        
        fprintf('%s %s\n\n', 'Schema saved for table: ', tableName);        
        %Store the table name with its associated schema
        database.put(tableName, tableSchema);        
    end

end

function inputQueryValidate(database)
%Purpose: Grabs a user's query and validates its syntax
%Precondition: database is a hashmap of table names to schemas
%Query Format: select ATTRIBUTES from TABLE where CONDITION
    
    fprintf('%s\n', '--Query Validation--');
    %Allows the user to re-enter the query while it is incorrect
    while(true)
        query = input('Please enter your query: ', 's');
        clauses = parseQuery(query);
        if(isempty(clauses{1}))
           continue; 
        end
        
        %Validate SQL clauses: select, from, and where
        if(~validateSQLClauses(clauses{1}, clauses{3}, clauses{5})) continue; end
        
        %Validate Table Name
        if(~validateTable(database, clauses{4})) continue; end
        schema = database.get(clauses{4});
        
        %Validate select attributes from the cell matrix of attribs
        invalid = false;
        attribs = clauses{2};
        for k = 1:numel(attribs)
            if(~validateAttribute(schema, attribs{k}))
                invalid = true;
            end
        end
        if(invalid) continue; end
                    
        %Validate Condition: Attrib Operator Value
        whereAttrib = clauses{6};
        operator = clauses{7};
        value = clauses{8};
        
        %Validate the parts of the where condition
        if(~validateWhereCondition(schema, whereAttrib, operator, value)) continue; end
        
        %If we've reached this point, then all parts of the query validated
        fprintf('%s\n\n', 'Query Valid!');
        %Exit the loop since we won't need re-entry
        break;
    end %end While
end % end inputQueryValidate()

function C = parseQuery(query)
%Purpose: Parses the passed SQL query by extracting the components with
%   regular expressions and returning a parsed structure to be validated.
%Returns: A 8x1 cell array consisting of the extracted query components
%   Cell Matrix Structure:
%       1. Select
%       2. Attribute(s) Cell Matrix [a1 a2 a3]
%       3. From
%       4. TableName
%       5. Where
%       6. WhereAttribute
%       7. Operator
%       8. Value
    %Init the output cell matrix
    C = cell(8, 1);
    
    %Extract the where clause
    %Where clause is a word (where) followed by an uppercase letter, one 
    %   or more spaces, a <, >, or ==, one or more spaces and digits or 
    %   a single quoted character (letter or digits)
    [w ~] = regexp(query, '(\w{2,})\s*([A-Z])\s*(<|>|\={2})\s*(\d+|(\''([A-Z]|\d+)\''))', 'match');
    if(isempty(w))
       fprintf('%s\n', 'Sorry, a parsing error occurred!');
       return;
    end
    
    ws = textscan(w{1}, '%s');
    ws = ws{:};   %Remove nested cell array structure
    where = ws{1};
    whereAttribute = ws{2};
    operator = ws{3};
    value = ws{4};
    %Remove the where clause from the query
    query = strrep(query, w{1}, '');
    
    %Get the whole words (2 or more characters since we assume that table
    %names are not single, uppercase letters)
    %This yields [select from tableName]
    [m ~] = regexp(query, '\w{2,}', 'match');
    select = m{1};
    from = m{2};
    tableName = m{3};
    
    %Remove the whole words
    for k = 1:numel(m)
        query = strrep(query, m{k}, '');
    end
    
    %At this point, only the attribute list remains
    [attributes ~] = regexp(query, '[A-Z]', 'match');
    
    %Prepare the output cell matrix
    C{1} = select;
    C{2} = attributes;
    C{3} = from;
    C{4} = tableName;
    C{5} = where;
    C{6} = whereAttribute;
    C{7} = operator;
    C{8} = value;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Validation Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function T = validateWhereCondition(schema, attribute, operator, value)
%Purpose: Validates the where condition by checking the operator and value
%   based on the datatype retrieved from the schema based on the attribute.
%Returns: True if validation was successful, false otherwise

    %Init the output
    T = true;
    
    %Validate the where clause attribute
    if(~validateAttribute(schema, attribute)) 
        T = false;
        return;
    end
    
    %Get datatype of attribute
    dattrib = schema.get(attribute);
    %if datatype is 'int'
    if(strcmp(dattrib, 'int'))
        %Make sure operator is < or >
        if(~strcmp(operator, '<') & ~strcmp(operator, '>'))
            fprintf('%s %s\n%s\n', 'Unsupported Operator:', operator, ...
                'Expected: < or > for ints');
            T = false;
        end
        %If the value is not a digit or has single quotes, then it's wrong
        %isstrprop(value, 'digit') checks if the string represents a digit
        %   but this doesn't prevent '10' for ints
        %If the first char in the value char array is an apostrophe (char
        %code 39 in ascii), then the user gave a char as input
        if(strcmp(value(1), char(39)) | ~isstrprop(value, 'digit'))
            fprintf('%s %s\n', 'Not a number:', value);
            T = false;
        end
    %if datatype is 'char'
    else
        %Make sure operator is ==
        if(~strcmp(operator, '=='))
            fprintf('%s %s\n%s\n', 'Unsupported Operator:', operator, ...
                'Expected: == for chars');
            T = false;
        end
        %Make sure value is a char with single quotes   
        if(~isstrprop(value, 'alphanum'))
            fprintf('%s %s\n', 'Not a character:', value);
            T = false;
        end
    end
end

function T = validateSQLClauses(select, from, where)
%Purpose: Validates the spelling of the clauses in the SQL language
%   (select, from, and where)
%Precondition: input contains user submitted query-clauses
%Returns: True if the clauses validated, false otherwise
%Notes:
%   If an error is found, an error message is given to the user and the
%   boolean returned should trigger a re-prompt for the query in the caller.
    
    %Initialize the output
    T = true;
    
    %Validate 'select'
    if(~strcmpi(select, 'select'))
        fprintf('%s %s\n', 'Misspelling:', select); 
        T = false;
    end
        
    %Validate 'from'
    if(~strcmpi(from, 'from'))
        fprintf('%s %s\n', 'Misspelling:', from); 
        T = false;
    end
        
    %Validate "where"
    if(~strcmpi(where, 'where'))
       fprintf('%s %s\n', 'Misspelling:', where); 
       T = false;
    end    
end

function T = validateAttribute(schema, attribute)
%Purpose: Validates the passed attribute with the schema. 
%   If the attribute exists in the schema, validation is successful.
%Precondition: schema is a hashmap of attribute names to datatypes
%Returns: True if validation is successful, false otherwise.
    
    %Init output
    T = true;
    %If the hashmap contains no entry for the attribute
    if(isempty(schema.get(attribute)))
        %Print an error msg
        fprintf('%s %s\n', 'Attribute not found:', attribute); 
        %Validation was unsuccessful
        T = false;
    end     
end

function T = validateTable(database, table)
%Purpose: Validates the passed table name by checking if there's an
%   existing schema with that table name.
%Precondition: database is a java hashmap of table names to schemas
%Returns: True if the schema exists, false otherwise.
    T = true;
    %Grab the schema for the user's table (if it exists)
    schema = database.get(table);
    %If the table doesn't exist, then prompt for re-entry
    if(isempty(schema))
       fprintf('%s %s\n', 'Table not found:', table); 
       T = false;
    end
end