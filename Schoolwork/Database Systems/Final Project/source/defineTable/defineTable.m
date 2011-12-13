% Author:   Joel Kemp, mrjoelkemp@gmail.com
% Project:  Database Systems 1, Fall 2011 Final Project
% File:     defineTable.m
% Purpose:  Allows a user to define the name and schema for a table
% Returns:  A table structure with the populated name and schema.
% Notes: 
%   Table Structure:
%       name:           The name of the table.
%       schema:         Hashmap of attribute to datatype associations.
%       keys:           A list of attribute keys for the table.
%       constraints:    A list of constraints (fd, mvd, conditions)
%                           See constraints.m for the constraint structure.
%       tuples:         A list of data rows (value per attribute).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Entry Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function table = defineTable()
% Purpose:  Facilitates the definition of a table structure by allowing the
%           user to input a name, attributes, and their datatypes for the table.
% Returns:  A populated table structure.
    
    fprintf('\n%s\n', '--- Table Definition ---');
    
    table = Table();
    
    fprintf('%s\n', 'Please enter the table name.');
    table.name = input('Table Name: ', 's');
    
    fprintf('%s %s.\n', 'Enter up to 4 attributes and types for', table.name);
    fprintf('%s\n', 'Enter ''done'' when finished');
    
    numAttribs = 0;  %The number of stored attribs
    while(true)
        row = input('Attribute & Datatype: ', 's');
        % Entering 'done' ends the definition.
        if(strcmpi(row, 'done')) break; end
        [attribute datatype] = parseSchemaTuple(row);

        % Validate datatype and attribute
        if(~isDatatypeValid(datatype) || ~isAttributeUnique(table.schema, attribute)) continue; end
                
        table.schema.put(attribute, datatype);        
        
        numAttribs = numAttribs + 1;
        if(numAttribs == 4) 
            fprintf('%s\n', 'Maximum number of attributes defined!'); 
            break; 
        end        
    end
    fprintf('%s %s\n\n', 'Schema saved for table: ', table.name);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [attribute datatype] = parseSchemaTuple(row)
% Purpose: Parses the passed user-define schema row (attrib datatype) into
%   separate, case-fixed parts.
% Returns: A tuple consisting of the parsed attribute and datatype.
    % Split the input into attribute and datatype by whitespace
    tokenized = textscan(row, '%s');
    tokenized = tokenized{:};

    % Extract the attrib and datatype of the tokenized string
    attribute = upper(tokenized{1});
    datatype = lower(tokenized{2});
end

function T = isDatatypeValid(datatype)
% Purpose: Determines whether or not the passed datatype is the word 'int'
%   or 'string'. This is the validation criteria for datatypes.
% Returns: 
    T = true;
    if(~strcmp(datatype, 'int') && ~strcmp(datatype, 'string'))
        fprintf('%s\n', 'Sorry, only ''int'' and ''string'' are acceptable datatypes.');
        T = false;
    end
end

function T = isAttributeUnique(schema, attribute)
% Purpose: Determines whether or not the attribute has already been defined
%   in the passed schema.
% Returns: True if the variable has not been defined. False otherwise.
    T = true;
    if(~isempty(schema.get(attribute)))
        fprintf('%s %s\n', 'Attribute already defined:', attribute);
        T = false;
    end
end