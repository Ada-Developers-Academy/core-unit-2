# Aggregate Functions

## Goals

- Explain how `SELECT` statements can be used with `max`, `min`, `sum` and `avg` to perform calculations on a resultset
- Write `SELECT` Statements with aggregate functions to perform calculations on a resultset.

## Introduction

When working with data, often we will ask questions of our data in aggregate. This means we want to combine data into a whole. For example we might want to know how many books were written by a specific author, or the average price of a book. Most relational databases provides a number of aggregate functions we can use in querying our data.

## MAX and MIN

The `MAX` and `MIN` functions calculate and return the largest and smallest value from a given query.

For example given the following data

| title                         | price |
| ----------------------------- | ----- |
| The Heirs of the Plant People | 20.00 |
| Clue of the Burt Cottage      | 16.60 |
| The Mannequin in the Fog      | 16.25 |
| Imagine Us in Heaven          | 14.99 |

_Fig. books table_

This query:

```sql
SELECT MAX(price)
FROM books;
```

Will return:

| max   |
| ----- |
| 20.00 |

_Fig. Max Result_

The `MAX` function takes the entire group of data selected and reduces it to a single value.

We can also use the `MIN` function to find the minimum value. We could find the first title (alphabetically) with the following query.

```sql
SELECT MIN(title)
FROM books;
```

| min                      |
| ------------------------ |
| Clue of the Burt Cottage |

_Fig. Min Result_

### Subqueries

We can combine aggregate functions with our `WHERE` clause to select records with the minimum and maximum values. To do so we use a subquery.

```sql
SELECT title
FROM books
WHERE price = (
  SELECT MAX(price)
  FROM books
);
```

Because the `MAX` function returns a single value, in this case the most expensive price, the `WHERE price = ` clause can use the `SELECT MAX (price) FROM books` query to find the book with the most expensive price.

Given the data above, this query would return:

| title                         |
| ----------------------------- |
| The Heirs of the Plant People |

_Fig. Title with the max price_

## SUM, COUNT and AVG

`MAX` and `MIN` find the largest and smallest value in a resultset, but we can also calculate sum, average of numeric columns and count the number of rows returned by a specific query.

### SUM

The `SUM` function allows us to query the database for the total of all values in a specific query.

```sql
SELECT SUM(price)
FROM books;
```

The above query would return the total price for all books in the table. If we wanted to total the price for all books by a specific author we could add a `WHERE` clause.

```sql
SELECT SUM(price)
FROM books
WHERE author_id = 3;
```

### Count

We could also count the number of matching rows to a specific query with the `COUNT` function.

```
SELECT COUNT(*)
FROM books
WHERE price > 15;
```

| count |
| ----- |
| 3     |

_Fig. Number of books with price > 15_

The result to the above query would tell us that there are 3 books in the table with prices greater than 15.

### AVG

We can also use the AVG function to calculate the average or mean of a column in a `SELECT` query.

```sql
SELECT AVG(price)
FROM books;
```

We could combine this to find books with above-average prices using a subquery.

```sql
SELECT title
FROM books
WHERE price > (
  SELECT AVG(price)
  FROM books
);
```

This query retrieves the title field from the books table and only returns rows where the price field is greater than the average price for all rows in the books table.

## Check for Understanding

<!-- Question on how many rows SELECT statements with aggregate queries return  -->
