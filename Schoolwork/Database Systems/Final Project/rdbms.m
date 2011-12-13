% Author:   Joel Kemp, mrjoelkemp@gmail.com
% Project:  Database Systems 1, Fall 2011 Final Project
% File:     rdbms.m
% Purpose:  Entry point to the system. Coordinates the showing of menus,
%           capturing of input, and redirection to the appropriate database
%           functionality.
% Usage:    rdbms() from the command window.
% Notes: 
%           The system is designed to pass control to a function that handles
%           all of the behavior for a particular portion of the system. The design
%           attempts to reduce the complexity of the menu-based logical structure
%           by abstracting nested switch statements.

function rdbms()
% Purpose: Entry point to the system
    
    % Add the subdirectories (containing important source code) to the matlab path.
    addpath(genpath('source'));
    
    database = [];    
    load ('database', 'database');
    if(isempty(database))
        database = cell(1);
    end
    
    mmChoice = showMainMenu();
    while (mmChoice ~= 5)
        switch mmChoice
            case 1  % Table Definition
                table = defineTable();
                database = storeTable(database, table);
            case 2  % Table Extension            
                table = getUserTableSelection(database);
                if(isempty(table))
                    fprintf('You must select a table!\n');
                else
                    database = extendTable(database, table);                  
                end
            case 3  % Table Modification
                table = getUserTableSelection(database);
                if(isempty(table))
                    fprintf('You must select a table!\n');
                else
                    database = modifyTable(database, table);  
                end                   
            case 4  % Table Deletion
                table = getUserTableSelection(database);
                if(~isempty(table))                     
                    in = input('Sure to delete? [y/n]', 's');
                    if(strcmpi(in, 'y'))
                        database = deleteTable(database, table);
                        fprintf('...Table %s deleted...\n', table.name);                        
                    end
                end
        end        
        saveDatabase(database);
        mmChoice = showMainMenu();
    end
end

function choice = showMainMenu()
% Purpose:  Shows the main menu to the user, prompts for their choice, and
%           handles redirection to another menu.
    fprintf('\n%s\n', '--- Main Menu ---');
    fprintf('%s\n', '1. Define a New Table (Attributes and Types)');
    fprintf('%s\n', '2. Extend a Table (Constraints, Keys, Data)');
    fprintf('%s\n', '3. Modify an Existing Table');
    fprintf('%s\n', '4. Delete a Table');
    fprintf('%s\n', '5. EXIT');
    choice = getValidMenuChoice(1, 5);
end

function database = testCases(database)
% Purpose:  This function contains test cases that were used for testing particular
%           features of the system.
% Returns:  A database populated with the test tables.
%     table = Table();
%     table.name = 'dog';
%     table.schema.put('A', 'int');
%     table.schema.put('B', 'string');
%     table.schema.put('C', 'int');
%     table.schema.put('F', 'string');
%     chain1 = {Condition('A', '>', '5') 'AND' Condition('A', '<', '10')};
%     chain2 = {Condition('C', '<', '10') 'OR' Condition('C', '>', '20')};
%     c3 = Condition('B', '<>', 'joel');
%     c4 = Condition('F', '<', '100');
%     table.constraints.conditions = {chain1;{c3};chain2;{c4}};
%     fd1 = Dependency('A','B');
%     fd2 = Dependency('A','F');
%     table.constraints.fds = {fd1;fd2};
%     mvd1 = Dependency('AB', 'C');
%     table.constraints.mvds = {mvd1};
%     table.constraints.keys = {'AC'};
%     table.tuples = struct('A', '6', 'B', 'kemp', 'C', '15', 'F', '50');
%     table.tuples(2, 1) = struct('A', '6', 'B', 'kemp', 'C', '20', 'F', '50');
%     table.tuples(3, 1) = struct('A', '7', 'B', 'kemp', 'C', '20', 'F', '55');
%     %This aren't valid by the constraints, but only for testing.
%     table.tuples(4, 1) = struct('A', '7', 'B', 'kemp', 'C', '25', 'F', '55');
%     table.tuples(5, 1) = struct('A', '6', 'B', 'kemp', 'C', '30', 'F', '60');
%     database{1} = table;
%     
%     table2 = Table();
%     table2.name = 'cat';
%     table2.schema.put('A', 'int');
%     table2.schema.put('B', 'string');
%     table2.schema.put('C', 'int');
%     table2.schema.put('F', 'int');
%     chain1 = {Condition('A', '>', '5') 'AND' Condition('A', '<', '10')};
%     chain2 = {Condition('C', '<', '10') 'OR' Condition('C', '>', '20')};
%     c3 = Condition('B', '<>', 'kemp');
%     c4 = Condition('F', '<', '60');
%     table2.constraints.conditions = {chain1;{c3};chain2;{c4}};
%     fd1 = Dependency('A','B');
%     fd2 = Dependency('A','F');
%     table2.constraints.fds = {fd1;fd2};
%     mvd1 = Dependency('AB', 'C');
%     table2.constraints.mvds = {mvd1};
%     table2.constraints.keys = {'AC'};
%     table2.tuples = struct('A', '6', 'B', 'meow', 'C', '15', 'F', '50');
%     table2.tuples(2, 1) = struct('A', '6', 'B', 'meow', 'C', '20', 'F', '50');
%     database{2} = table2;
%      
%     table3 = Table();
%     table3.name = 'horse';
%     table3.schema.put('A', 'int');
%     table3.schema.put('B', 'string');
%     table3.schema.put('C', 'int');
%     table3.schema.put('F', 'int');
%     chain1 = {Condition('A', '>', '5') 'AND' Condition('A', '<', '10')};
%     chain2 = {Condition('C', '<', '10') 'OR' Condition('C', '>', '20')};
%     c3 = Condition('B', '<>', 'meow');
%     c4 = Condition('F', '<', '60');
%     table3.constraints.conditions = {chain1;{c3};chain2;{c4}};
%     fd1 = Dependency('A','B');
%     fd2 = Dependency('A','F');
%     table3.constraints.fds = {fd1;fd2};
%     mvd1 = Dependency('AB', 'C');
%     table3.constraints.mvds = {mvd1};
%     table3.constraints.keys = {'AC'};
%     table3.tuples = struct('A', '6', 'B', 'kemp', 'C', '15', 'F', '50');
%     table3.tuples(2, 1) = struct('A', '6', 'B', 'kemp', 'C', '25', 'F', '55');
%     database{3} = table3;
%     
%     
%     table = Table();
%     table.schema.put('A', 'int');
%     table.schema.put('B', 'int');
%     table.schema.put('C', 'int');
%     table.schema.put('D', 'int');
%     tuples =        struct('A', '1', 'B', '2', 'C', '3', 'D', '4');
%     tuples(2,1) =   struct('A', '1', 'B', '3', 'C', '3', 'D', '4');
%     tuples(3,1) =   struct('A', '1', 'B', '4', 'C', '5', 'D', '6');
%     tuples(4,1) =   struct('A', '2', 'B', '3', 'C', '6', 'D', '7');
%     mvd = Dependency('A', 'B');
%     mvd2 = Dependency('AB', 'C');
%     B = violatesMVDs(tuples, {mvd; mvd2}, table.schema);
end