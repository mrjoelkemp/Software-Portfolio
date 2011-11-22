Author: Joel Kemp
Created: Fall 2011
Purpose: The first project for Database Systems 1 at CCNY.

This submission consisted of two small problems (the details of which can be found in assignment.txt). Both solutions were coded in Matlab. I particularly like the coding style of Problem 2. At this point, I'm still trying to find a documentation style that makes the code more readable and professional looking. The style shown in these two problems was adopted from other programmers.

The first problem was to create a system that allowed a user to define several items: a database consisting of tables, table schemas, and functional dependencies. The system then determined the set closure of certain user-supplied attributes.

The second problem involved creating a system that again allowed a user to define a database and its corresponding table schemas, but emphasized building a parser for a simplified SQL Select statement. The system would parse and validate the user's entered query for syntax and proper attribute referencing. The implementation used regular expressions to break the query into its components and Java Hashmaps exposed through Matlab for storage of the table schemas.