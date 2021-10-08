# SQL Setup

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=d173c588-9ead-410a-ac5a-ad0500304e42&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goal

The goal of this lesson is to give clear instructions about how to setup your work environment so you can read and write SQL and work with Postgres databases.

This lesson should be read as a checklist of steps to follow once.

Afterwards, this lesson can be a helpful resource.

## Learning Goals

- Practice creating and dropping databases
- Practice creating and dropping tables

## Postgres Concepts to Know

There are a few things to briefly cover about Postgres:

- Postgres can and will manage multiple different databases on one machine
- _Users_ connect to Postgres
  - We need to create and use a Postgres user
  - We need to connect to one database before we interact with it

The most common default username and password for Postgres is:

- username: `postgres`
- password: `postgres`

Most tutorials will use these credentials, too. They are a good default for us until we have a better reason to pick something more secure.

## Installing Postgres

1. In any directory, run `$ brew install postgresql`
1. Run this command to make postgresql start at login: `$ brew services start postgresql`
1. Verify that it gives a success message

## Create the Postgres User

After installing Postgres, create the user named `postgres` with the command: 

```
$ createuser -s postgres
```

## Tools

Besides installing Postgres, we need to be able to:

- View databases and tables
- Connect to databases
- Send SQL statements to them

We can accomplish this using:

1. A database viewer tool
2. The `psql` interactive terminal

This lesson will focus on using the `psql` interactive terminal. However, for eyes weary of command line interfaces (CLIs) and looking for a software solution, we can recommend the following free tools:

- [pgAdmin](https://www.pgadmin.org/) (highly recommended)
- [Beekeeper Studio](https://www.beekeeperstudio.io/)

## Entering and Exiting the Postgres Terminal

To open the Postgres interactive terminal with a Postgres user named `postgres`, use this command:

```bash
psql -U postgres
```

The `psql` command starts a command line interface (CLI) that will let use type SQL statements and other postgres directives. Our regular terminal commands won't be accepted until we exit the CLI.

This is similar to how when we run `python` from the command line, it starts a command line interface that lets us enter Python statements. Many developer tools and utilities have similar command line interfaces.

By providing the option `-U postgres`, we tell `psql` that we want to start as the `postgres` user, which we just created. By default, `psql` will try to connect to a database with the same name as the user. It shows us the database name as part of the prompt `postgres=# `. We're now ready to start entering SQL commands and postgres directives!

```
psql (12.2)
Type "help" for help.

postgres=#
postgres=#
```

To exit the `psql` terminal, we use `\q`

```
postgres=# \q
```

Whenever we need help, we can use the following commands:

- `help` will summarize high-level `psql` commands
- `\?` will list all psql commands
- `\h` will list all SQL commands

### !callout-success

## Try It: Entering and Exiting

If this is your first time following this lesson, now is a great time to try out these commands!

### !end-callout

## Viewing Databases

To list all available Postgres databases on this machine, we use `\l`:

```
postgres=# \l
```

This will list databases by name. Here is an example listing:

```
                                      List of databases
               Name               |  Owner   | Encoding | Collate | Ctype | Access privileges
----------------------------------+----------+----------+---------+-------+-------------------
 postgres                         | postgres | UTF8     | C       | C     |
 media_ranker_development         | postgres | UTF8     | C       | C     |
```

## Creating a Database

To create a database with the name db_name, we use the following command:

```sql
CREATE DATABASE db_name;
```

### !callout-info

## SQL Requires Semicolons

This is our first line of proper SQL! SQL _requires_ semicolons (`;`) at the end of every statement. The Postgres terminal will not execute a SQL statement until it finishes with a `;`.

### !end-callout

For example, we can run the following command.

```sql
CREATE DATABASE simons_example_db;
```

This will give us the feedback `CREATE DATABASE`. We can confirm our database is created by listing all databases again with `\l`:

```
                                      List of databases
               Name               |  Owner   | Encoding | Collate | Ctype | Access privileges
----------------------------------+----------+----------+---------+-------+-------------------
 postgres                         | postgres | UTF8     | C       | C     |
 media_ranker_development         | postgres | UTF8     | C       | C     |
 simons_example_db                | postgres | UTF8     | C       | C     |
```

### !callout-success

## Try It: Create Your Own DB

If this is your first time following this lesson, try making a database using your name now! Afterwards, confirm that your new database exists with `\l`.

### !end-callout

## Connecting to Databases

We must connect to the one database we want to communicate with.

To connect to a database by name, we use `\c db_name`, where `db_name` is the name of the database.

```
postgres=# \c db_name
```

We should get the feedback `You are now connected to database "db_name" as user "postgres".` Our Postgres terminal prompt should also change.

```
postgres=# \c simons_example_db
You are now connected to database "simons_example_db" as user "postgres".
simons_example_db=#
```

### !callout-success

## Try It: Connect to Your Database

Connect to your new database now before moving on to make view, create, and drop tables.

### !end-callout

## Viewing Tables

We can view a list of all tables that are within the connected database using the `\dt` command.

```
simons_example_db=# \dt
```

If no tables within this database exist (which is usually true for newly created databases), we will get the feedback `Did not find any relations.`

Otherwise, this will list databases by name. Here is an example listing:

```
               List of relations
 Schema |         Name         | Type  | Owner
--------+----------------------+-------+-------
 public | reviews              | table | postgres
```

## Creating Tables

Before we create a table, we should determine:

- The name of the table
- Columns and their data type
- Any column constraints
- Which column is the primary key

All of these properties can be changed (and columns can be added and removed). Only the name is required.

This is the SQL syntax for creating a table:

```sql
CREATE TABLE example_table_name (
	column_name data_type constraint_name,
	column_name data_type constraint_name
);
```

| <div style="width:200px;">Piece of Code</div> | Notes                                                                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `CREATE TABLE`                                | SQL command to create a table                                                                                                       |
| `example_table_name`                          | **Replace this** with the name of the new table                                                                                     |
| `( ... );`                                    | The inside of the `()` will contain details about the table. **This statement ends in a semicolon**.                                |
| `column_name`                                 | **Replace this** with the name of a new column                                                                                      |
| `data_type`                                   | **Replace this** with the data type of the new column                                                                               |
| `constraint_name`                             | **Replace this** with any constraints                                                                                               |
| `,`                                           | In `CREATE TABLE`, column definitions are comma-separated. We can define multiple columns in this command by comma-separating them. |

To create a table with columns and a primary key, we can add `PRIMARY KEY` next to the column definition.

```sql
CREATE TABLE example_table_name (
	column_name data_type PRIMARY KEY,
	column_name data_type constraint_name
);
```

There are many ways to designate the primary key, so follow your curiosity for more options.

### !callout-info

## Naming Conventions for Tables and Columns

There isn't a fixed naming convention for naming databases, tables, and columns, so it's always best to defer to whatever the team is using. Names could be lower_snake_case, PascalCase, or something else entirely. Table names could be singular or plural. This curriculum will arbitrarily prefer:

- lower_snake_case for database, table, and column names
- plural table names

### !end-callout

### An ID Should Auto-Increment

We've learned that a common pattern is to have an ID column in each table, which will help uniquely identify each record. This column is usually the table's primary key. But it turns out that keeping track of the next unique ID number is harder than we might expect.

Fortunately, Postgres provides a way for the database to track this _for_ us.

Watch for the line `id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY` in the `CREATE TABLE` examples below.

- `id INT` says that there is a column named `id` of the data type integer
- `PRIMARY KEY` designates that this column `id` is the primary key of the table
- `GENERATED ALWAYS AS IDENTITY` designates that Postgres should always generate this id for us

Postgres is great at managing what the next best ID and primary key is. Ideally, we will never need to _set_ any primary keys.

### Examples on Creating Tables

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. How many columns are there?
1. For each column, what is the column name and data type?
1. Which column is the _primary key_?
1. Which pieces of syntax are unfamiliar?

#### 1. Representing Authors

```sql
CREATE TABLE authors (
  author_name VARCHAR(100),
  author_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY
);
```

- The name of the table is `authors`
- There are two columns:
  - `author_name` with the data type `VARCHAR(100)`
  - `author_id` with the data type `INT`
- `author_id` is the primary key column

#### 2. Representing Drivers

```sql
CREATE TABLE drivers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  vin VARCHAR(50),
  is_available BOOLEAN
);
```

- The name of the table is `drivers`
- There are three columns:
  - `id` with the data type `INT`
  - `vin` with the data type `VARCHAR(50)`
  - `is_available` with the data type `BOOLEAN`
- `id` is the primary key column

#### 3. Representing Assorted Media

```sql
CREATE TABLE media (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  category VARCHAR(50) NOT NULL,
  title VARCHAR(200) NOT NULL,
  creator TEXT,
  publication_year VARCHAR(10),
  description_text TEXT
);
```

- The name of the table is `media`
- There are six columns:
  - `id` with the data type `INT`
  - `category` with the data type `VARCHAR(50)`
  - `title` with the data type `VARCHAR(200)`
  - `creator` with the data type `TEXT`
  - `publication_year` with the data type `VARCHAR(10)`
  - `description_text` with the data type `TEXT`
- `id` is the primary key column

### Feedback on Creating Tables

Successfully running the `CREATE TABLE` command will give us the feedback `CREATE TABLE`. We can confirm our table is created by listing all tables again with the `\dt` command.

Here is an example of creating a table and its output:

```
simons_example_db=# CREATE TABLE simons_example_table();
CREATE TABLE
simons_example_db=# \dt
                List of relations
 Schema |         Name         | Type  |  Owner
--------+----------------------+-------+----------
 public | simons_example_table | table | postgres
(1 row)
```

### !callout-success

## Try It: Create a Table

If this is your first time going through this lesson, try to create a new table in your connected database. Then, list the tables using the `\dt` command.

### !end-callout

## Dropping Tables

To delete, or _drop_ a table by name, observe the following syntax, where `example_table_name` is the table name.

```sql
DROP TABLE example_table_name;
```

When successful, this command should give us the feedback `DROP TABLE`. After listing all tables with the `\dt` command, we should confirm that our deleted table is not there.

## Dropping Databases

We can _drop_ (delete) a whole database using this command, where `db_name` is the name of the database to drop.

```sql
DROP DATABASE db_name;
```

### !callout-success

## Try It: Drop a Table and Database

If this is your first time going through this lesson, try to drop a table. Then, list the tables using `\dt` to confirm.

### !end-callout

### !callout-danger

## Dropped Databases are Irrecoverable

We cannot undo dropping a database. We will practice dropping databases and tables on our local machines for practice because there are fewer consequences for lost data. However, dropping databases cannot be undone, so exercise caution.

### !end-callout

## Debugging Creating/Dropping Databases and Tables

| <div style="width:210px;">Error Description</div> | What It Could Mean                                                                                                                                                        |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ERROR: table "example_table" does not exist`     | Check if there is a table in the connected database with the name `example_table` and check for spelling. You can use `\dt` to list the tables in the connected database. |
| `FATAL: database "example_db" does not exist`     | Check databases with `\l`                                                                                                                                                 |
| `ERROR: syntax error at or near "COMMAND"`        | Some statement has incorrect syntax. **Check that the statement ends with a semicolon (`;`)**.                                                                            |
| `Nothing happens when I try to run a command`     | Most likely there is a semicolon missing, and the prompt is waiting for you to keep typing. Try just entering `;` on its own.                                             |

## Random Debugging

Here is an out-of-context list of debugging strategies that could come up during this lesson, or any SQL lesson.

- Restart Postgres with `$ brew services restart postgres`
  - This is a great default debugging strategy if there is an error about "connecting" to Postgres
- Restart the machine
  - This is another great way to restart Postgres
- List users with `\du`
  - This has information on user names, roles (permissions), and groups
- Copy and paste error messages and search on the Internet frequently, and specify macOS
  - Postgres is 30 years old; there is a lot of great advice out there!

## Summary: Get to an Empty Database and Table

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 3e22effd-b66f-4b6a-ad89-20bed46072b5
* title: SQL Setup
##### !question

While doing the SQL setup for the first time, use this checklist to make sure you tried everything.

##### !end-question
##### !options

* Install PostgreSQL
* Open the Postgres terminal as user `postgres` with `$ psql -U postgres`
* List all databases with `\l`
* Create a database with `CREATE DATABASE db_name;`
* Connect to a database with `\c db_name`
* List all tables in the connected db with `\dt`
* Create a table with `CREATE TABLE table_name ( ... );`
* Drop a table

##### !end-options
### !end-challenge
<!-- prettier=ignore=end -->

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: GYZi7D
* title: SQL Setup
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
