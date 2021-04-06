# Updating Records

## Learning Goals

- Practice updating records from a table

## Introduction

Zahra is a user of a chat app, which allows her to add and manage her different contacts. She can select a contact and talk with them, and categorize her contacts too.

However, one day, Zahra's friend tells her that they've changed their name. Zahra needs to update her friend's contact information. While she does that, she realizes that she made a category named "Best Freinds," misspelling and all. She wants to fix the category name to "Best Friends."

Consider these features:

1. As a user, I should be able to update my contacts' names, so I can keep my contact information up-to-date
1. As a user, I should be able to rename the categories I put my contacts in, so I can find my contacts by the correct category name

Now, imagine that this chat app had a database and table like this:

**Table**: `contact`

| `contact_id` (`INT`) | `name` (`VARCHAR(100)`) | `category` (`VARCHAR(50)`) |
| -------------------- | ----------------------- | -------------------------- |
| `278`                | `'Cheyenne O'Brien'`   | `'Best Freinds'`           |
| `279`                | `'Adina Lennon'`        | `'Best Freinds'`           |
| `280`                | `'Jett Sargent'`        | `NULL`                     |
| `281`                | `'Eliot Giles'`         | `'Adies'`                  |

Imagine you're a programmer on this chat app. How would you accomplish changing the data to implement these features? What do you need to consider?

## Updating Records With `SET`

Before we update a record in a table, we should first determine:

- Which table contains the data we need to update
- Which record(s) we need to update
  - How can we accurately find these records, and only these records?
- What column(s) we need to update
- The new value(s) for these column(s)

### !callout-info

## We Can Update Multiple Records and Columns at Once

Postgres supports updating one or multiple records at once. It also supports updating one or multiple columns of those records at once.

### !end-callout

To update one or more records, we use the following SQL syntax:

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

| Piece of Code                             | Notes                                                                                   |
| ----------------------------------------- | --------------------------------------------------------------------------------------- |
| `UPDATE`                                  | Keyword that begins an update statement                                                 |
| `table_name`                              | **Replace this** with the name of the correct table                                     |
| `SET`                                     | Keyword that begins a set-clause, where we determine what gets updated and how          |
| `column1 = value1, column2 = value2, ...` | **Replace this** with a comma-separated list of column names `=` to their new values    |
| `WHERE`                                   | Keyword that begins a where-clause, where we determine what gets updated                |
| `condition;`                              | **Replace this** with a condition that must be true in order for a record to be updated |

_The `WHERE` clause is optional_. Without a `WHERE` clause, all records within the table will be updated.

### !callout-danger

## Without `WHERE`, All Are Updated

If we omit the WHERE clause, ALL records will be updated!

### !end-callout

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

After running this SQL statement...

```sql
UPDATE media
SET title = '🍀'
WHERE id = 3;
```

our `media` table will look like this:

<!--

Table in markdown for our convenience:

| `media_id` | `category` | `title`         | `creator`      | `publication_year` | `description_text`                    |
| ---------- | ---------- | --------------- | -------------- | ------------------ | ------------------------------------- |
| 1          | book       | Red Java        | Jewel Koss     | 1971               | Nisi ducimus reprehenderit molestiae. |
| 2          | book       | Postmodern Been | Glen Senger    | 1929               | Dolore repellendus doloribus maiores. |
| 3          | movie      | 🍀              | Xuan Pouros    | 1997               | Corporis id voluptatem fuga.          |
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
<td>🍀</td>
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

After running this SQL statement...

```sql
UPDATE media
SET description_text = '🍀';
```

our `media` table will look like this:

<!--

Table in markdown for our convenience:

| `media_id` | `category` | `title`         | `creator`      | `publication_year` | `description_text` |
| ---------- | ---------- | --------------- | -------------- | ------------------ | ------------------ |
| 1          | book       | Red Java        | Jewel Koss     | 1971               | 🍀                 |
| 2          | book       | Postmodern Been | Glen Senger    | 1929               | 🍀                 |
| 3          | movie      | 🍀              | Xuan Pouros    | 1997               | 🍀                 |
| 4          | movie      | Wake-up Utopia  | Buena Shanahan | 1930               | 🍀                 |
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
<td>🍀</td>
</tr>
<tr>
<td>2</td>
<td>book</td>
<td>Postmodern Been</td>
<td>Glen Senger</td>
<td>1929</td>
<td>🍀</td>
</tr>
<tr>
<td>3</td>
<td>movie</td>
<td>🍀</td>
<td>Xuan Pouros</td>
<td>1997</td>
<td>🍀</td>
</tr>
<tr>
<td>4</td>
<td>movie</td>
<td>Wake-up Utopia</td>
<td>Buena Shanahan</td>
<td>1930</td>
<td>🍀</td>
</tr>
</tbody></table>

### Examples of Updating Records

Read through these example SQL statements. For each example, read the code and answer:

- What is the name of the table?
- For each column-value pair, what is the column and what is the value?
- What kinds of record(s) will be updated?

#### Example 1

Update all records to have an `author_name` value `"(No Author)"`

```sql
UPDATE authors
SET author_name = '(No Author)';
```

#### Example 2

Update the record with `id` `2` so the `is_available` attribute is `false`. (Update Driver #2 to be unavailable.)

```sql
UPDATE drivers
SET is_available = false
WHERE id = 2;
```

#### Example 3

Update the record with `id` `1` so `publication_year` is `"1990"` _and_ `description_text` is `NULL`. (Update Media #1 with a new publication year and empty description.)

```sql
UPDATE media
SET publication_year = '1990', description_text = NULL
WHERE media_id = 1;
```

#### Example 4

Update all records with the category `"album"` to the category `"Album"`. (Rename category `"album"` to `"Album"`.)

```sql
UPDATE media
SET category = 'Album'
WHERE category = 'album';
```

### Feedback on Updating Records

A successful update will print out `UPDATE #`, where `#` is the number of records updated.

For example, an update of 3 records will print out `UPDATE 3`.

An _invalid_ `UPDATE` statement will produce an error, and nothing will be updated.

For example, what happens if we try to update an ID column that has the constraint `GENERATED ALWAYS`?

```sql
UPDATE media
SET media_id = 800;
```

We would get output similar to:

```
ERROR:  column "media_id" can only be updated to DEFAULT
DETAIL:  Column "media_id" is an identity column defined as GENERATED ALWAYS.
```

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: g9JMGK
* title: Updating Records
##### !question

Arrange the following syntax.

Assume the `hotel_guests` table is made with this SQL statement:

```sql
CREATE TABLE hotel_guests (
    guest_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    guest_name VARCHAR(200),
    is_checked_in BOOLEAN
)
```

##### !end-question
##### !answer

1. `UPDATE`
1. `hotel_guests`
1. `SET`
1. `is_checked_in = true`
1. `WHERE`
1. `guest_id = 47`
1. `;`

##### !end-answer
##### !hint

Because the `guest_id` column is `GENERATED ALWAYS`, we can assume that this statement is _not_ updating and setting the `guest_id = 47`.

##### !end-hint
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: KAmRKV
* title: Updating Records
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
