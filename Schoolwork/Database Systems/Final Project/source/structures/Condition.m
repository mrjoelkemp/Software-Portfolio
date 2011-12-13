% Author:       Joel Kemp, mrjoelkemp@gmail.com
% Project:      Database Systems 1, Fall 2011 Final Project
% File:         Condition.m
% Purpose:      Represents a Boolean Condition.
% Precondition: Accepts a variable number of arguments (0 or 3) and sets
%               the attributes appropriately.
% Returns:      An instance of the Boolean Condition Structure.
% Condition Structure:
%   lhs:        Attribute (Left Hand Side)
%   operator:   Boolean Operator (<, >, ==, <>, <=, >=)
%   rhs:        Int or String Value (Right Hand Side)
function C = Condition(varargin)
    numInputs = size(varargin, 2);
    if(numInputs == 3)
        C = struct('lhs', varargin{1}, 'operator', varargin{2}, 'rhs', varargin{3});
    else
        C = struct('lhs', [], 'operator', [], 'rhs', []);
    end
end
