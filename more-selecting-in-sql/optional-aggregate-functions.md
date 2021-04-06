# Optional: Aggregate Functions

## Goals

- Explain how `SELECT` statements can be used with `max`, `min`, `sum` and `avg` to perform calculations on a query result
- Write `SELECT` statements with aggregate functions to perform calculations on a query result.

## Introduction

Aggregating data involves gathering or collecting individual data points into a whole group. There are certain kinds of questions that make more sense to ask about groups of records than individual records. For instance, it's not very interesting to ask for the average of a single value, or the minimum or maximum either! These concepts are more useful when asked about a group of records.

When we perform a `SELECT` query, we are gathering a group of records. Maybe we'd like to get all the books by a particular author and find out how many there are. Maybe we'd like to get a list of books in a certain genre, and then the average price of that list.

Most relational databases provide a number of aggregate functions that we can apply to situations like these.

## MAX and MIN

The `MAX` function calculates and returns the largest value from a given query.

For example given the following data:

| title                         | price |
| ----------------------------- | ----- |
| The Heirs of the Plant People | 20.00 |
| Clue of the Burt Cottage      | 16.60 |
| The Mannequin in the Fog      | 16.25 |
| Imagine Us in Heaven          | 14.99 |

_Fig. A small `books` table_

This query:

```sql
SELECT MAX(price)
FROM books;
```

Will return:

```
 max
-------
 20.00
(1 row)
```

The `MAX` function takes the entire group of data selected and reduces it to a single value.

The `MIN` function lets us find the minimum value in a given query. We could find the first title (alphabetically) with the following query.

```sql
SELECT MIN(title)
FROM books;
```

```
 min
--------------------------
 Clue of the Burt Cottage
(1 row)
```

### Subqueries

In both these examples, using `MAX` and `MIN` resulted in reducing the entire query result down to a single value.

It can be useful to use this single value as part of a `WHERE` condition. This would allow us to retrieve all the records that share that maximum or minimum value.

We can do this by nesting our aggregate query within a condition of the `WHERE` clause as shown below.

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

```
 title
-------------------------------
 The Heirs of the Plant People
(1 row)
```

## SUM, COUNT and AVG

SQL also provides functions to calculate the sum and average of numeric columns, and to count the number of rows returned by a specific query.

### SUM

The `SUM` function allows us to ask the database for the total of all values in a specific column of a query.

```sql
SELECT SUM(price)
FROM books;
```

This query would return the total price for all books in the table.

```
 sum
-------
 67.84
(1 row)
```

If we wanted to total the price for all books by a specific author we could add a `WHERE` clause.

```sql
SELECT SUM(price)
FROM books
WHERE author_id = 3;
```

### COUNT

We can use the `COUNT` function to retrieve the number of rows matching a specific query.

```
SELECT COUNT(*)
FROM books
WHERE price > 15;
```

This will return the count of records with a price greater than 15.

```
 count
-------
     3
(1 row)
```

This tells us that there are three books in the table with prices greater than 15.

### AVG

The `AVG` function calculates the average, or arithmetic mean, of a column in a `SELECT` query.

```sql
SELECT AVG(price)
FROM books;
```

This query calculates the average price of the books in our table.

```
 avg
-------
 16.96
(1 row)
```

As we did in the earlier `MAX` example, we can use the aggregated result within a subquery.

```sql
SELECT title
FROM books
WHERE price > (
  SELECT AVG(price)
  FROM books
);
```

This query retrieves the `title` field from any row in the `books` table where its price is greater than the average price for all rows in the `books` table.

<!-- ## Check for Understanding -->

<!-- Question on how many rows SELECT statements with aggregate queries return  -->
