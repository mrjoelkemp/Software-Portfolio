function [B tuples] = violatesMVDs(tuples, mvds, schema)
% Purpose:  Determines which 
% Notes:    Tuples violate mvds if there are tuples missing when swapping values.
% Returns:  B: Whether or not the MVDs were violated.
%           tuples: Original tuples list with the expected tuples appended.
    B = false;    
    % For every mvd in the passed list
    for k = 1: numel(mvds)
        mvd = mvds{k};
        [violated, expectedTuples] = violatesMVD(tuples, mvd);
        if(~violated) continue; end
        
        B = true;
        %Print error msg 
        fprintf('The MVD %s ->-> %s was violated!\n', mvd.lhs, mvd.rhs);
        fprintf('The following tuples will be added:\n');
        printTuplesList(expectedTuples, schema);

        %Adding them to the set of tuples.
        tuples = addTuplesToTuplesList(expectedTuples, tuples); 
        fprintf('\nThe new list of tuples includes:\n');
        printTuplesList(tuples, schema);
    end
end

function [B, expectedTuples] = violatesMVD(tuples, mvd)
% Returns:  B: Whether or not the tuples violate the mvd
%           expectedTuples: The missing tuples that would satisfy the mvd
    B = false;
    expectedTuples = [];
    
    lhsAttribs = mvd.lhs;
    rhsAttrib = mvd.rhs;
    % Get the columns for all the lhs attributes
    lhscolvals = getMultipleTupleColumnValues(tuples, lhsAttribs);
    % Combine them into strings
    rowstrings = columnvalues2strings(lhscolvals);
    % Find the unique rows
    urows = unique(rowstrings);
    % For each unique row
    for k = 1:numel(urows)
        row = urows{k};
        % Find all rows containing these values for these attributes
        % Do not use tuples, use colvals since we want to know which tuples have
        % the LHS attribute values equal to the unique LHS vals in question.
        idx = ismember(lhscolvals, row);
        % If the count of the rows containing these values is more than one
        hasMultRows = sum(idx) > 1;
        if(~hasMultRows) continue; end
        
        % Store the tuples
        tuplesWhereLHSAttribsEqual = tuples(idx == 1);
        
        % Perform swapping to see if the proper tuples exist
        
        % Grab the column of values for the RHS attribute to be swapped
        rhscolvals = getTupleColumnValues(tuplesWhereLHSAttribsEqual, rhsAttrib);
        
        % Tuple index combinations/comparisons for swapping
        combs = nchoose2(1:numel(rhscolvals));
        % For each tuple index combination
        for j = 1: numel(combs(:,1))
            comb = combs(j,:);
            % Get the tuple indices for the current combination
            t1index = comb(1);
            t2index = comb(2);
            
            tuple1 = tuplesWhereLHSAttribsEqual(t1index);
            tuple2 = tuplesWhereLHSAttribsEqual(t2index);
            
            % Swap the rhs value for tuple1 with tuple2's rhs value
            newTuple1 = tuple1;
            newTuple1.(rhsAttrib) = rhscolvals{t2index};
            newTuple2 = tuple2;
            newTuple2.(rhsAttrib) = rhscolvals{t1index};
            
            % Check if the new tuples actually exist in the list or original tuples.
            if(~tupleExists(newTuple1, tuples))
                expectedTuples = addTupleToTuplesList(newTuple1, expectedTuples);
                % Add it to the original list to prevent duplicates
                tuples = addTupleToTuplesList(newTuple1, tuples);
                B = true;
            end
            if(~tupleExists(newTuple2, tuples))
                expectedTuples = addTupleToTuplesList(newTuple2, expectedTuples);
                tuples = addTupleToTuplesList(newTuple2, tuples);
                B = true;
            end
        end
        
    end
end

function tuplesList = addTuplesToTuplesList(tuples, tuplesList)
% Purpose: Appends the tuples into the existing tuples list.
% Precond: Tuples and TuplesList are vertical struct arrays
% Returns: The combined tuples list.
    numNewTuples = numel(tuples);
    for k = 1 : numNewTuples
       tuple = tuples(k);
       tuplesList = addTupleToTuplesList(tuple, tuplesList);
    end
end

function tuples = addTupleToTuplesList(tuple, tuples)
% Purpose:  Adds the tuple to the list of tuples. 
% Precond:  Tuples is a column array of structs
% Notes:    If the tuples list is empty, then we cant simply append the tuple, this
%           causes an assignment mismatch for structs.
    if(isempty(tuples))
        tuples = tuple;
    else
        numTuples = numel(tuples);
        tuples(numTuples + 1, 1) = tuple;
    end

end

function B = tupleExists(tuple, tuples)
% Purpose:  Determines if the passed tuple exists in the list of tuples
% Notes:    Converts each structure to strings to do ismember() comparisons.
% Returns:  True if the tuple exists, false otherwise.
    % Convert the tuple to a string
    tstring = struct2string(tuple);
    % Convert the tuples to strings
    tupsstrings = tuples2strings(tuples);
    B = ismember({tstring}, tupsstrings);
end