# Establishing Relationships


## Goals

- Create tables with columns linked to other tables.
- Add columns to previously existing tables

## Introduction

Databases such as Postgres are termed *relational databases*.  This is because we can establish relationships between tabes in our database.  This allows developers to selectively pull related information out of our datastore with specially crafted `SELECT` statements.

We have created database tables like the following.

| id | title | author | price | isbn |
|--- |--- |--- |--- |--- |
| 37 | Becoming | Michelle Obama. | 9.99 | '978-3-16-148410-0' |

*Fig. books table*

| id | first_name | last_name | bio |
|--- |--- |--- |--- |
| 14 | Michelle | Obama | Becoming is the memoir of former First Lady of the United States Michelle Oba... |

* Fig. authors table*

With these tables users can access information about books and about authors, but they cannot directly access the biographical information about the author from a particular book.

By establishing a relationship between the tables relational databases can provide that functionality.

## Vocabulary and Synonyms

| Vocab           | Definition                                                                                                            | Synonyms             | How to Use in a Sentence                                                                                                                                                                                                                              |
| --------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| One to Many Relationship        | A relationship between two tables in a database where one record in a table can be associated with one or more records in another table                                                     |                    | "Because each student has many advisors and each advisor my support multiple students, I established a one to many relationship between the two tables."                                                                |
| Many to Many Relationship        | A relationship between two tables in a database where one record in either table can relate to many records in the other table.                                                    |                    | "Because each student can take multiple classes and each class has many students I established a many to many relationship in the database."                                                                |
| One to One Relationship        | A relationship between two tables in a database where one record in either table can relate to at most one row in the other table.                                                    |                    | "Because each student can only have at most one school computer account, the user_accounts and students table have a one to one relationship."                                                                |
| Foreign Key        | A column in a database table that comes from another table (also known as the referenced table) who's value is either a primary key or another unique key in the referenced table.                                                    |                    | "The books table has an author_id column which references the primary key of the authors table."                                                                |


## Creating Tables With Foreign Keys

<!--  Note could also teach Foreign key creation with 
  author_id INT REFERENCES authors(id)

  This way is more explicit... maybe.

  We could teach adding columns to tables to establish new foreign keys, but... they can just drop and recreate the table for now.  Students can research to to modify a table.
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

Now the `books` table has a column named `author_id`.  We created with the constraint `FOREIGN KEY (author_id) REFERENCES authors(id)`.  

This tells Postgres that every `author_id` value in the books table *must* reference an existing `id` value in the `authors` table.  Further the referenced column (id) is also a primary key in the authors table.

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

### !callout-warning

## The Foreign Key Must Exist In The Referenced Table

When we designate a column as a forien key with `REFERENCES`, any rows inserted into the table **must** include a value for that column, in this case `author_id` and that value must exist in the referenced table.

Databases enforce this constraint to prevent an entry in one table from referencing a row which does not exist in the other table.

If the author_id 1 does not exist in the authors table the following query.

```sql
INSERT INTO books (title, description, isbn, author_id)
VALUES ('book title', 'book description', '1', 1);
```

Will result in:

```bash
ERROR:  insert or update on table "books" violates foreign key constraint "books_author_id_fkey"
DETAIL:  Key (author_id)=(1) is not present in table "authors".
```

### !end-callout

## Check for Understanding

<!-- TODO:  Reorder question with CREATE TABLE -->

<!-- TODO:  Reorder question with ALTER TABLE -->

<!-- TODO:  Question on key takeaway -->