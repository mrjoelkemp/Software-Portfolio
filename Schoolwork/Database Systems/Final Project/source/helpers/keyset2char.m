function s = keyset2char(keySet)
% Purpose: Converts a java keySet object to a simple char array.
% Precondition: keySet: A Java KeySet object.
% Returns: A simple char array containing the keys in the passed keySet.
    s = char(keySet);
    %Remove the commas, spaces, and brackets leaving only the keys
    s(s == ',') = [];
    s(s == ' ') = [];
    s(s == '[') = [];
    s(s == ']') = [];
end