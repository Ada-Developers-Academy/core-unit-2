# Intro to Relational Databases

## Learning Goals

- Define SQL as a language to query SQL databases

## Introduction

In Python projects, data is either temporarily stored onto a machine, or it's saved and _written_ to a machine. However, what does that look like? Does my computer look like someone else's computer? The following questions pop up:

- How and where does the data get stored?
  - How is the data organized?
  - How is this system managed?
- How do we ensure that this data will be available to me when we need it?
- How do we create a solution that can be consistent between many different kinds of machines?

Using and managing a _database_ to organize and store data is one great answer to these questions. Databases will let us save data on a machine, and will let Python programs access it later.

## Vocabulary and Synonyms

| Vocab | Definition | Synonyms | How to Use in a Sentence |
| ----- | ---------- | -------- | ------------------------ |

- Database
- SQL
- Postgres
- Database entities
- Primary key

## A Database Can Be Anywhere Wi

A **database** (or db for short) is an organized collection of stored and persisted data. Databases are responsible for storing data, organized in ways that are useful to us programmers.

The method and system of organization depends on the database type. The location of the database depends on the machine that we choose to put it on.

**Here's a metaphor**: Imagine that our program is a school classroom, that runs a bunch of processes, activities, and workshops. Imagine that our workshops use a lot of data, like supplies. We could put the supplies in the classroom, but it could get really messy. Instead, we can store our supplies in a supply closet, like a database. How we organize the supply closet, what kind of bins, boxes, and labels are in the supply closet, and how we get to the supply is up to us.

Therefore, the interesting challenge for us is learning how to make Python code _talk_ with a database. When working with databases, we should ask ourselves:

1. How do we structure data in the database? What rules does the database need to follow?
1. How do we communicate the db and retrieve or modify data?

When we talk with a database, we'll be able to create, read, update, or delete the specific data we need.

## SQL Communicates With Relational Databases

Databases are ways to organize and store data. After a database is setup, we can talk with it. But how?

**SQL** is a query _language_. It's a programming language specifically designed to talk to _relational databases_.

We will learn SQL syntax and write SQL statements. Relational databases will interpret the SQL statements and give us back the records we need.

### !callout-info

## Pronouncing SQL

A lot of people pronounce "SQL" as "Ess Cue El." A lot of other people pronounce "SQL" like "sequel." When talking about databases, both pronunciations get the message across. The history of the pronunciation is interesting, follow your curiosity!

### !end-callout

### Relational Databases

Relational databases are a kind of database.

Relational databases organize data in the form of many _tables_. Relational dbs will contain many tables of data, where the columns are attributes and the rows are records.

There is a family of relational db systems. Generally speaking, these db systems all operate similarly and accomplish the same responsibilities. They usually differ in how they are designed, ways that they are used, and various lower-level implementation details.

This is a list of various relational database systems:

- MySQL
- PostgreSQL
- SQLite
- Microsoft SQL Server
- Microsoft Azure SQL Database
- Apache Hive
- MariaDB

### !callout-info

## Foreshadowing: "_Relational_" Databases

Relational databases are unique because they are strong at expressing _relationships_ between data. Using data alone (with no Python at all!), relational databases can express composition. Look forward to seeing composition and SQL!

### !end-callout

### This Curriculum Uses Postgres

PostgreSQL, also known as **Postgres** (and sometimes seen as `psql`), is a free and open-source relational db system.

This curriculum will use PostgreSQL for the following reasons:

- Free and open-source
- Built-in compatibility with Heroku, a popular platform used often for free Flask app deployment
- It comes installed on macOS

### !callout-secondary

## "Database" in This Curriculum

For the remainder of lessons, this curriculum may use the phrases "relational database," "relational db system," and "database" interchangeably. We may define a concept that is only relevant to relational databases, and only say "database." For example, we may say that we have a Postgres db, even though fully we mean, "We are using PostgreSQL as our db management system."

### !end-callout

## Parts of a Database

The purpose of a database is to structure and store data. Usually data that is related to one or more projects.

One database can store database for _many_ different **database entities**. A _database entity_ is any single concept that needs to be stored, usually a single person, product, thing, or object. For example, imagine a micro-loan system. One single db for this webapp could have the entities "Borrower," "Lender," "Loan," "Loan Request," and "Repayment."

There are several components of a database. The following is an overview of a few key concepts:

1. Schema
1. Tables
   - Records and Attributes
   - Primary Keys (and IDs)

### Schema

A database schema is a set of programming statements that describe the organization of one database.

The schema usually defines:

- The name of each table
- The attributes (columns) of each table
- The data types of each column
- Any rules and constraints for each column or table

#### Data Types and Constraints in SQL

SQL dbs enforce data types and other constraints on columns on tables.

The following is a list of some data types available in Postgres. Refer to official documentation for a full list and their details:

- `boolean`
- `varchar` (A string that must be under a provided maximum length)
- `integer`
- `text` (A string that does not need a specificed maximum length)

| Data Type   | Notes                                                                                                                          |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `boolean`   |
| `varchar`   | Text. The user defines a maximum length.                                                                                       |
| `integer`   |
| `text`      | Text. The user does not define a maximum length.                                                                               |
| `numeric`   | A number that allows floats with precision. (Follow your curiosity to explore what precision and floats in databases implies.) |
| `timestamp` | Date and time, including time zone                                                                                             |
| `json`      | JSON. (This curriculum will not explore `json`. Follow your curiosity!)                                                        |

Constraints are rules on a column or table that can reject invalid data from ever entering the database. Some example constraints that can be defined on a column or table are:

- A value cannot be a null value (similar to `None` in Python). This implies that a value is _required_.
- Integers must be greater than 0
- A value must be unique compared to the other values in the same column and table

### !callout-warning

## Constraints Are Constraining

When we write Python code, we often encounter `TypeError`. In a similar idea, databases are _very_ explicit and strict about what data can be stored. This is security and safety feature; storing unsafe and unexpected data could compromise one table or a whole database.

### !end-callout

### Tables

Databases can have one more tables. Each table usually represents one _entity_.

The columns of the table are the attributes of the entity, and each row is a record of one entity.

Let's consider an example micro-loan system. If this micro-loan system has the entities "Borrower," "Lender," "Loan," "Loan Request," and "Repayment," then it would likely have one table for each entity, for a total of five tables.

This could be an example table for Borrowers named `borrowers`.

**borrowers**

| `full_name` (`varchar`) | `address` (`varchar`) |
| ----------------------- | --------------------- |
| -                       | -                     |

### !callout-secondary

## `varchar` vs. `text`

Why `varchar`? The `varchar` data type is great for text that isn't expected to be long. It also helps with db performance.

### !end-callout

#### IDs and Primary Keys

In our micro-loan system, imagine the following two records in our `borrowers` table:

| `full_name` (`varchar`) | `address` (`varchar`)                          |
| ----------------------- | ---------------------------------------------- |
| `Sabrina C. Hunter`     | `4654 Leisure Lane, San Luis Obispo, CA 93401` |
| `Sabrina C. Hunter`     | `615 Radio Park Drive, Augusta, GA 30901`      |

There are two borrowers named `Sabrina C. Hunter`. When our webapp needs to pull up Sabrina's address, which address gets pulled up?

Databases want to be able to distinguish records between each other easily and confidently. In order to do that, each table specifies one _column_ as the table's **primary key**.

The responsibility of the _primary key_ is to be a unique identifier. A table can have one and only one _primary key_.

A typical pattern is to **create an ID column in each table**, which will hold an integer. This ID integer typically has no relation to the other attributes. When we follow this pattern and use some additional Postgres syntax, Postgres will automatically attempt to add and increment ID numbers to records.

An example of the `borrowers` table with a primary key column named `id` could look like this:

| `id` (`int`, `PRIMARY KEY`) | `full_name` (`varchar`) | `address` (`varchar`)                          |
| --------------------------- | ----------------------- | ---------------------------------------------- |
| `97`                        | `Sabrina C. Hunter`     | `4654 Leisure Lane, San Luis Obispo, CA 93401` |
| `98`                        | `Sabrina C. Hunter`     | `615 Radio Park Drive, Augusta, GA 30901`      |

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: T7Yg8d
* title: Intro to Relational Databases
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
