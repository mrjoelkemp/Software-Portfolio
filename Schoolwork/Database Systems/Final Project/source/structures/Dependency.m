% Author:       Joel Kemp, mrjoelkemp@gmail.com
% Project:      Database Systems 1, Fall 2011 Final Project
% File:         Dependency.m
% Purpose:      Represents a Dependency (Functional or Multi-Value)
% Precondition: Accepts either 0 or 2 inputs.
% Returns:      An instance of the Dependency structure.
% Note:         FD single arrow and MVD multi-arrow should not be passed in.
% Dependency Structure:
%   lhs:        Attribute
%   rhs:        Attribute
function D = Dependency(varargin)
    numInputs = size(varargin, 2);
    if(numInputs == 2)
        D = struct('lhs', varargin{1}, 'rhs', varargin{2});
    else
        D = struct('lhs', [], 'rhs', []);
    end
end