function C = computeclosure(key, LHS, RHS)
%Purpose:   Computes the closure of the given seed (set of attributes) from
%           the passed set of Functional Dependencies.
%Preconds:
%           key: A valid set of attibutes from the attribs
%Returns:   A set of attributes included in the closure of the seed.
%Notes:
%           Instead of generating all possible combinations of seed attributes and
%           testing if there's an FD that can be used to compute the closure, we
%           perform a simpler solution. 
%   
%           The system looks at the set of FD's and if the LHS of an FD is in the
%           closure, then we add the RHS to the closure and restart the search
%           through the set of FD's since the new closure attribs could trigger the 
%           use of previous FD's.

%     fprintf('\n%s\n', '-- Computing the Closure of the Key --');
    
    %The closure of the seed includes (at least) the seed.
    C = key;
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
            if(iscell(LHS) && iscell(RHS))
                left = LHS{k, 1};
                right = RHS{k, 1};
            else
                left = LHS(k, 1);
                right = RHS(k, 1);
            end
            
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
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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