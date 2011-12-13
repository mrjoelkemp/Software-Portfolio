% Author: Joel Kemp, mrjoelkemp@gmail.com
% Project: Database Systems 1, Fall 2011 Final Project
% File: Constraint.m
% Purpose: Represents a Constraint structure in the system consisting of
%   boolean conditions, FD's, MVD's, and keys. A table has a Constraint structure.
% Usage: Calling this function simulates a constructor of the Constraint
%   object by returning a structured object containing the members listed
%   below. This allows us to refer to a single location when modifying the
%   definition.
% Notes:
%   Constraint Structure: 
%       conditions:     List of boolean conditions
%       fds:            List of functional dependencies
%       mvds:           List of multi-value dependencies
%       keys:           List of attribute keys
function C = Constraint()
    C = struct('conditions', [], 'fds', [], 'mvds', [], 'keys', []); 
end
