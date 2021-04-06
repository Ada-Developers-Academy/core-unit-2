# Modifying Tables in SQL

## Goals

- Practice modifying table columns
- Practice modifying table names

## Introduction

Sometimes we need to modify the tables in our databases.

This could happen as we continue to work on a project and the requirements change. Maybe we decide that we need to add data to our `books` table to track how many weeks each book was on the New York Times best seller list.

This could happen from understanding our data model better and wanting to restructure things to reflect this. Maybe when we originally created our `books` table, we stored the published date as `TEXT`, but now we'd really like to store it as `DATE`.

This could even happen when we notice a mistake in our table. Maybe when we created the `books` table, we mistyped the `title` field as `titel`.

Any of these situations and more could cause us to need to modify our existing tables. Let's look at how we can do this.

## Sometimes it's Easier to Start Over

Before getting into how to modify our tables, it's worth remembering that sometimes it's easier to start over. If there isn't a lot of data in our table, we can always decide that it's easier to `DROP` the existing table and `CREATE` it again.

Even if there _is_ some data in the table, it's sometimes easier to re-insert the rows than fight with complicated data incompatibilities!

## Adding a New Column

We can add a new column to a table using the `ALTER TABLE` command.

```sql
ALTER TABLE table_name
ADD COLUMN column_name data_type constraint_name;
```

| <div style="width:200px;">Piece of Code</div> | Notes                                                                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `ALTER TABLE`                                | SQL command to modify an existing table                                                                                                       |
| `table_name`                          | **Replace this** with the name of the table to modify                                                                                    |
| `ADD COLUMN`                                    | SQL keywords indicating how we would like to modify the table. In this case, we want to add a column.                                |
| `column_name`                                 | **Replace this** with the name of a new column                                                                                      |
| `data_type`                                   | **Replace this** with the data type of the new column                                                                               |
| `constraint_name`                             | **Replace this** with any constraints                                                                                               |
| `;`                                           | End the command with a `;` |

Adding a column affects every row in the table. By default, the value for the new column in each record will be `NULL`. The optional `DEFAULT` constraint can be used to modify this behavior, as shown later in this lesson.

### Examples on Adding Columns

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. What column is being added and what is the data type of the column?
1. What constraints are set on the column?
1. Which pieces of syntax are unfamiliar?

```sql
ALTER TABLE users
ADD COLUMN github_uid VARCHAR(64);
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `users`
1. We are adding the column `github_uid` which will have data type `VARCHAR(64)`
1. There are no additional constraints.

The `github_uid` column will be added to the `users` table, and each existing record will have a value of `NULL` in that column.

</details>

```sql
ALTER TABLE books
ADD COLUMN nyt_weeks INT NOT NULL DEFAULT 0;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `books`
1. We are adding the column `nyt_weeks` which will have data type `INT`
1. We require that the column be `NOT NULL` and it will `DEFAULT` to a value of 0.

We have seen the `DEFAULT` keyword used when inserting rows with an auto-generated key. Here it's doing something a little different.

`DEFAULT` is acting as a constraint that says what value the column should have when added to each record. We needed to provide it here, since we also used the `NOT NULL` constraint. Recall that Postgres will use `NULL` as the new column value for each existing record by default. This would violate the `NOT NULL` constraint, so we provide a `DEFAULT` value to use instead.

The `DEFAULT` constraint will also affect future `INSERT` commands. If we insert a new record without providing `nyt_weeks`, Postgres will use the `DEFAULT` value that we set in the constraint: 0.

</details>
