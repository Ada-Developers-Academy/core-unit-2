# Problem Set: More Selecting in SQL

## Directions

Complete all questions below.

## Practice

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: code-snippet
* language: sql
* id: 18206d9a-fde5-403d-a6ca-52686ff6cc9c
* title: More Selecting in SQL
* data_path: /more-selecting-in-sql/sql/problem-set.sql

##### !question

Consider a table defined by the following SQL command:

```sql
CREATE TABLE flowers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  soil_type VARCHAR(32),
  light_level VARCHAR(32),
  season VARCHAR(32)
);
```

Write a `SELECT` statement that retrieves the names of the flowers that prefer `'acidic'` soil and `'partial shade'`.

##### !end-question

##### !placeholder


```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests


```sql
SELECT name
FROM flowers
WHERE soil_type = 'acidic'
AND light_level = 'partial shade';
```

##### !end-tests

##### !explanation

This is an example solution:

```sql
SELECT name
FROM flowers
WHERE soil_type = 'acidic'
AND light_level = 'partial shade';
```

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: code-snippet
* language: sql
* id: bb564e7c-65f3-4abd-bcdb-60e5d1e41918
* title: More Selecting in SQL
* data_path: /more-selecting-in-sql/sql/problem-set.sql

##### !question

Consider a table defined by the following SQL command:

```sql
CREATE TABLE flowers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  soil_type VARCHAR(32),
  light_level VARCHAR(32),
  season VARCHAR(32)
);
```

Write a `SELECT` statement that retrieves the names of the flowers that are in season in `'spring'` or `'summer'`.

##### !end-question

##### !placeholder


```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests


```sql
SELECT name
FROM flowers
WHERE season = 'spring'
OR season = 'summer';
```

##### !end-tests

##### !explanation

This is an example solution:

```sql
SELECT name
FROM flowers
WHERE season = 'spring'
OR season = 'summer';
```

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: code-snippet
* language: sql
* id: 23eab1dd-08c0-4078-89dd-1f7e3c677084
* title: More Selecting in SQL
* data_path: /more-selecting-in-sql/sql/problem-set.sql

##### !question

Consider a table defined by the following SQL command:

```sql
CREATE TABLE students (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(64),
  height_in_cm INT,
  age INT
);
```

Write a `SELECT` statement that retrieves the names and heights of the students from tallest to shortest.

##### !end-question

##### !placeholder


```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests


```sql
SELECT name, height_in_cm
FROM students
ORDER BY height_in_cm DESC;
```

##### !end-tests

##### !explanation

This is an example solution:

```sql
SELECT name, height_in_cm
FROM students
ORDER BY height_in_cm DESC;
```

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: code-snippet
* language: sql
* id: aff65ecd-9bb6-4928-bc3b-4d7b0ca6428b
* title: More Selecting in SQL
* data_path: /more-selecting-in-sql/sql/problem-set.sql

##### !question

Consider a table defined by the following SQL command:

```sql
CREATE TABLE students (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(64),
  height_in_cm INT,
  age INT
);
```

Write a `SELECT` statement that retrieves the name and age of the youngest student.

##### !end-question

##### !placeholder


```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests


```sql
SELECT name, age
FROM students
ORDER BY age
LIMIT 1;
```

##### !end-tests

##### !explanation

This is an example solution:

```sql
SELECT name, age
FROM students
ORDER BY age
LIMIT 1;
```

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: code-snippet
* language: sql
* id: 22c79ec1-36b3-4698-b3a1-6bd98a28d20e
* title: More Selecting in SQL
* data_path: /more-selecting-in-sql/sql/problem-set.sql

##### !question

Consider a table defined by the following SQL command:

```sql
CREATE TABLE states (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(64),
  area_sq_mi FLOAT,
  population INT
);
```

Write a `SELECT` statement that retrieves the name and population of the five states with the lowest populations.

##### !end-question

##### !placeholder


```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests


```sql
SELECT name, population
FROM states
ORDER BY population
LIMIT 5;
```

##### !end-tests

##### !explanation

This is an example solution:

```sql
SELECT name, population
FROM states
ORDER BY population
LIMIT 5;
```

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: code-snippet
* language: sql
* id: 6adbe31a-f7f7-4d2a-8fba-42594a19d596
* title: More Selecting in SQL
* data_path: /more-selecting-in-sql/sql/problem-set.sql

##### !question

Consider a table defined by the following SQL command:

```sql
CREATE TABLE states (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(64),
  area_sq_mi FLOAT,
  population INT
);
```

Write a `SELECT` statement that retrieves the name and area of the third largest state.

##### !end-question

##### !placeholder


```sql
-- write a statement to select...
```

##### !end-placeholder

##### !tests


```sql
SELECT name, area_sq_mi
FROM states
ORDER BY area_sq_mi DESC
LIMIT 1
OFFSET 2;
```

##### !end-tests

##### !explanation

This is an example solution:

```sql
SELECT name, area_sq_mi
FROM states
ORDER BY area_sq_mi DESC
LIMIT 1
OFFSET 2;
```

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->

