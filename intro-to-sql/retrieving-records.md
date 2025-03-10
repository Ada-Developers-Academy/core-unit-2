# Retrieving Records

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=50137d31-475b-4496-8ebc-ad05004c2ade&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Learning Goals

- Practice retrieving records from a table

## Introduction

Imagine that Kenan is working on a webapp that categorizes different pieces of media. His library contains hundreds of books, albums, and movies.

Now, he wants to build features to help users explore it. His features will show different categories and filters. With his data, he may ask:

- Which records are in the category "book"?
- Which records were published before 1990?
- Which records are missing a description?

## Vocabulary and Synonyms

| Vocab      | Definition                                                                                                                           | How to Use in a Sentence                                       |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------- |
| Result Set | A set of rows from a database, as well as metadata about the query such as the column names, and the types and sizes of each column. | My query returned a result set with 1000 rows.                 |
| Query      | A request to access data from a database                                                                                             | I wrote a query to find the most popular books in the library. |

## Retrieving Records With `SELECT`

We can retrieve records from a database using `SELECT`.

When we use `SELECT`, we get back a _result set_. From within `psql`, the result set is displayed as a table of data printed in our terminal.

What else can we do with this result set? Later topics will discuss how to use the result set in Python code. But for now, seeing the printed tables will be enough for our purposes.

When we retrieve data from a table, we should first determine:

- which tables we are looking within
- which columns of data we're interested in

To retrieve the values of specific columns from **all** records within a specific table, we use the following SQL syntax:

```sql
SELECT column1, column2, column3, ... FROM table_name;
```

| <div style="min-width:200px;"> Piece of Code </div> | Notes                                                                                                                    |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `SELECT`                                            | A SQL keyword to indicate retrieving records                                                                             |
| `column1, column2, column3, ...`                    | **Replace this** with a comma-separated list of columns to retrieve, or another expression (such as `*` described below) |
| `FROM`                                              | A SQL keyword to indicate that these records are from some set of tables                                                 |
| `table_name`                                       | **Replace this** with the name of the table being searched                           |
| `;`                              | Terminates the SQL query |

### The `*` Character

The `*` character means all columns. We can use `*` instead of listing each column. This means we can use the following syntax to **get all columns and all records from one table**.

```sql
SELECT * FROM table_name;
```

### Example and Output

Imagine the following table named `media` with these columns and four records.

<!--

Table in markdown for our convenience:

| `media_id` | `category` | `title`         | `creator`      | `publication_year` | `description_text`                    |
| ---------- | ---------- | --------------- | -------------- | ------------------ | ------------------------------------- |
| 1          | book       | Red Java        | Jewel Koss     | 1971               | Nisi ducimus reprehenderit molestiae. |
| 2          | book       | Postmodern Been | Glen Senger    | 1929               | Dolore repellendus doloribus maiores. |
| 3          | movie      | American Select | Xuan Pouros    | 1997               | Corporis id voluptatem fuga.          |
| 4          | movie      | Wake-up Utopia  | Buena Shanahan | 1930               | Fuga corrupti ducimus animi.          |
 -->

<table class="table table-bordered table-striped table-condensed table-hover" style="font-size:.7em;"><thead>
<tr>
<th><div style="min-width:70px"><code tabindex="0">media_id</code><div></div></div></th>
<th><div style="min-width:70px"><code tabindex="0">category</code><div></div></div></th>
<th><div style="min-width:70px"><code tabindex="0">title</code><div></div></div></th>
<th><div style="min-width:70px"><code tabindex="0">creator</code><div></div></div></th>
<th><div style="min-width:120px"><code tabindex="0">publication_year</code><div></div></div></th>
<th><div style="min-width:120px"><code tabindex="0">description_text</code><div></div></div></th>
</tr>
</thead><tbody>
<tr>
<td>1</td>
<td>book</td>
<td>Red Java</td>
<td>Jewel Koss</td>
<td>1971</td>
<td>Nisi ducimus reprehenderit molestiae.</td>
</tr>
<tr>
<td>2</td>
<td>book</td>
<td>Postmodern Been</td>
<td>Glen Senger</td>
<td>1929</td>
<td>Dolore repellendus doloribus maiores.</td>
</tr>
<tr>
<td>3</td>
<td>movie</td>
<td>American Select</td>
<td>Xuan Pouros</td>
<td>1997</td>
<td>Corporis id voluptatem fuga.</td>
</tr>
<tr>
<td>4</td>
<td>movie</td>
<td>Wake-up Utopia</td>
<td>Buena Shanahan</td>
<td>1930</td>
<td>Fuga corrupti ducimus animi.</td>
</tr>
</tbody></table>

#### Selecting One Column

This SQL statement

```sql
SELECT title FROM media;
```

produces this output:

```
        title
---------------------
 Red Java
 Postmodern Been
 American Select
 Wake-up Utopia
(4 rows)
```

#### Selecting Multiple Columns

This SQL statement

```sql
SELECT media_id, title FROM media;
```

produces this output:

```
 media_id |      title
----------+-----------------
        1 | Red Java
        2 | Postmodern Been
        3 | American Select
        4 | Wake-up Utopia
(4 rows)
```

#### Selecting All Columns

This SQL statement

```sql
SELECT * FROM media;
```

produces this output:

```
 media_id | category |      title      |    creator     | publication_year |           description_text
----------+----------+-----------------+----------------+------------------+---------------------------------------
        1 | book     | Red Java        | Jewel Koss     | 1971             | Nisi ducimus reprehenderit molestiae.
        2 | book     | Postmodern Been | Glen Senger    | 1929             | Dolore repellendus doloribus maiores.
        3 | movie    | American Select | Xuan Pouros    | 1997             | Corporis id voluptatem fuga.
        4 | movie    | Wake-up Utopia  | Buena Shanahan | 1930             | Fuga corrupti ducimus animi.
```

### Examples

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. Which columns are we selecting?
1. Which pieces of syntax are unfamiliar?

```sql
SELECT author_name FROM authors;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `authors`
1. The selected column is `author_name`

</details>

```sql
SELECT * FROM drivers;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `drivers`
1. All columns in the table are selected

</details>

```sql
SELECT id, category, title FROM media;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `media`
2. We select 3 columns: `id`, `category`, and `title`

</details>

```sql
SELECT * FROM media;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. The name of the table is `media`
2. All columns in the table are selected

</details>

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: 3cGYv7
* title: Retrieving Records
##### !question

What is the difference between these two SQL statements?

```sql
SELECT id, is_checked_in FROM hotel_guests;
```

```sql
SELECT * FROM hotel_guests;
```

##### !end-question
##### !options

* One statement selects all rows from `hotel_guests`, the other selects only two rows
* One statement selects all columns from all rows from `hotel_guests`, the other selects only two columns
* One statement selects the first valid `id` and `is_checked_in` values from `hotel_guests`, the other selects the first values, regardless of validity

##### !end-options
##### !answer

* One statement selects all columns from all rows from `hotel_guests`, the other selects only two columns

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: FBGIoJ
* title: Retrieving Records
##### !question

Arrange the following syntax into a valid statement.

##### !end-question
##### !answer

1. `SELECT`
1. `id`
1. `FROM`
1. `hotel_guests`
1. `;`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

## Combining `SELECT` with `WHERE`

Kenan is building a webapp that organizes his media library. However, he wants to build search and filter features for his media library. How can Kenan get the media records that have the category "book"? Or how could he find the records that are missing a description?

SQL has a lot of ways we can make a `SELECT` statement more specific. One of the most common is to add a `WHERE` clause to our `SELECT` statement.

```sql
SELECT column1, column2 FROM table_name WHERE condition;
```

### `WHERE` Clauses

`WHERE` clauses allow us to add _conditions that must be true_ for a record to be returned.

`WHERE` clauses must be placed _after_ `SELECT` and `FROM`.

### Using `WHERE` with `=`, `>=`, `<=`, `>`, `<` Operators

We can use `=`, `>=`, `<=`, `>`, and `<` to compare the value of a column to another value.

### !callout-info

## `WHERE` Also Supports Not Equal To

We can also check for not equal to in our where clauses. Postgres supports writing not equal to either as the familiar `!=` operator, or as the `<>` operator.

### !end-callout

### `WHERE` Example With Output

Imagine the following table named `media` and its columns and four records.

<!--

Table in markdown for our convenience:

| `media_id` | `category` | `title`         | `creator`      | `publication_year` | `description_text`                    |
| ---------- | ---------- | --------------- | -------------- | ------------------ | ------------------------------------- |
| 1          | book       | Red Java        | Jewel Koss     | 1971               | Nisi ducimus reprehenderit molestiae. |
| 2          | book       | Postmodern Been | Glen Senger    | 1929               | Dolore repellendus doloribus maiores. |
| 3          | movie      | American Select | Xuan Pouros    | 1997               | Corporis id voluptatem fuga.          |
| 4          | movie      | Wake-up Utopia  | Buena Shanahan | 1930               | Fuga corrupti ducimus animi.          |

-->

<table class="table table-bordered table-striped table-condensed table-hover" style="font-size:.7em;"><thead>
<tr>
<th><div style="min-width:70px"><code tabindex="0">media_id</code><div></div></div></th>
<th><div style="min-width:70px"><code tabindex="0">category</code><div></div></div></th>
<th><div style="min-width:70px"><code tabindex="0">title</code><div></div></div></th>
<th><div style="min-width:70px"><code tabindex="0">creator</code><div></div></div></th>
<th><div style="min-width:120px"><code tabindex="0">publication_year</code><div></div></div></th>
<th><div style="min-width:120px"><code tabindex="0">description_text</code><div></div></div></th>
</tr>
</thead><tbody>
<tr>
<td>1</td>
<td>book</td>
<td>Red Java</td>
<td>Jewel Koss</td>
<td>1971</td>
<td>Nisi ducimus reprehenderit molestiae.</td>
</tr>
<tr>
<td>2</td>
<td>book</td>
<td>Postmodern Been</td>
<td>Glen Senger</td>
<td>1929</td>
<td>Dolore repellendus doloribus maiores.</td>
</tr>
<tr>
<td>3</td>
<td>movie</td>
<td>American Select</td>
<td>Xuan Pouros</td>
<td>1997</td>
<td>Corporis id voluptatem fuga.</td>
</tr>
<tr>
<td>4</td>
<td>movie</td>
<td>Wake-up Utopia</td>
<td>Buena Shanahan</td>
<td>1930</td>
<td>Fuga corrupti ducimus animi.</td>
</tr>
</tbody></table>

This SQL statement

```sql
SELECT title FROM media WHERE media_id < 3;
```

produces this output:

```
      title
-----------------
 Red Java
 Postmodern Been
(2 rows)
```

This SQL statement

```sql
SELECT * FROM media WHERE category = 'movie';
```

produces this output:

```
 media_id | category |      title      |    creator     | publication_year |       description_text
----------+----------+-----------------+----------------+------------------+------------------------------
        3 | movie    | American Select | Xuan Pouros    | 1997             | Corporis id voluptatem fuga.
        4 | movie    | Wake-up Utopia  | Buena Shanahan | 1930             | Fuga corrupti ducimus animi.
(2 rows)
```

### More Examples

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

SQL can compare strings. Follow your curiosity and look up SQL's rules for string comparison.

### !end-callout

### !callout-info

## `length`

SQL has a built-in function `length(string)`, which returns the length of the given string. There are plenty of other functions similar to this; follow your curiosity!

### !end-callout

<!-- Question 3 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: TbbO7y
* title: Retrieving Records
##### !question

Imagine building a feature where a user can filter a list of guest records. The user wants to filter and see the names of all guests who are under the age of 18.

Arrange the following syntax into a valid statement.

##### !end-question
##### !answer

1. `SELECT`
1. `guest_name`
1. `FROM`
1. `hotel_guests`
1. `WHERE`
1. `age`
1. `<`
1. `18`
1. `;`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 4 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: XOKW5i
* title: Retrieving Records
##### !question

Imagine building a feature where a user can look at the profiles of each guest. The user wants to look at the profile of the guest with the ID of `872645`, and see all of their data.

Arrange the following syntax into a valid statement.

**Note:** For this question, if the order of something seems ambiguous, try **both** ways.

##### !end-question
##### !answer

1. `SELECT`
1. `*`
1. `FROM`
1. `hotel_guests`
1. `WHERE`
1. `id`
1. `=`
1. `872645`
1. `;`

##### !end-answer
##### !explanation

Either of these statements would work.

```sql
SELECT * FROM hotel_guests WHERE id = 872645;
```
```sql
SELECT * FROM hotel_guests WHERE 872645 = id;
```

But typically, we write comparisons in the order: `column operator value`. Here, that would be `id = 872645`.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

### Using `WHERE` with `IS NOT NULL` and `IS NULL`

We can use `IS NOT NULL` as a condition to only retrieve records with a non-null value for a certain column.

Consider the following examples:

1. Retrieve all records where `vin` is not null. That is, it has a value.

   ```sql
   SELECT * FROM drivers WHERE vin IS NOT NULL;
   ```

1. Retrieve all records where `description_text` is not null, meaning it has a value.

   ```sql
   SELECT * FROM media WHERE description_text IS NOT NULL;
   ```

The inverse of this concept also works. We can use `IS NULL` to only retrieve records with a null value for a certain column.

1. Retrieve all records where `description_text` is null. When it's null, it has no value.

   ```sql
   SELECT * FROM media WHERE description_text IS NULL;
   ```

### !callout-info

## We Must Use `IS NULL` and `IS NOT NULL`

When we want to compare with `NULL`, we must use either `IS` or `IS NOT`. Any other comparison with `NULL` will always evaluate to `false`.

### !end-callout

### !callout-success

## Foreshadowing: More Ways to Select

`SELECT` and `WHERE` seem pretty cool, but can we get even more specific? `SELECT` supports _countless_ ways to do so. Examples include defining multiple conditions in the `WHERE` clause, sorting the retrieved data, finding unique records, and finding records related to other records. A few of these concepts will be covered in future lessons. To expand your breadth, depth, and power in your `SELECT` skills, follow your curiosity!

### !end-callout

<!-- Question 5 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: ttG97B
* title: Retrieving Records
##### !question

Imagine building a feature where a user can manage a list of guests. The user wants to find all of the guest IDs who do **not** have an email address.

Arrange the following syntax into a valid statement.

##### !end-question
##### !answer

1. `SELECT`
1. `id`
1. `FROM`
1. `hotel_guests`
1. `WHERE`
1. `email_address`
1. `IS`
1. `NULL`
1. `;`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

## When `SELECT` "Fails"

A `SELECT` statement that has a syntax error will fail. For example, we may see error output like this:

```
SELECT * FROM media WHERE title NOT NULL;
ERROR:  syntax error at or near "NOT"
LINE 1: SELECT * FROM media WHERE title NOT NULL;
                                        ^
```

A `SELECT` statement without a syntax error, but which retrieves zero matching records, is still a successful `SELECT` statement! Sometimes life just comes back with nothing, and that's fine. For example:

```
SELECT * FROM media WHERE title IS NULL;
 media_id | category | title | creator | publication_year | description_text
----------+----------+-------+---------+------------------+------------------
(0 rows)
```

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 2MpoLH
* title: Retrieving Records
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
