% Author: Joel Kemp, mrjoelkemp@gmail.com
% Project: Database Systems 1, Fall 2011 Final Project
% File: getValidMenuChoice.m
% Purpose: Menu Helper function used by multiple files in the project.

function choice = getValidMenuChoice(firstNum, lastNum)
% Purpose: Grabs input from the user and determines if it's within the range
%   firstNum <= choice <= lastNum, where firstNum and lastNum are the first
%   and last menu option numbers. If the input is not in range, then the
%   function continues to poll the user.
% Returns: A menu option within the range.

    choice = str2double(input('Your choice: ', 's'));
        
    while(choice < firstNum || choice > lastNum)
        choice = str2double(input('Please Try Again: ', 's'));
    end
end