function database = resetDatabase(database)
% Purpose:  Helps us reset the database by erasing its contents and saving a fresh
%           copy to file.
% Notes:    This is useful in testing since we periodically save in the system.
    database = cell(1);
    saveDatabase(database);
end