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

## Adding Columns To Existing Tables

## Check for Understanding

<!-- TODO:  Reorder question with CREATE TABLE -->

<!-- TODO:  Reorder question with ALTER TABLE -->

<!-- TODO:  Question on key takeaway -->