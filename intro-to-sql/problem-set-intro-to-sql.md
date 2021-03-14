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

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: 615ead30-fb6f-43f0-ab55-4072dd34bf5c
* title: Create Reviews Table
* points: 1
* topics: sql, sql-create

##### !question

Write the SQL statement to create a `reviews` table with the following fields:

* id - INT, primary key and auto-incrementing
* title - VARCHAR(32)
* product_id - INT
* body - TEXT
* creator_id - INT
* stars - INT

When you finish run the statement in psql and verify that it worked with the SQL code below.

```sql
/* Insert your code here */

/* Should output: 
 exists 
--------
 t
(1 row)
*/
SELECT EXISTS(  SELECT * FROM information_schema.tables WHERE table_schema='public' AND table_name='reviews');

/* Should output:
INSERT 0 1
*/
INSERT INTO reviews (title, product_id, body, creator_id, stars)
VALUES('The greatest book ever!', 3, 'This comic was so inspring!', 4, 5);
```

##### !end-question

##### !placeholder

CREATE TABLE ...

##### !end-placeholder

<!-- Sample solution 
CREATE TABLE reviews (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(32),
  product_id INT,
  body TEXT,
  creator_id INT,
  stars INT
);
-->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->


<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: 8d615f33-c3de-4dcd-a437-b41f2b5e5d31
* title: Drop Books Table
* points: 1
* topics: sql, sql-drop

##### !question

A teammate Rosie Rivet created a `books` table, but requirements have changed and the schema no longer needs that table.  Write SQL code to remove that table.

When you finish write this code into PSQL and then run your solution to verify that it works.

```sql
/* Paste in your code here. */

/* Your code should output:  
DROP TABLE 
*/


/* 
To verify the table is gone run the following.

Should output (notice the "f"): 
 exists 
--------
 f
(1 row)
*/
SELECT EXISTS(  SELECT * FROM information_schema.tables WHERE table_schema='public' AND table_name='books');
```

##### !end-question

##### !placeholder

##### !end-placeholder

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->


<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: c2058335-b551-4420-a664-ec30594bf47d
* title: Inserting New Publishers
* points: 1
* topics: sql, sql-insert

##### !question

You have a table named publishers with:

| id | name | address | 
|--- |--- |--- |
| 1  | Glasgow Publishers | 123 Elm Street, Glasgow, Scotland, 10358  |
| 2 | Spring Rabbits Comics  | P.O. Box 11234, Tuscon, AZ 85487 |
| 3 | Ahmed Enriquez |    P.O. Box 98111, Los Angeles, CA 98774 |

The table was created with:

```sql
CREATE TABLE publishers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  address VARCHAR(64)
);
```

Write an SQL query to add the following publisher to the table.

| name | address | 
|--- |--- |
| Dark Pony Gaming | 315 5th Ave S Suite 200, Seattle, WA 98104  |

When you finish, try your solution by creating the table and running your SQL statement in PSQL and then verify that the row appears with:

```sql
/* Should result with:
 id |       name        |                  address                   
----+-------------------+--------------------------------------------
  6 | Dark Pony Gaming | 315 5th Ave S Suite 200, Seattle, WA 98104
(1 row)
*/
SELECT * FROM publishers 
WHERE name = 'Dark Pony Gaming';
```

##### !end-question

##### !placeholder

INSERT ...

##### !end-placeholder

<!-- Sample answer:
INSERT INTO publishers (name, address)
VALUES ('Dark Pony Gaming', '315 5th Ave S Suite 200, Seattle, WA 98104');
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




