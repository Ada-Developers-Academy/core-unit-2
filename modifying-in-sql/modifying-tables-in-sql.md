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

### Examples of Adding Columns

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

## Removing a Column

The `ALTER TABLE` command also provides a way to remove an existing column.

```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

| <div style="width:200px;">Piece of Code</div> | Notes                                                                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `ALTER TABLE`                                | SQL command to modify an existing table                                                                                                       |
| `table_name`                          | **Replace this** with the name of the table to modify                                                                                    |
| `DROP COLUMN`                                    | SQL keywords indicating how we would like to modify the table. In this case, we want to remove a column.                                |
| `column_name`                                 | **Replace this** with the name of the column to remove                                                                                     |
| `;`                                           | End the command with a `;` |

### Examples of Removing Columns

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. What column is being removed?
1. Which pieces of syntax are unfamiliar?

```sql
ALTER TABLE users
DROP COLUMN geocities_homepage;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `users`
1. We are removing the column `geocities_homepage`

The `geocities_homepage` column will be removed from the `users` table.

</details>

```sql
ALTER TABLE books
DROP COLUMN author_name;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `books`
1. We are removing the column `author_name`

The `author_name` column will be removed from the `books` table. We might do this after restructuring our data so that the author information is stored elsewhere. This will be discussed further in the upcoming lesson on Database Relationships.

</details>

## Modifying the Data Type of a Column

Using `ALTER TABLE`, we can modify the data type of a column.

```sql
ALTER TABLE table_name
ALTER COLUMN column_name
TYPE new_data_type
USING conversion_expr;
```

| <div style="width:200px;">Piece of Code</div> | Notes                                                                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `ALTER TABLE`                                | SQL command to modify an existing table                                                                                                       |
| `table_name`                          | **Replace this** with the name of the table to modify                                                                                    |
| `ALTER COLUMN`                                    | SQL keywords indicating how we would like to modify the table. In this case, we want to modify a column.                                |
| `column_name`                                 | **Replace this** with the name of the column to modify                                                                                     |
| `TYPE`                                    | SQL keyword indicating we are changing the column type                                |
| `new_data_type`                                 | **Replace this** with the new data type for the column                                                                                     |
| `USING`                                    | SQL keyword indicating the start of an **optional** clause with information about how to convert existing data to the new data type                                |
| `conversion_expr`                                 | **Replace this** with information that Postgres can use to more accurately convert existing data to the new data type                                                                                     |
| `;`                                           | End the command with a `;` |

Modifying the data types of columns is not always easy. It's not unusual for Postgres to return an error on our first attempt, sometimes with a possible fix. This will usually take the form of a `USING` clause.

Further discussion of the `USING` clause is beyond the scope of this lesson. We should understand that it may be necessary, and that Postgres will usually recommend the correct `USING` clause to supply when needed.

If Postgres is unable to change the column even after following the suggested command, then we may need to do additional research, or consider recreating the table from scratch.

### Examples of Modifying Columns

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. What column is being changed and to what data type?
1. What conversion expressions are provided, if any?
1. Which pieces of syntax are unfamiliar?

```sql
ALTER TABLE books
ALTER COLUMN nyt_weeks
TYPE BOOLEAN
USING nyt_weeks::boolean;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `books`
1. We are changing the `nyt_weeks` column to data type `BOOLEAN`
1. We provided the `boolean` conversion expression as `nyt_weeks::boolean`

Depending on the data that was already in the `nyt_weeks` column, Postgres may or may not be able to covert the column type automatically.

In our case, we tried to run the modification without the `USING` clause, and Postgres failed. It recommended running the command again with the `nyt_weeks::boolean` conversion expression.

</details>

```sql
ALTER TABLE users
ALTER COLUMN github_uid
TYPE TEXT;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `users`
1. We are changing the `github_uid` column to data type `TEXT`
1. No conversion expressions were supplied.

This modification relaxes the length limit the column had in the previous example where it was defined as a `VARCHAR(64)`. The change succeeded without issue.

</details>

### !callout-info

## Column Constraints Can Also Be Modified

Column constraints can also be modified with variants of the `ALTER TABLE ALTER COLUMN` command. We used the `TYPE` keyword to indicate that we wanted to change the column type, but additional keywords, including `SET`, `DROP`, and `ADD` with a wide variety of options also exist. We will not need to use them in this curriculum, but follow your curiosity!

### !end-callout

## Renaming a Column

The last column modification operation of `ALTER TABLE` that we will examine is renaming a column.

```sql
ALTER TABLE table_name
RENAME COLUMN column_name
TO new_column_name;
```

| <div style="width:200px;">Piece of Code</div> | Notes                                                                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `ALTER TABLE`                                | SQL command to modify an existing table                                                                                                       |
| `table_name`                          | **Replace this** with the name of the table to modify                                                                                    |
| `RENAME COLUMN`                                    | SQL keywords indicating how we would like to modify the table. In this case, we want to rename a column.                                |
| `column_name`                                 | **Replace this** with the name of the column to be renamed                                                                                     |
| `TO`                                    | SQL keyword preceding the new name of the column                                |
| `new_column_name`                                 | **Replace this** with the new name for the column                                                                                     |
| `;`                                           | End the command with a `;` |

### Examples of Renaming Columns

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. What column is being renamed and what is its new name?
1. Which pieces of syntax are unfamiliar?

```sql
ALTER TABLE users
RENAME COLUMN email
TO email_address;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `users`
1. We are renaming the column `email` to be called `email_address`

The `email` column in the `users` table will be renamed to `email_address`.

</details>

```sql
ALTER TABLE books
RENAME COLUMN intl_no
TO isbn;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `books`
1. We are renaming the column `intl_no` to be called `isbn`

The `intl_no` column in the `books` table will be renamed to `isbn`.

</details>
