% Author: Joel Kemp, mrjoelkemp@gmail.com
% Project: Database Systems 1, Fall 2011 Final Project
% File: Table.m
% Purpose: Represents a Table structure in the system consisting of
%   a name, schema, attribute keys, constraints, and data tuples.
% Usage: Calling this function simulates a constructor of the Table
%   object by returning a structured object containing the members listed
%   below. This allows us to refer to a single location when modifying the
%   definition.
%Notes: 
%   Table Structure:
%       name:           The name of the table.
%       schema:         Hashmap of attribute to datatype associations.
%       constraints:    A list of constraints (fd, mvd, conditions, keys)
%                           See Constraint.m for the constraint structure.
%       tuples:         A column array of dynamic structures accessed by the set of 
%                       attributes for the table.
function T = Table()
    T = struct('name', [], 'schema', java.util.TreeMap, ...
        'constraints', Constraint(), 'tuples', struct());
end