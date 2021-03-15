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

## Creating Tables With Foreign Keys

## Adding Columns To Existing Tables

## Check for Understanding

<!-- TODO:  Reorder question with CREATE TABLE -->

<!-- TODO:  Reorder question with ALTER TABLE -->

<!-- TODO:  Question on key takeaway -->