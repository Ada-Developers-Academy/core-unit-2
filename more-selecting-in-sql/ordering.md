# Sorting Results

<!-- 

Note:  The beind the curtain is maybe something we don't keep, on the other hand having something in the lessons about the order Postgres evaluates SQL is maybe something that should be added.

-->

## Goals

- Explain how `SELECT` statements can be used with `ORDER BY` to change the order of the resultset
- Write `SELECT` Statements with `ORDER BY` to change how a resultset is sorted

## Introduction

In our prior queries, Postgres, our database, determined the order in which rows appeared.  This came from the current state of the database and how the data is stored on the disk.  By default, Postgres returns results in an unspecified order.

Often however we want to order our results by a specific field.  To put results from a `SELECT` query in a specific order we can use the `ORDER BY` clause.


## Order By Syntax

To sort the results of a query we can add an `ORDER BY` clause as follows.

```sql
SELECT
	columns_desired
FROM
	table_name
[Optional Clauses]
ORDER BY
	sort_expression1 [ASC | DESC],
	sort_expression2 [ASC | DESC];
  ...
```

For example if we wanted to retrieve a list of book titles, ordered by the title we could write the following query.

```sql
SELECT title
FROM books
ORDER BY title
```

This will sort the results by:

* Comparing the letters alphabetically ignoring spaces and punctuation
  * Letters are sorted in a case-insensitive manner
* Then spaces and punctuation are compared to break ties

If our table held a numeric field, `price` we could sort the results numerically with:

```sql
SELECT title, price
FROM books
ORDER BY price;
```

The following could look like the following.

| title | price |
|--- |--- |
| Imagine Us in Heaven | 14.99 |
| The Mannequin in the Fog | 16.25 |
| Clue of the Burt Cottage | 16.60 |
| The Heirs of the Plant People | 20.00 |

## ASC and DESC

By default `ORDER BY` sorts in ascending order.  This means that lower values (or alphabetically earlier) values appear first and the largest (or last alphabetically) values appear last.  If we want to sort in descending order (largest first), we can add `DESC` to the end of our `ORDER BY` clause.

```sql
SELECT title, price
FROM books
ORDER BY price DESC;
```

Applying the query to the sample data above, the resultset could look like this.

| title | price |
|--- |--- |
| The Heirs of the Plant People | 20.00 |
| Clue of the Burt Cottage | 16.60 |
| The Mannequin in the Fog | 16.25 |
| Imagine Us in Heaven | 14.99 |


We can also use ASC to explicitly sort data in ascending order (the opposite of descending).  This is the default behavior and so `ASC` is not needed.

```sql
SELECT title, price
FROM books
ORDER BY price ASC;
```

## ORDER BY and NULL

Sometimes we may have rows with a value of `NULL` for the column being sorted.  How can we handle this?  We can specify how to treat null values in the sort results.

```sql
SELECT title, price
FROM books
ORDER BY price NULLS FIRST;
```

The above query will put any row with a price of `NULL` first in the resultset.  This is the default behavior and so is optional.

We can also put rows with `NULL` last.

```sql
SELECT title, price
FROM books
ORDER BY price NULLS LAST;
```


## A Peek Behind the Curtain

When Postgres retrieves records in a query it first.

1.  Retrieves the table(s) specified in the `FROM` clause.
1.  Performs the `SELECT` on the data retrieved in step 1 including the `WHERE` clause.
1.  Sorts the selected rows as specified in the `ORDER BY` clause

This is because `ORDER BY` is **expensive** relative to retrieving records and filtering values with the `WHERE` clause.  By filtering out all records that do not match the `SELECT` the sort only needs to put a minimum number of rows in order.

## Combining ORDER BY and LIMIT

We can combine `ORDER BY` and `LIMIT` sort our records and then retrieve a subset of the records.

For example:

```sql
SELECT title, price
FROM books
ORDER BY price DESC
LIMIT 5;
```

The above query will retrieve the 5 **most** expensive books.

Similarly we could find the first 10 book titles alphabetically.

```sql
SELECT title
FROM books
ORDER BY title
LIMIT 10;
```

## Check for Understanding


<!-- ORDERING Question with ORDER BY -->

<!-- SQL question using order by and limit -->