# Establishing Relationships


## Goals

- Create tables with columns linked to other tables.

## Introduction

In SQL we can create columns as foreign key fields at table creation, by adding new columns to existing tables or by modifying existing columns.  In this lesson we will learn the SQL syntax to create tables with foreign keys connecting them to other tables.

## Vocabulary and Synonyms

| Vocab           | Definition                                                                                                            | Synonyms             | How to Use in a Sentence                                                                                                                                                                                                                              |
| --------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Foreign Key        | A column in a database table that comes from another table (also known as the referenced table) who's value is either a primary key or another unique key in the referenced table.                                                    |      Referencing Key              | "The books table has an author_id column which references the primary key of the authors table."                                                                |


## Creating Tables With Foreign Keys

<!--  Note could also teach Foreign key creation with 
  author_id INT REFERENCES authors(id)

  This way is more explicit... maybe.

  We could also teach adding columns to tables to establish new foreign keys, but... they can just drop and recreate the table for now.  Students can research to to modify a table.
 -->

We have created tables with primary key columns in this fashion.

```sql
CREATE TABLE authors (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(32),
  last_name VARCHAR(32),
  bio TEXT
);
```

In this example the `id` column is called the *primary key* values in this column uniquely identify a particular row.  We can use this feature of relational databases to connect a row in one table with one or many rows in another.

Consider this `books` table.

```sql
CREATE TABLE books (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(32),
  description TEXT,
  isbn VARCHAR(32),
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(id)
);
```

The `books` table has a column named `author_id`.  We created `author_id` with the constraint `FOREIGN KEY (author_id) REFERENCES authors(id)`.  

This tells Postgres that every `author_id` value in the books table *must* reference an existing `id` value in the `authors` table.  Further, the referenced column (id) is also a primary key in the authors table.

Given the following authors table.

| id | first_name | last_name | bio |
|--- |--- |--- |--- |
| 14 | Michelle | Obama | Becoming is the memoir of former First Lady of the United States Michelle Oba... |

We can now create a book related to this author with the following SQL query.

```sql
INSERT INTO books (title, description, isbn, author_id)
VALUES ('Becoming', 'Becoming is the memoir of...', '978-3-16-148410-0', 14);
```

Because this row in the books table has an `author_id` (14) matching Michell Obama's `id` field the two entries are related.

This also applies to deleting rows in the table with the primary key.  If we tried to delete Michelle Obama, Postgres would return an error because there are existing books referencing that row in the authors table.

### !callout-warning

## The Foreign Key Must Exist In The Referenced Table

When we designate a column as a foreign key in this manner, any rows inserted into the table **must** include a value for that column and that value must exist in the referenced table.

Databases enforce this constraint to prevent an entry in one table from referencing a row which does not exist in the other table.  This is usually the best practice with regard to foreign keys.

If the author_id 1 does not exist in the authors table the following query.

```sql
INSERT INTO books (title, description, isbn, author_id)
VALUES ('book title', 'book description', '1-111-1111', 1);
```

Will result in:

```bash
ERROR:  insert or update on table "books" violates 
foreign key constraint "books_author_id_fkey"
DETAIL:  Key (author_id)=(1) is not present in table "authors".
```

### !end-callout

### !callout-info

## Other Methods To Create Foreign Keys

There are methods of creating optional foreign keys and ways to allow a foreign key field to be NULL.  Feel free to research this syntax.

### !end-callout

## Many To Many Relationships

To build a many to many relationship requires a table called a JOIN Table.  For example a book can be a part of many genres and each genre will have many books in it.  To create a relationship like this:


![Many to Many ERD diagram between books and genres](../assets/intermediate-sql_establishing-relationships_many-to-many.svg)
*Fig. Many to many relationship between books and genres*

We create the join table with the following SQL.

```sql
CREATE TABLE booksGenres (
  book_id INT,
  FOREIGN KEY (book_id) REFERENCES books(id),
  genre_id INT,
  FOREIGN KEY (genre_id) REFERENCES genres(id),
  PRIMARY KEY (book_id, genre_id)
);
```

This SQL creates a join table connecting the books and genres tables.  This table is different from prior tables in a few ways.

1.  The table lacks an `id` field as the primary key.
1.  The table **only** has two foreign key fields.
1.  The `booksgenres` table uses a combination of **two** columns as a primary key.
    *  This means that no two rows can exist with identical `book_id` and `genre_id` values.
1.  We *choose* to name the join table `booksGenres` a combination of the two parent table names.  SQL does not require any particular name.  This is simply a convention we will follow at Ada, to combine the table names for a join table alphabetically.

### Two Column Primary Keys

We could have created the `booksgenres` table with an `id` primary key, but using a two-field primary key has an advantage.  Using the combination of `book_id` and `genre_id` prevents duplicate entries.  In this case no book can be listed in the same genre twice.  A book can be in multiple different genres and a genre can have multiple different books, but only one entry can link an individual book to a particular genre.

If our `booksGenres` table contained these entries:

| book_id | genre_id |
|--- |--- |
| 1  | 1  |
| 2  | 1  |

The following SQL code would generate this error.

```sql
INSERT INTO booksGenres (book_id, genre_id)
VALUES(1, 1);
ERROR:  duplicate key value violates unique constraint "ordersproducts_pkey"
DETAIL:  Key (book_id, genre_id)=(1, 1) already exists.
```

## Check for Understanding

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: multiple-choice
* id: fdcbaaaa-06ea-4f29-b260-780adfa91bbe
* title: Creating a table with a foreign key
* points: 1
* topics: sql, sql-create, sql-foreign-key

##### !question

We are trying to write an SQL query to create a `students` table which references the student's advisor.  Which is the correct line to add to the sql code below.

```sql
CREATE TABLE students (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(32),
  last_name VARCHAR(32),
  advisor_id INT,
  /* What goes here? */
);
```

##### !end-question

##### !options

* `FOREIGN KEY advisors(id)`
* `FOREIGN KEY (advisor_id) REFERENCES advisors(id)`
* `REFERENCES (advisor_id) FOREIGN KEY advisors(id)`
* `FOREIGN KEY REFERENCES advisors(id)`

##### !end-options

##### !answer

* `FOREIGN KEY (advisor_id) REFERENCES advisors(id)`

##### !end-answer

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->



<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: 01d7747d-ab3a-4525-bf13-1e0ad060d666
* title: What is your key takeaway?

##### !question

What is your key takeaway from this lesson?

##### !end-question

##### !placeholder

Your key takeaway...

##### !end-placeholder

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->
