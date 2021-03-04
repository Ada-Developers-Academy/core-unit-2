# Intro to Relational Databases

## Learning Goals

- Define SQL as a language to query SQL databases
- Define primary key
<!-- NOTE:  I feel like there should be a LG around explaining how relational databases organize data -->

## Introduction

In Python projects, data is either temporarily stored onto a machine, or it's saved and _persisted_ on a machine. However, what does that look like? The following questions pop up:

- How and where does the data get stored?
  - How is the data organized?
  - How is this system managed?
- How do we ensure that this data will be available to me when we need it?
- How do we create a solution that can be consistent between many different kinds of machines?

Using and managing a _database_ to organize and store data is one great answer to these questions. Databases will let us save data on a machine, and will let Python programs access it later.

## Vocabulary and Synonyms

| Vocab           | Definition                                                                                                            | Synonyms             | How to Use in a Sentence                                                                                                                                                                                                                              |
| --------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Database        | An organized collection of stored and persisted data                                                                  | db                   | "My project stores all user data, such as name, email, and their content, in a database," "I used to keep my data all in a spreadsheet, but my app will be better if I use a database"                                                                |
| SQL             | A query language specifically designed to talk to relational databases                                                | "Sequel"                    | "I added 50 new records to the database using SQL statements," "I forgot the SQL syntax to create a database and create a table in that database"                                                                                                     |
| Postgres        | A specific kind of relational database                                                                                | PostgreSQL, psql, pg | "I heard that postgres is a database that's a little different from mySQL, but not very different and I could learn both," "When talking to my database, I got an error saying that the psql connection was bad, so I restarted my Postgres services" |
| Database entity | A single concept that needs to be stored in a table and database, such as a kind of person, product, thing, or object | -                    | "When I started my project, I considered all of the database entities I needed to store, such as users, posts, and comments."                                                                                                                         |
| Primary key     | An attribute dedicated to being a unique identifier for each row in a table                                           | PK                   | "Even though two rows had the same name, they had different primary keys," "I was able to retrieve the correct row each time because I queried using primary keys."                                                                                   |

## A Database Can Be Installed on Any Machine

A **database** (or db for short) is an organized collection of stored and persisted data. Databases are responsible for storing data, organized in ways that are useful to us programmers.

_Where_ are databases? Databases are stored on any compatible machine, whether it's a dedicated database server, or even on our own laptops.

Using a db effectively means considering how data is structured and represented in our database, and how to get existing data, and add new data.

### Databases Hold and Organize Data

Different database types will specify different methods and systems of organizing the data.

**Here's a metaphor**: Imagine that you are running a series of children's art and crafts workshops.  These workshops would consume a lot of supplies (paint, paper, brushes, etc) which represents our data.  We could just use disposible supplies, keep them on the floor of our classroom and throw them out after each workshop.  Over time, our classroom could get really messy, and create a lot of waste.

Instead, we can store our supplies in a supply closet, which is our database. How we organize the supply closet, what kind of bins, boxes, and labels are in the supply closet, and how we get to the supply closet is up to the type of database we're using and the decisions we make.

When working with databases, we should ask ourselves:

1. How do we structure data in the database? What rules does the database need to follow?
1. How do we communicate with the db to retrieve or modify data?

When we talk with a database, we'll be able to create, read, update, or delete the specific data we need.

## SQL Communicates With Relational Databases

After a database is setup, we can talk with it. But how?

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

PostgreSQL, also known as **Postgres** (and often seen as `psql`), is a free and open-source relational db system.

This curriculum will use PostgreSQL for the following reasons:

- Free and open-source
- Built-in compatibility with Heroku, a popular platform used often for free Flask app deployment
- It is easy to install on macOS

### !callout-secondary

## "Database" in This Curriculum

For the remainder of lessons, this curriculum may use the phrases "relational database," "relational db system," and "database" interchangeably. We may define a concept that is only relevant to relational databases, and only say "database." For example, we may say that we have a Postgres db, even though fully we mean, "We are using PostgreSQL as our db management system."

### !end-callout

## Parts of a Database

Databases structure and store data that is related to one or more projects.

One database can store data for many different **database entities**. A _database entity_ is any single concept that needs to be stored, usually a kind of person, product, thing, or object. For example, imagine a micro-loan system. One single db for this webapp could have the entities "Borrower," "Lender," "Loan," "Loan Request," and "Repayment."

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

The following is a list of some data types available in Postgres. Refer to [official psql documentation](https://www.postgresql.org/docs/9.5/datatype.html) for a full list and their details:

| <div style="width:100px;">Data Type</div>   | Notes                                                                                                                          |
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

### Tables

<!-- Instructor note: This builds off on the "Data in Tables" topic, so going into depth about how to read a table, and how columns represent attributes and rows represent instances isn't necessary -->

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


<!-- prettier-ignore-start -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: checkbox
* id: 0da73b13-bf8e-42d1-a29f-bb44794e2272
* title: Primary Keys and Data types
* points: 1
* topics: sql

##### !question

Given the table: 

| `id` (`int`, `PRIMARY KEY`) | `full_name` (`varchar`) | `address` (`varchar`)                          |
| --------------------------- | ----------------------- | ---------------------------------------------- |
| `97`                        | `Sabrina C. Hunter`     | `4654 Leisure Lane, San Luis Obispo, CA 93401` |
| `98`                        | `Sabrina C. Hunter`     | `615 Radio Park Drive, Augusta, GA 30901`      |

Which values could be inserted into a row without an error?

##### !end-question

##### !options

* id: "99", full_name: "Ray Rosa", address: "123 Elm St, Seattle, WA 98121"
* id: 1, full_name: "Ray Rosa", address: "123 Elm St, Seattle, WA 98121"
* id: 99, full_name: "Ray Rosa", address: "123 Elm St, Seattle, WA 98121"
* id: 99, full_name: 123, address: "123 Elm St, Seattle, WA 98121"

##### !end-options

##### !answer

* id: 1, full_name: "Ray Rosa", address: "123 Elm St, Seattle, WA 98121"
* id: 99, full_name: "Ray Rosa", address: "123 Elm St, Seattle, WA 98121"

##### !end-answer

<!-- other optional sections -->
<!-- !hint - !end-hint (markdown, hidden, students click to view) -->
<!-- !rubric - !end-rubric (markdown, instructors can see while scoring a checkpoint) -->
<!-- !explanation - !end-explanation (markdown, students can see after answering correctly) -->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->
<!-- prettier-ignore-end -->

<!-- prettier-ignore-start -->
<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: short-answer
* id: df6e79cc-78ca-4d8d-b711-c08f3d4b8415
* title: Schema 
* points: 1
* topics: sql

##### !question

In your own words explain what a schema is.

##### !end-question

##### !placeholder

What is a schema?

##### !end-placeholder

##### !answer

/.+/

##### !end-answer

<!-- other optional sections -->
<!-- !hint - !end-hint (markdown, hidden, students click to view) -->
<!-- !rubric - !end-rubric (markdown, instructors can see while scoring a checkpoint) -->
##### !explanation

The database's *schema* provides **structure** for the database, establishing which tables exist, their attributes, the data type of each attribute and any constraints on them.  The schema does **not** include the data within each table.

You can think of a schema as like a bunch of classes.  They determine the structure of the data, without having values of specific instances of it.  A class determines what methods and attributes instances get, but isn't a specific instance of that type.

##### !end-explanation

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->
<!-- prettier-ignore-end -->

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
