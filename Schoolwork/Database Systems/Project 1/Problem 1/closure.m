%{
Author: Joel Kemp
Email: mrjoelkemp@gmail.com
Course: Database Systems Fall 2011; Assignment 1, Problem 1
Professor: Jie Wei

File: closure.m
Purpose: Allows a user to define a table, set of functional dependencies,
    and provide a seed with which the system computes and returns the closure
    of that seed/set of attributes.
%}

function closure()
%Purpose: Entry point to the program. Prompts the user for a description of
%   the attributes for a table and the functional dependencies and then allows
%   the user to input attributes for which we compute the closure.

    %Ask user to input table attributes as non-spaced, uppercase string of letters
    attribs = upper(input('Please enter the attribute list: ', 's'));

    %Remove whitespaces
    %isspace(attribs) returns an array where locations of spaces are marked
    %   with 1 and non-spaces are marked with a 0
    attribs(isspace(attribs) == 1) = [];

    %Initialize the list of functional dependencies
    %Associated arrays that maintain the relationship between the FD
    %   attributes on the left and right sides of the user's input
    LHS = cell(1, 1);    %Cells to retain individual strings
    RHS = cell(1, 1);
    
    fprintf('\n%s\n%s\n','Please enter the functional dependencies one at a time.', 'Type ''done'' when finished!');
    
    %Maintains the new storage position within the associated cell arrays
    counter = 1;
    
    while(true)
        %Ask the user for an FD in the form of Attribute(s)->Attribute(s)
        dep = input('FD: ', 's');
        
        %Remove whitespaces to tokenizing delimiter confusion
        dep(isspace(dep) == 1) = [];
        
        %If the user enters 'done', then exit
        if(strcmp(dep, 'done')) break; end
        
        %Break the FD into tokens delimited by the arrow ->
        tokenized = textscan(dep, '%s%s', 'delimiter', '->');
        %The actual tokens are the first cell array of the result
        tokens = tokenized{1};
        %Extract the left and right sides of the tokenized string
        left = tokens{1};
        right = tokens{2};
        
        %If the lhs == rhs, then skip adding this to the list
        %This is a trivial FD
        if(strcmp(left, right)) 
            fprintf('Warning: %s\n', 'FD is trivial and has been skipped!');
            continue; 
        end
        
        %If the LHS or RHS is not part of the table, then skip this FD
        if(isempty(strfind(attribs, left)) || isempty(strfind(attribs, right))) 
            fprintf('Warning: %s\n', 'FD Contains Non-Attributes and has been skipped!');
            continue; 
        end
        
        %Add the parsed tokens to the list of tokens
        LHS{counter, 1} = left;
        RHS{counter, 1} = right;
        counter = counter + 1;
    end
    
    %Remove duplicate FD's (if any)
    [LHS, RHS] = RemoveDuplicates(LHS, RHS);
    
    %Simplify the elements of FDS from complex into standard form
    [LHS, RHS] = GenerateStandardFD(LHS, RHS);
    %Print the FD's with the newly generated set
    PrintFDList(LHS, RHS);
    
    while(true)
        fprintf('\n%s\n%s\n', 'Enter a seed consisting of attributes.', 'Type ''quit'' when finished.');
    
        %Ask the user for a set of attributes as the seed
        seed = upper(input('Please enter the seed: ', 's'));
        %If the user enter's 'quit' it'll be converted to QUIT and we
        %should end the loop.
        if(strcmp(seed, 'QUIT')) break; end;
        
        %Strip out any non-attribute values from the seed
        seed = ValidateSeed(attribs, seed);
        
        %Compute the closure of the cleaned seed
        C = ComputeClosure(seed, LHS, RHS);
        
        %Print the closure
        fprintf('%s%s\n', 'Closure: ', C);
    end
end

function [LHS RHS] = GenerateStandardFD(LHS, RHS)
%Purpose: Reduces complex FD's into standard FD's and returns a list of the
%   newly generated dependencies appended to the passed lists.
%Precondition: LHS, RHS correspond to the tokenized version of
%   user-inputted functional dependencies.
%Returns: Two cell matrices of K elements where K is the number of standard
%   form functional dependencies generated from the passed lists. 

    fprintf('\n%s\n', '--Generating Standard FD''s--');
    %Number of current functional dependencies
    numFD = numel(RHS(:,1));
    %The number of new dependencies generated
    numNewFD = 0; 
    %The next storage location for the lists based on the current
    %   number of dependencies.
    counter = numFD + 1;
        
    %For each functional dependency
    for k = 1:numFD
        %Grab the left and right sides of the current dependency
        left = LHS{k, 1};
        right = RHS{k, 1};
        
        %The number of attributes in the rhs
        numAttribs = numel(right);
        %If the rhs only has a single char, then skip it
        if(numAttribs <= 1) continue; end
                  
        %for each attribute in the rhs
        for j = 1:numAttribs
            %Grab an attribute from the compound attribute
            attrib = right(j);
            
            %Add the standard form dependencies to the output list
            %The lhs stays the same but a dependency is created for each
            %   attribute on the rhs.
            LHS{counter, 1} = left;
            RHS{counter, 1} = attrib;
            
            %Increment the next storage location and number of newly
            %   generated fd's.
            counter = counter + 1;
            numNewFD = numNewFD + 1;
        end
    end
    
    if(numNewFD == 1)
        fprintf('%i%s\n', numNewFD, ' new dependency generated!');
    else
        fprintf('%i%s\n', numNewFD, ' new dependencies generated!');
    end
end


function C = ComputeClosure(seed, LHS, RHS)
%Purpose: Computes the closure of the given seed (set of attributes) from
%   the passed set of Functional Dependencies.
%Parameters:
%   seed: A valid (existing) set of attibutes from the attribs
%Returns: A set of attributes included in the closure of the seed.
%Notes:
%   Instead of generating all possible combinations of seed attributes and
%   testing if there's an FD that can be used to compute the closure, we
%   perform a simpler solution. 
%   
%   The system looks at the set of FD's and if the LHS of an FD is in the
%   closure, then we add the RHS to the closure and restart the search
%   through the set of FD's since the new closure attribs could trigger the 
%   use of previous FD's.

    fprintf('\n%s\n', '--Computing the Closure of the Seed--');
    
    %The closure of the seed includes (at least) the seed.
    C = seed;
    numFD = numel(LHS(:,1));
    
    %Keeps track of which FD's have already been used
    %0 = unused (false)
    %1 = used (true)
    %This allows us to skip over FD's that have been used in previous
    %   iterations of the search.
    fdUsedList = zeros(numFD, 1);
    
    while(true)
        %Whether or not an iteration through the FD list produced an addition
        %to the closure set. 
        newAttribsAdded = false;
        
        %For every FD in the system
        for k = 1 : numFD
            %If the FD has already been used, then skip it
            if(fdUsedList(k)) continue; end;
            
            %Cache the left and right hand sides of the current FD
            left = LHS{k, 1};
            right = RHS{k, 1};

            %Whether or not all of the elements in left are in C
            isInClosure = StringCombinationExists(C, left);
            
            %If the number of matches is equal to the size of the LHS
            if(isInClosure)
               %The LHS of the current FD is in the closure, so add the 
               %    RHS to the closure and remove any duplicate attributes. 
               C = unique([C right]);
              
               %Indicate that this FD has now been used
               fdUsedList(k) = true;               
               
               %Since we added attributes to the closure, set the flag that
               %allows us to loop through the FD list again.
               newAttribsAdded = true;
            end
        end %end for
        
        %If we went through the entire FD list and nothing new was added to
        %the closure, then we're done.
        if(newAttribsAdded == false)
            break;
        end
    end %end while
end %end ComputeClosure()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PrintFDList(LHS, RHS)
%Purpose: Prints an organized list of Functional Dependencies from a
%   collection of tokenized functional dependencies contained in the passed
%   arrays. 
    fprintf('\n%s\n','--Printing the list of FD''s--');
    numFD = numel(LHS(:,1));
    for k = 1 : numFD
        left = LHS{k,1};
        right = RHS{k,1};
        fprintf('%s->%s\n', left, right); 
    end
end

function [LHS, RHS] = RemoveDuplicates(LHS, RHS)
%Purpose: Removes the duplicate Functional Dependencies from the passed
%   associated arrays consisting of the tokenized left and right side
%   user-defined FD's.
%Notes: We use a simple O(N^2) algorithm to remove duplicates.
%Returns: The duplicate-free lists.

    %Remove duplicates using O(N^2) algorithm
    fprintf('\n%s\n', '--Removing Duplicate FD''s--');
    
    %The number of duplicates found
    numDups = 0;
    
    %Iterate from start to (finish - 1)
    numFD = numel(LHS(:,1));
    for k = 1 : (numFD - 1) 
        left = LHS{k, 1};
        right = RHS{k, 1};
        %Start from the current element's right neighbor
        for j = (k+1) : numFD
            nleft = LHS{j, 1};
            nright = RHS{j, 1};
            %If the super/outer element is equal to our current element          
            if(strcmp(left, nleft) && strcmp(right, nright))
                %Remove our current (inner for loop) element.
                LHS(j) = [];
                RHS(j) = [];
                %Recompute the length of the FD associations since we're
                %directly deleting an element of the original matrix
                numFD = numel(LHS(:, 1));
                numDups = numDups + 1;
            end
        end
    end
    
    %I'm a perfectionist, what can I say?
    if(numDups == 1)
        fprintf('%i%s\n', numDups, ' duplicate found!');
    else
        fprintf('%i%s\n', numDups, ' duplicates found!');
    end
end

function S = ValidateSeed(attribs, seed)
%Purpose: Removes the non-attribute characters from the passed seed by
%   cross-referencing with the set of attributes for the table.
%Returns: The cleaned seed values as a char array.

    %Copy the seed since we'll be modifying the set and we don't want the
    %numel(seed) to be affected.
    S = seed;
    %Strip all non-attributes from the seed
    for k = 1 : numel(seed)
        %Cache the current char
        c = seed(k);
        %If you couldn't find the current seed attribute in the list of
        %attributes for the table
        if(isempty(strfind(attribs, c)))
            %Remove the invalid attribute from the seed copy, S
            S(k) = [];
        end
    end
end

function R = StringCombinationExists(str, pattern)
%Purpose: Determines whether or not every element of pattern is in the
%   passed string, str.
%Returns: 
%   0 (false) = entire pattern doesn't exist in str
%   1 (true) = entire pattern was found

    %Intialize the output
    R = false;
    
    %Num matching chars between pattern and str
    numMatching = 0;   
    %For every char in the pattern
    for k = 1 : numel(pattern)
        %Cache the current char of the pattern
        p = pattern(k);
        %If we found the current char in str
        if(~isempty(strfind(str, p)))
            %Increment the number of matches
            numMatching = numMatching + 1;
        end
    end

    %If the number of matches is equal to the size of the pattern
    if(numMatching == numel(pattern))
        R = true;
    end
end