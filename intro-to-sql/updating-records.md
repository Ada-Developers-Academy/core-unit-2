# Updating Records

## Learning Goals

## Introduction

Zahra is a user of a chat app, which allows her to add and manage her different contacts. She can select a contact and talk with them, and categorize her contacts too.

However, one day, Zahra's friend tells her that they've changed their name. Zahra needs to update her friend's contact information. While she does that, she realizes that she made a category named "Best Freinds," typo and all. She wants to fix the category name to "Best Friends."

Consider these features:

1. As a user, I should be able to update my contacts's names, so I can keep my contact information up-to-date
1. As a user, I should be able to rename the categories I put my contacts in, so I can find my contacts by the correct category name

Now, imagine that this chat app had a database and table like this:

**Table**: `contact`

| `contact_id` (`INT`) | `name` (`VARCHAR(100)`) | `category` (`VARCHAR(50)`) |
| -------------------- | ----------------------- | -------------------------- |
| `278`                | `'Cheyenne O''Brien'`   | `'Best Freinds'`           |
| `279`                | `'Adina Lennon'`        | `'Best Freinds'`           |
| `280`                | `'Jett Sargent'`        | `NULL`                     |
| `281`                | `'Eliot Giles'`         | `'Adies'`                  |

Imagine you're a programmer on this chat app. How would you accomplish changing the data to implement these features? What do you need to consider?

## Updating Records With `SELECT`

Before we update a record in a table, we should first determine:

- Which table contains the data we need to update
- Which record(s) we need to update
  - How can we determine how to accurately find these records, and only these records?
- What column(s) we need to update
- The new value(s) for these column(s)

### !callout-info

## Can Update Multiple Records and Columns at Once

Postgres supports updating one or multiple records at once. It also supports updating one or multiple columns of those records at once.

### !end-callout

To update a record(s), we use the following SQL syntax:

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

| Piece of Code                             | Notes                                                                                   |
| ----------------------------------------- | --------------------------------------------------------------------------------------- |
| `UPDATE`                                  | Keyword that begins an update statement                                                 |
| `table_name`                              | **Replace this** with the name of the correct table                                     |
| `SET`                                     | Keyword that begins a set-clause, where you determine what and how gets updated         |
| `column1 = value1, column2 = value2, ...` | **Replace this** with a comma-separated list of column names `=` to their new values    |
| `WHERE`                                   | Keyword that begins a where-clause, where you determine what gets updated               |
| `condition;`                              | **Replace this** with a condition that must be true in order for a record to be updated |

_The `WHERE` clause is optional_. Without a `WHERE` clause, all records within the table will be expected.

### !callout-danger

## Without `WHERE`, All Are Updated

If you omit the WHERE clause, ALL records will be updated!

### !end-callout

### Examples on Updating Records

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. For each column-value pair, what is the column and what is the value?
1. What kinds of record(s) will be updated?

1. Update all records to have an `author_name` value `"(No Author)"`

```sql
UPDATE authors
SET author_name = '(No Author)';
```

2. Update the record with `id` `2` so the `is_available` attribute is `false`. (Update Driver #2 to be unavailable.)

```sql
UPDATE drivers
SET is_available = false
WHERE id = 2;
```

3. Update the record with `id` `1` so `publication_year` is `"1990"` _and_ `description_text` is `NULL`. (Update Media #1 with a new publication year and empty description.)

```sql
UPDATE media
SET publication_year = '1990', description_text = NULL
WHERE media_id = 1;
```

4. Update all records with the category `"album"` to the category `"Album"`. (Rename category `"album"` to `"Album"`.)

```sql
UPDATE media
SET category = 'Album'
WHERE category = 'album';
```

### Feedback on Updating Records

A successful update will print out `UPDATE #`, where `#` is the number of records updated.

For example, an update of 3 records will print out `UPDATE 3`.

### !callout-secondary

## Updating Zero Matching Records

What happens if the `UPDATE` statement didn't find any records? An `UPDATE` statement might not find any records either because the `WHERE` condition gave no records or the table was empty. Even if the statement didn't find any matching records, it might still be a successful update that affects 0 records. We will probably see the output `UPDATE 0`.

### !end-callout

An invalid `UPDATE` statement will produce an error, and nothing will be updated.

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

## Summary

## Check for Understanding
