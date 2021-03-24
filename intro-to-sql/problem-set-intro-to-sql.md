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

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->


<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: 7e148b35-e9e0-462d-bc21-decbab39296f
* title: Inserting New Products
* points: 1
* topics: sql, sql-insert

##### !question

You have a table named products with:

| id | name | publisher_id | description  | 
|--- |--- |--- |--- |
| 1  | Nimona | 1 | Wonderful comic by Noelle |
| 2 |  Watchmen | 2 | Dark, very dark |

The table was created with:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  publisher_id INT,
  description TEXT
);
```

Write an SQL query to add the following product to the table.  The id is omitted.

| name | publisher_id | description |
|--- |--- |--- |
| Jimmy Corrigan | 3  | The smartest kid on earth. |

When you finish, try your solution by creating the table and running your SQL statement in PSQL and then verify that the row appears with the following SQL query:

```sql
/* Should result with:
 id |      name      | publisher_id |        description         
----+----------------+--------------+----------------------------
  8 | Jimmy Corrigan |            3 | The smartest kid on earth.
(1 row)

*/
SELECT * FROM products 
WHERE name = 'Jimmy Corrigan';
```

##### !end-question

##### !placeholder

INSERT ...

##### !end-placeholder

<!-- Sample answer:
INSERT INTO products (name, publisher_id, description)
VALUES (
  'Blankets', 
  3, 
  'Semiautobiographical story of a young man raised in a strict evangelical tradition.');
-->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: a34660df-2b46-44e1-91a6-4721a586a3c0
* title: Updating Users
* points: 1
* topics: sql, sql-update

##### !question

You have a table named users created with:

```sql
CREATE TABLE users (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(32),
  last_name VARCHAR(32),
  email VARCHAR(32)
);
```

In the users table Cade O'Moore misspelled their name as "Coade OMoore".  Write an SQL query to change all drivers with the name "Coade OMoore" to "Cade O'Moore".

**How can you include an apostrophe (') in the last_name of your SQL query?**  Research a solution.

When you finish, try your solution by running the following in psql and then verify that the row appears with the following SQL query:

```sql
CREATE TABLE users (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(32),
  last_name VARCHAR(32)
);
INSERT INTO users (
  first_name,
  last_name
)
VALUES ('Coade', 'OMoore');

/* Insert your code here */

/* Test your query with the following
It should return with:
*/

SELECT * FROM users WHERE first_name = 'Cade';

/* Should result with:
 id | first_name | last_name |         email         
----+------------+-----------+-----------------------
  8 | Cade       | O'Moore   | cade.omoore@gmail.com
(1 row)
*/
SELECT * FROM users
WHERE first_name = 'Cade'
```

##### !end-question

##### !placeholder

INSERT ...

##### !end-placeholder

<!-- Sample answer:
UPDATE users
SET first_name='Cade',
last_name = 'O''Moore'
WHERE first_name = 'Coade' AND last_name='OMoore';
-->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->


<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: code-snippet
* language: sql
* id: e33ac2ce-1d31-4188-8e80-1f62960fe179
* title: SELECT products with publisher_id 3
* data_path: /intro-to-sql/sql-fixtures/create-products-table.sql
* points: 1
* topics: sql-select

##### !question

Given the table created by this code:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  description TEXT,
  publisher_id INT
);
```

Write a SELECT statement to retrieve only the names of products who's publisher_id is 3

##### !end-question

##### !placeholder

```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests

```sql
SELECT name
FROM products
WHERE publisher_id = 3;
```

##### !end-tests

<!-- other optional sections -->
<!-- !hint - !end-hint (markdown, hidden, students click to view) -->
<!-- !rubric - !end-rubric (markdown, instructors can see while scoring a checkpoint) -->
<!-- !explanation - !end-explanation (markdown, students can see after answering correctly) -->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->


<!-- 
Write a query to retrieve the full_name field of all the drivers with 1 or 2 digit ids (1-99).  You can assume all ids are positive.

-->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: code-snippet
* language: sql
* id: fe6f2b05-bf48-42c7-892c-e62000d66fed
* title: Select products with publishers ids between 0 and 100
* data_path: /intro-to-sql/sql-fixtures/create-products-table.sql
* points: 1
* topics: sql, sql-select

##### !question

Given the table created by this code:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  description TEXT,
  publisher_id INT
);
```

Write a SELECT statement to retrieve the names and descriptions of products who's publisher_id is a 1 or 2 digit number.

##### !end-question

##### !placeholder

```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests

```sql
SELECT name, description
FROM products
WHERE publisher_id >= 1 and publisher_id < 100;
```

##### !end-tests

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

Given the table created with:

```sql
CREATE TABLE users (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(32),
  last_name VARCHAR(32)
);
```

The user "Auster Alexandra" has retired.  Write an SQL statement to remove them from the users table.

```sql
/* Then paste in your code here. */

/* Your code should output:  
DELETE 1 
*/


/* 
To verify the table is gone run the following.

Should output:
 id | first_name | last_name | email 
----+------------+-----------+-------
(0 rows)
*/
SELECT * 
FROM users 
WHERE first_name = 'Auster' AND last_name = 'Alexandra';
```

##### !end-question

##### !placeholder



##### !end-placeholder

<!-- 
Sample Solution
DELETE FROM users
WHERE first_name = 'Auster' and last_name = 'Alexandra';
-->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->




