FLOOR library (Sqlite ORM) 

typesafe, reactive, lightweight, sqlite 

Examples
can do database query with dart object
@insert 
@delete 

Three important annotations 
1. @database (database)
2. @entity (Table structure)
3. dao (database query)

Call dao in database class to generate 
use part 'database.g.dart' to generate database file 
floor auto generate related classes


To create database 

we call ( future: $FloorNoteDatabase.databaseBuilder('note.db').build(),)

write insert, update functions in dao 