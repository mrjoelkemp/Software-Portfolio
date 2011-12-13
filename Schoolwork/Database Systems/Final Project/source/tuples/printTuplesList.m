function printTuplesList(tuples, schema)
% Purpose: Prints the tuples vertically and tab spaced.
    fprintf('\n--- Print Tuples List ---\n');
    attribs = keyset2char(schema.keySet());
    printPrettyAttributes(attribs);
    
    % For each tuple
    for k = 1 : numel(tuples(:,1))
       tuple = tuples(k,1);
       % For each column of the tuple
       for j = 1: numel(attribs)
           % Get the column
           attrib = attribs(j);
           % Get the value for that column
           val = tuple.(attrib);
           fprintf('%s\t', val); 
       end
       % After printing all values, go newline.
       fprintf('\n');
    end
end