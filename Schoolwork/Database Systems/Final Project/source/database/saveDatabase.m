function saveDatabase(database)
% Purpose:  Saves the database matrix (consisting of tables) to a MAT file for later
%           loading and appending of new tables. 
% Notes:
%           This function will be called at various times in the program to 
%           facilitate saving the database at various checkpoints. 
%
%           Typically, this will occur when the user performs a database/table 
%           modification or extension.
%           
%           The save file's filename will be hardcoded for ease of use.
%
%           The database matrix is passed in to bring it to the local workspace
    save('database', 'database');