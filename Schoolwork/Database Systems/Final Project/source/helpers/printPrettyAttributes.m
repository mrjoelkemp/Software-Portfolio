function printPrettyAttributes(attribs)
% Purpose:  Prints out a tab separated attribute listing in a nice format.
% Format:   Attrib      Attrib       Attrib
    arrayfun(@(attrib) fprintf('%s\t', attrib), attribs);
    fprintf('\n');
end
