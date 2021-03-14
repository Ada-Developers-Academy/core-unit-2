# Problem Set:  Intro to SQL

In the following exercise, Amazdun books is a new startup founded to sell ecomics and self-published Zines online.  We are contracted you to construct a number of queries.

## Import Sample Database

We are providing a sample database to use as you practice writing SQL queries. 

To use the sample database, first download the following SQL file by right-clicking on the file and saving it to your computer.

* [Starting Database]() - TODO ADD LINK

Then import the file:

```bash
$ psql -u postgres
psql (13.2)
Type "help" for help.

postgres=> CREATE DATABASE intro_to_sql_problem_set;
CREATE DATABASE
postgres=> exit

$  psql -U postgres -d intro_to_sql_problem_set < intro-to-sql-problemset.sql
CREATE TABLE
ALTER TABLE
CREATE TABLE
ALTER TABLE
COPY 7
COPY 7
ALTER TABLE
```

You can then access the sample database under psql with the command `\c intro_to_sql_problem_set`

## Answer the Following Questions

<!-- Question on CREATE TABLE 

- Create a drivers table with the following fields:
  - full_name - VARCHAR(32)
  - id  - PRIMARY KEY INT (auto-incremented)
  - VIN - VARCHAR(32)

-->

<!-- Question on DROP TABLE

You have a table named drivers, write the code to remove that table from the database.

-->

<!-- Question on Adding New Records

You have a table drivers with:

| id | full_name | vin | 
|--- |--- |--- |
| 1  | Armaan Salinas | AACC32171121 |
| 2 | Mitchell Irwin  | BCE118831AB1 |
| 3 | Cade O'Moore |    BDD198112137 |

Insert a new entry for the driver "Oluwatobiloba Knott" and the VIN number "EDA118132136"

-->

<!-- 
In the drivers table Cade O'Moore misspelled their name as Coade OMoore.  Write an SQL query to change all drivers with the name "Coade OMoore" to "Cade O'Moore".

-->

<!-- 
Write a query to retrieve the full_name field of all the drivers with 1 or 2 digit ids (1-99).  You can assume all ids are positive.

-->

<!--

The Driver "Armaan Salinas" has retired.  Write an SQL statement to remove them from the drivers table.

-->




