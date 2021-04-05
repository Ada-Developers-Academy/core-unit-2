# Compound Conditions

## Goals

- Explain how `WHERE` clauses can contain multiple conditions
- Write `SELECT` statements using compound `WHERE` conditions

## Introduction

We have already seen how to restrict our `SELECT` results to a subset of records by providing a `WHERE` clause. The condition supplied to the `WHERE` clause must be true for a row to be included in the results. Like many other languages, SQL provides logical operators that can be used to combine the results of individual comparisons into a single compound condition that can be used to have greater control over our query results.

## Vocabulary and Synonyms

| Vocab              | Definition                                                                                                                 | How to Use in a Sentence                                                                                                                                                                                                                             |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Compound Condition | A condition formed from multiple simple comparisons combined with one of the SQL logical operators: `AND`, `OR`, or `NOT`. | "I can use a _compound condition_ to restrict my query results to students who are sophomores and taking World History." "Let's expand our query result to students who are either sophomores or juniors by using a different _compound condition_." |

## Logical Operators

SQL supports the following logical operators:

- `AND`
- `OR`
- `NOT`

### Compound Conditions With `AND`

Consider the following table.

| id  | title                    | <div style="min-width:150px;">author</div> | <div style="min-width:150px;">genre</div> |
| --- | ------------------------ | ------------------------------------------ | ----------------------------------------- |
| 1   | An Instant In The Wind   | Madie McClure                              | Nonfiction                                |
| 2   | Absalom, Absalom!        | Bret Bergstrom                             | Intrigue                                  |
| 3   | Recalled to Life         | Bret Bergstrom                             | Science Fiction                           |
| 4   | Cabbages and Kings       | Tim McDermott                              | Intrigue                                  |
| 5   | The Painted Veil         | Bret Bergstrom                             | Intrigue                                  |
| 6   | Time of our Darkness     | Madie McClure                              | Intrigue                                  |
| 7   | Jacob Have I Loved       | Bret Bergstrom                             | Nonfiction                                |
| 8   | By Grand Central Station | Madie McClure                              | Nonfiction                                |
| 9   | Terrible Swift Sword     | Bret Bergstrom                             | Science Fiction                           |
| 10  | The Last Enemy           | Bret Bergstrom                             | Intrigue                                  |

_Fig. A `books` table_

We can retrieve all of the books by Madie McClure with a query such as:

```sql
SELECT * from books
WHERE author = 'Madie McClure';
```

This would return the following result.

```
 id | title                    | author        | genre
----+--------------------------+---------------+------------
  1 | An Instant In The Wind   | Madie McClure | Nonfiction
  6 | Time of our Darkness     | Madie McClure | Intrigue
  8 | By Grand Central Station | Madie McClure | Nonfiction
(3 rows)
```

But what if we want to retrieve only her Nonfiction books?

We can use the `AND` logical operator to restrict our results to a smaller set.

```sql
SELECT * from books
WHERE author = 'Madie McClure'
AND genre = 'Nonfiction';
```

This query gives us the following result.

```
 id | title                    | author        | genre
----+--------------------------+---------------+------------
  1 | An Instant In The Wind   | Madie McClure | Nonfiction
  8 | By Grand Central Station | Madie McClure | Nonfiction
(2 rows)
```

We can add additional conditions as necessary to really narrow in our desired result set.

### Compound Conditions With `OR`

Let's continue to use the `books` table as shown above.

As before, we know how to get the books by Madie McClure. We also know how to get the books by Tim McDermott. The following query will do that nicely!

```sql
SELECT * from books
WHERE author = 'Tim McDermott';
```

This query returns:

```
 id | title                    | author        | genre
----+--------------------------+---------------+------------
  4 | Cabbages and Kings       | Tim McDermott | Intrigue
(1 row)
```

Now how would get the books written either by Madie McClure or by Tim McDermott?

We can use the `OR` logical operator to include additional results in a single result set.

```sql
SELECT * from books
WHERE author = 'Madie McClure'
OR author = 'Tim McDermott';
```

This query gives us the following result.

```
 id | title                    | author        | genre
----+--------------------------+---------------+------------
  1 | An Instant In The Wind   | Madie McClure | Nonfiction
  4 | Cabbages and Kings       | Tim McDermott | Intrigue
  6 | Time of our Darkness     | Madie McClure | Intrigue
  8 | By Grand Central Station | Madie McClure | Nonfiction
(4 rows)
```

As with `AND`, we can add additional `OR` conditions to expand what rows will be part of our result.

### Compound Conditions With `NOT`

We just wrote a query that gave us the books by Madie McClure and Tim McDermott. But there's another way we could have approached the same problem.

From the data, we know that there are three authors, and so if we want the books by two of them, that's the same as looking for the books _not_ by the third author.

Using the `NOT` logical operator, we can invert to which records our conditions apply.

```sql
SELECT * from books
WHERE NOT author = 'Bret Bergstrom';
```

This query gives the same result as before.

```
 id | title                    | author        | genre
----+--------------------------+---------------+------------
  1 | An Instant In The Wind   | Madie McClure | Nonfiction
  4 | Cabbages and Kings       | Tim McDermott | Intrigue
  6 | Time of our Darkness     | Madie McClure | Intrigue
  8 | By Grand Central Station | Madie McClure | Nonfiction
(4 rows)
```

In general, we can use `NOT` to reverse the meaning of any condition that we use in a `WHERE` clause.

### Combining Logical Operators

We can make arbitrarily complex conditions by using more than one logical operation.

Like in other languages, these three operators have an order of precedence. For Postgres, this is:

- `NOT`
- `AND`
- `OR`

Rather than relying on the precedence ordering, we can also be explicit about how we want our condition to be evaluated by using parentheses.

Let's try getting all the Intrigue genre books by either Madie McClure or Tim McDermott. We can start with either of our previous queries which returned the books by Madie McClure or Tim McDermott, and make a small modification to add the extra genre restriction.

```sql
SELECT * from books
WHERE author = 'Madie McClure'
OR author = 'Tim McDermott'
AND genre = 'Intrigue';
```

Giving the following result.

```
 id | title                    | author        | genre
----+--------------------------+---------------+------------
  1 | An Instant In The Wind   | Madie McClure | Nonfiction
  4 | Cabbages and Kings       | Tim McDermott | Intrigue
  6 | Time of our Darkness     | Madie McClure | Intrigue
  8 | By Grand Central Station | Madie McClure | Nonfiction
(4 rows)
```

Uh oh! Something went wrong! We still got Nonfiction results for Madie McClure!

This problem is due to the precedence of `AND` and `OR`. Since `AND` has higher precedence, the query restricted the results for Tim McDermott to be Intrigue books, but still selected all of the books by Madie McClure. We can fix this by using parentheses as follows:

```sql
SELECT * from books
WHERE (author = 'Madie McClure' OR author = 'Tim McDermott')
AND genre = 'Intrigue';
```

This query returns:

```
 id | title                    | author        | genre
----+--------------------------+---------------+------------
  4 | Cabbages and Kings       | Tim McDermott | Intrigue
  6 | Time of our Darkness     | Madie McClure | Intrigue
(2 rows)
```

We got back just the two rows we wanted!

As we just saw, the precedence of logical operators can have unexpected results if we're not careful!

Using parentheses when making queries with compound conditions can be very important!

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 9a90a6f7
* title: Compound Conditions
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
