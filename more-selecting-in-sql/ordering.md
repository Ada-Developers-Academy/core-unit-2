# Ordering

<!--

Note:  The beind the curtain is maybe something we don't keep, on the other hand having something in the lessons about the order Postgres evaluates SQL is maybe something that should be added.

-->

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=917e7bb8-f59f-4fba-b228-ad1000ea2a72&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goals

- Explain how `SELECT` statements can be used with `ORDER BY` to change the order of the result set
- Write `SELECT` statements with `ORDER BY` to change how a result set is sorted

## Introduction

In our prior queries, Postgres, our database, determined the order in which the result rows appeared. By default, the order depends on what data is currently in the database, and how it is stored on the disk. As a result, we must treat the order of results returned by Postgres as unspecified.

Sometimes we want to order our results by a specific field. One approach would be to retrieve the full result set in its default ordering, and then sort the records ourselves. But wouldn't it be nice if the database could sort the results itself while gathering the results? By using the `ORDER BY` clause, it can!

## ORDER BY Syntax

To sort the results of a query we can add an `ORDER BY` clause as follows.

```sql
SELECT
	columns_desired
FROM
	table_name
(additional optional clauses)
ORDER BY
	sort_expression1 sort_direction,
	sort_expression2 sort_direction,
	... ;
```

Before the `ORDER BY` keyword, we can use any of the `SELECT` knowledge we have built up so far. Let's examine the new syntax!

| <div style="min-width:200px;"> Piece of Code </div> | Notes                                                                                                                                                               |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ORDER BY`                                          | A SQL keyword to indicate the start of ordering directives                                                                                                          |
| `sort_expression_1, sort_expression_2, ...`         | **Replace this** with a comma-separated list of expressions to use for data ordering. The most common expressions to use are column names, but others are possible! |
| `sort_direction`                                    | **Replace this** with either `ASC` for an ascending sort, or `DESC` for a descending sort. If omitted, the default is ascending.                                    |

For example if we wanted to retrieve a list of book titles ordered by the titles themselves, we could write the following query.

```sql
SELECT title
FROM books
ORDER BY title
```

This will sort the results by comparing the title of each record. By default, it uses a comparison strategy which is essentially the same as we see in Python string comparisons.

### !callout-info

## Databases Can Order Complex Text

Text is complicated. Different languages have different rules for how to order their own text. For instance, in English we might say that capitalization doesn't matter, nor does the occasional accent character borrowed from another language. However, maybe in German, where nouns are always capitalized, maybe the capitalization should affect sort order. In French, where there is a variety of accent marks, maybe native speakers expect certain accents to sort before others. Chinese characters might be ordered by a locale-specific reading, by stroke count, or by which common sub-parts they contain.

<br />

Databases address this issue with a concept called _collation_. It's a very large subject that we will not need for this curriculum, but follow your curiosity.

### !end-callout

If our table held a numeric field, `price`, we could sort the results numerically with:

```sql
SELECT title, price
FROM books
ORDER BY price;
```

This will sort the results by comparing the price of each record.

The results could look like the following.

```
 title                         | price
-------------------------------+-------
 Imagine Us in Heaven          | 14.99
 The Mannequin in the Fog      | 16.25
 Clue of the Burt Cottage      | 16.60
 The Heirs of the Plant People | 20.00
(4 rows)
```

## ASC and DESC

By default, `ORDER BY` sorts in ascending order. This means that lower (or alphabetically earlier) values appear first and larger (or alphabetically later) values appear last. If we want to sort in descending order (largest first), we can add `DESC` to the end of our `ORDER BY` clause.

```sql
SELECT title, price
FROM books
ORDER BY price DESC;
```

Applying the query to the sample data above, the results could look like this.

```
 title                         | price
-------------------------------+-------
 The Heirs of the Plant People | 20.00
 Clue of the Burt Cottage      | 16.60
 The Mannequin in the Fog      | 16.25
 Imagine Us in Heaven          | 14.99
(4 rows)
```

The `ASC` keyword can be explicitly supplied to `ORDER BY` to sort data in ascending order. Since this is the default behavior, we generally omit `ASC` except in cases where explicitly including it might improve the clarity of a complex query.

```sql
SELECT title, price
FROM books
ORDER BY price ASC;
```

## ORDER BY and NULL

Sometimes we may have rows with a value of `NULL` for the column being sorted. How can we handle this?

We can specify how to treat `NULL` values in the sort results.

```sql
SELECT title, price
FROM books
ORDER BY price NULLS FIRST;
```

The above query will put any row with a price of `NULL` first in the results. This is the default behavior and so the use of `NULLS FIRST` is optional.

We can also put rows with `NULL` last.

```sql
SELECT title, price
FROM books
ORDER BY price NULLS LAST;
```

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: QWYdjf
* title: Ordering
##### !question

Imagine building a feature where a user can view forum posts. They can order the forum posts by date, and would like to see the most recent posts first.

Arrange the following syntax into a valid statement.

##### !end-question
##### !answer

1. `SELECT * FROM forum_posts`
1. `ORDER BY`
1. `post_date`
1. `DESC`
1. `;`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- ORDERING Question with ORDER BY -->

<!-- SQL question using order by and limit -->

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 4813cbd1
* title: Sorting Results
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
