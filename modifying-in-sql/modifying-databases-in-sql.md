# Modifying Databases in SQL

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=43ca5e04-920e-4ce8-af92-ad08010bc207&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>
## Goals

- Practice modifying database names

## Introduction

Sometimes the name of our database just won't do! Maybe it has a typo. Maybe we just thought of a better name.

Regardless of the cause, the solution is the same. Let's rename our database!

## Renaming a Database

We use the `ALTER DATABASE` command to rename a database.


```sql
ALTER DATABASE database_name
RENAME TO new_database_name;
```

| <div style="width:200px;">Piece of Code</div> | Notes                                                                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `ALTER DATABASE`                                | SQL command to modify an existing database                                                                                                       |
| `database_name`                          | **Replace this** with the name of the database to modify                                                                                    |
| `RENAME TO`                                    | SQL keywords indicating how we would like to modify the database. In this case, we want to rename the database.                                |
| `new_database_name`                                 | **Replace this** with the new name for the database                                                                                     |
| `;`                                           | End the command with a `;` |

Note that we cannot rename a database to which we are currently connected. Attempting to do so will result in an error. We can try connecting to the `postgres` database by running `\c postgres` within the `psql` CLI. From there we should be able to rename any other database.

### Example of Renaming a Database

For the following SQL statement, read the code and answer:

1. What is the name of the database and what is its new name?
2. Which pieces of syntax are unfamiliar?

```sql
ALTER DATABASE boring_name
RENAME TO better_name;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the database is `boring_name` and we are renaming it to be called `better_name`

The `boring_name` database will be renamed to `better_name`.

Again, we must take care that we are not connected to the `boring_name` database when we try to modify its name. Instead, we should should connect to another database, such as `postgres` before trying to run the `ALTER DATABASE` command.

</details>

### !callout-info

## We Can Modify Many Database Attributes

The `ALTER DATABASE` command can be used to modify a variety of database attributes. We will not need them in this curriculum, but follow your curiosity.

### !end-callout

## Summary

We can rename our databases as needed using the `ALTER DATABASE` command, so long as we are not connected to the database we wish to modify.

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 99510aef
* title: Modifying Databases in SQL
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
