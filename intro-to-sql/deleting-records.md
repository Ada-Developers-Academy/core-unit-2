# Deleting Records

## Learning Goals

- Practice deleting records from a table

## Introduction

Zahra is a user of a chat app, which allows her to add and manage her different contacts. She can select a contact and talk with them, categorize her contacts, and update contact information.

Unfortunately Zahra finds two entries for the same friend.  She only needs the one entry and so she wants to cleanup her contacts and remove the duplicate entry.

Consider this feature:

1. As a user, I should be able to delete contacts so I can remove entries I do not need.

Now, imagine that this chat app had a database and table like this:

**Table**: `contact`

| `contact_id` (`INT`) | `name` (`VARCHAR(100)`) | `category` (`VARCHAR(50)`) |
| -------------------- | ----------------------- | -------------------------- |
| `278`                | `'Cheyenne O''Brien'`   | `'Best Freinds'`           |
| `279`                | `'Adina Lennon'`        | `'Best Freinds'`           |
| `280`                | `'Jett Sargent'`        | `NULL`                     |
| `281`                | `'Eliot Giles'`         | `'Adies'`                  |

Imagine you're a programmer on this chat app. How would you accomplish changing the data to implement this feature? What do you need to consider?

## Removing Records With `DELETE`

Before we delete a record in a table, we should first determine:

- Which table contains the data we need to delete
- Which record(s) need to be removed
  - How can we determine how to accurately find these records, and only these records?

### !callout-danger

## Can Delete Multiple Records At Once

All relational databases including Postgres support deleting one or multiple records at once.  This can be **dangerous** because a mistake could cause unintentional deletions!

### !end-callout

To delete a record(s), we use the following SQL syntax:

```sql
DELETE FROM table_name
WHERE condition;
```

| Piece of Code                             | Notes                                                                                   |
| ----------------------------------------- | --------------------------------------------------------------------------------------- |
| `DELETE FROM`                                  | Keywords that begin an deletion statement                                                 |
| `table_name`                              | **Replace this** with the name of the correct table                                     |
| `WHERE`                                   | Keyword that begins a where-clause, where you determine what gets deleted               |
| `condition;`                              | **Replace this** with a condition that must be **true** in order for a record to be deleted |

_The `WHERE` clause is optional_. Without a `WHERE` clause, all records within the table will be removed!.

### !callout-danger

## Without `WHERE`, All Are Deleted

If you omit the WHERE clause, ALL records will be deleted!

### !end-callout

### Example and Output

Imagine the following table named `media` with these columns and four records.

| `media_id` | `category` | `title`         | `creator`      | `publication_year` | `description_text`                    |
| ---------- | ---------- | --------------- | -------------- | ------------------ | ------------------------------------- |
| 1          | book       | Red Java        | Jewel Koss     | 1971               | Nisi ducimus reprehenderit molestiae. |
| 2          | book       | Postmodern Been | Glen Senger    | 1929               | Dolore repellendus doloribus maiores. |
| 3          | movie      | American Select | Xuan Pouros    | 1997               | Corporis id voluptatem fuga.          |
| 4          | movie      | Wake-up Utopia  | Buena Shanahan | 1930               | Fuga corrupti ducimus animi.          |

After running this SQL statement...

```sql
DELETE FROM media
WHERE id = 3;
```

our `media` table will look like this:

| `media_id` | `category` | `title`         | `creator`      | `publication_year` | `description_text`                    |
| ---------- | ---------- | --------------- | -------------- | ------------------ | ------------------------------------- |
| 1          | book       | Red Java        | Jewel Koss     | 1971               | Nisi ducimus reprehenderit molestiae. |
| 2          | book       | Postmodern Been | Glen Senger    | 1929               | Dolore repellendus doloribus maiores. |
| 4          | movie      | Wake-up Utopia  | Buena Shanahan | 1930               | Fuga corrupti ducimus animi.          |

After running this SQL statement...

```sql
DELETE FROM media;
```

our `media` table will look like this:

| `media_id` | `category` | `title`         | `creator`      | `publication_year` | `description_text` |
| ---------- | ---------- | --------------- | -------------- | ------------------ | ------------------ |

The table is now empty.  **All records are removed!**

### Examples on Deleting Records

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. Which record(s) will be removed?

```sql
DELETE FROM authors
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. This statement impacts the `authors` table.
1. All records in this table will be deleted.

</details>

```sql
DELETE FROM drivers
WHERE id = 2;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. This statement impacts the `drivers` table.
1. This statement deletes the record with an `id` column equal to 2.
</details>

```sql
DELETE FROM presidents
WHERE id > 44;
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. This statement impacts the presidents table.
1.  All records with id values greater than 44 will be deleted.
</details>

```sql
DELETE FROM drivers
WHERE license_expires = '2020'
```

<details style="max-width: 700px; margin: auto;">
  <summary>Answer</summary>

1. This statement impacts the drivers table.
1. All records with a license_expires field equal to '2020' will be deleted.
</details>

### Feedback on DELETING Records

A successful deletion will print out `DELETE #`, where `#` is the number of records deleted.

For example, a delete of 3 records will print out `DELETE 3`.

Further when we attempt to delete and **no** records match the `WHERE` condition.

```sql
DELETE FROM media
WHERE publication_year > 2100;
```

generates the result `DELETE 0`

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: 2bb3f20b-4483-49a3-9b14-1a92bbbb5ea7
* title: DELETING Records
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

1. `DELETE`
1. `FROM`
1. `hotel_guests`
1. `WHERE`
1. `guest_id <= 47`
1. `;`

##### !end-answer

### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 30f01d85-fdbf-49b9-bdd1-afcbe2a3e7ef
* title: Updating Records
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
