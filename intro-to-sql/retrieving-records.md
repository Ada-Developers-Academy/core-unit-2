## Retrieving Records With `SELECT`

We can retrieve records from a database using `SELECT`.

When we use `SELECT`, we get back a _result set_. Most importantly, we get back a table of the data, printed in our terminal.

How do we use this result set? Future technologies will help us use the result set in Python code. For now, we should look forward to seeing printed tables.

When we retrieve data from a table, we should first determine:

- which tables we are looking within
- which columns of data we're interested in

To retrieve the values of specific columns from **all** records within a specific table, we use the following SQL syntax:

```sql
SELECT column1, column2, column3, ... FROM table_name;
```

| Piece of Code                    | Notes                                                                                                                                                   |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SELECT`                         | A SQL keyword to indicate retrieving records                                                                                                            |
| `column1, column2, column3, ...` | **Replace this** with a comma-separated list of columns to retrieve, or another expression (such as `*` described below)                                |
| `FROM`                           | A SQL keyword to indicate that these records are from some set of tables                                                                                |
| `table_name;`                    | **Replace this** with the name of the table being searched. This could be a comma-separated list of multiple tables. Don't forget the ending semicolon. |

### `*`

The `*` character means all columns. We can use `*` instead of listing all columns. This means we can use the following syntax to **get all columns and all records from one table**.

```sql
SELECT * FROM table_name;
```

### Examples

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. Which columns are we selecting?
1. Which pieces of syntax are unfamiliar?

```sql
SELECT author_name FROM authors;
```

```sql
SELECT * FROM drivers;
```

```sql
SELECT id, category, title FROM media;
```

```sql
SELECT * FROM media;
```

## Combining `SELECT` with `WHERE`

Kenan is building a webapp that organizes his media library. However, he wants to build search and filter features for his media library. How can Kenan get the records that have the category "book," or records that are missing a description?

SQL has a lot of ways we can make a `SELECT` statement more specific. Combining `WHERE` with a `SELECT` statement is a great method.

`WHERE` allows us to add _conditions that must be true_ for a record to be returned.

`WHERE` must be placed _after_ `SELECT` and `FROM`.

```sql
SELECT column1, column2 FROM table_name WHERE expression;
```

### Using `WHERE` with `=`, `>=`, `<=`, `>`, `<` operator

We can use `=`, `>=`, `<=`, `>`, and `<` to compare the value of a column to another value.

Consider the following examples.

1. Retrieve all records where `author_name` is equal to `'Octavia E. Butler'`
   ```sql
   SELECT * FROM authors WHERE author_name = 'Octavia E. Butler';
   ```
1. Retrieve all records where `is_available` is `true`
   ```sql
   SELECT * FROM drivers WHERE is_available = true;
   ```
1. Retrieve all records where `publication_year` is less than `'1990'`
   ```sql
   SELECT * FROM media WHERE publication_year < '1990';
   ```
1. Retrieve all records where the length of `description_text` is greater than or equal to `10`
   ```sql
   SELECT * FROM media WHERE length(description_text) >= 10;
   ```

### !callout-info

## Comparing Strings

SQL can compare strings. Follow your curiosity and look up SQL's rules for comparing strings.

### !end-callout

### !callout-info

## `length`

SQL has a built-in function `length(string)`, which returns the length of the given string. There are plenty of other functions similar to this; follow your curiosity!

### !end-callout

### Using `WHERE` with `IS NOT NULL` and `IS NULL`

We can use `IS NOT NULL` as a condition to only retrieve records with a non-null value for a certain column.

Consider the following examples:

1. Retrieve all records where `vin` is not null, and has a value
   ```sql
   SELECT * FROM drivers WHERE vin IS NOT NULL;
   ```
1. Retrieve all records where `description_text` is not null, and has a value
   ```sql
   SELECT * FROM media WHERE description_text IS NOT NULL;
   ```

The inverse of this concept also works. We can use `IS NULL` to only retrieve records with a null value for a certain column.

1. Retrieve all records where `description_text` is null, and has no value
   ```sql
   SELECT * FROM media WHERE description_text IS NULL;
   ```
