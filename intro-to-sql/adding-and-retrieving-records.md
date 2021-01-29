# Adding and Retrieving Records

## Learning Goals

- Practice adding records into a table
- Practice retrieving records from a table

## Introduction

Imagine that Kenan is working on a webapp that categorizes different pieces of media, such as books, albums, and movies.

In Kenan's webapp, he knows that he wants to add hundreds of books, albums, and movies. He wants to include their title, creator, publication date, and a description. How does he populate his database?

Once Kenan has added his whole media library, he wants to build features to help users explore it. His features will show different categories and filters. With his data, he may ask:

- Which records are in the category "book"?
- Which records were published before 1990?
- Which records are missing a description?

### !callout-danger

## In SQL, Strings Use Single Quotes (`'`) Only

Before we begin diving into SQL syntax, let's call out one new syntax rule that is very different from Python. In SQL, a string is a sequence of characters **within single quotes (`'`)**. For example, valid strings include `'Hello, World!'` and `'This text is between single-quotes.'`. We can include a single-quote inside of a string by using two single quotes. For example, `'Isn''t Ada''s code so clever?'` will correctly mean "Isn't Ada's code so clever?".

### !end-callout

## Format

The format of this lesson is as follows:

1. Definition and syntax of `INSERT`
1. Check for Understanding about `INSERT`
1. Definition and syntax of `SELECT`
   1. Using `WHERE` with `=`, `>=`, `<=`, `>`, `<` operator
   1. Using `WHERE` with `IS NOT NULL`
1. Check for Understanding about `SELECT`

## Adding Records With `INSERT`

Before we add a record to a table, we should first determine:

- Which table we're adding to
- What the columns of that table are

To add a record, we use the following SQL syntax:

```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

| Piece of code                    | Notes                                                                                                                               |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `INSERT INTO`                    | SQL keywords that begin to add a record                                                                                             |
| `table_name`                     | **Replace this** with the name of the correct table                                                                                 |
| `( ... )`                        | Contains a list of the column names in the table. _This list is optional, but highly recommended._                                  |
| `column1, column2, column3, ...` | **Replace this** with a list of the column names in the table. Column names should be comma-separated.                              |
| `VALUES`                         | A SQL keyword that indicates the values to insert into a new record                                                                 |
| `( ... );`                       | Contains a list of the values to insert into a new record. Remember the semicolon at the end to finish the statement!               |
| `value1, value2, value3, ...`;   | **Replace this** with the values for the new record. The order of values **must** exactly match the order of columns listed before. |

The order of values listed **must** exactly match the order of columns listed. In this example, `value1` is the value for `column1` because they're both listed first, and `value3` is the value for `column3` because they're both listed third.

When we have a column that is `GENERATED AS IDENTITY`, we **do not** need to supply a value for this column. If the column is `GENERATED ALWAYS AS IDENTITY`, we **should not** and **cannot** supply a value for this column.

### !callout-info

## SQL Is Not Whitespace-Sensitive

SQL syntax does not require certain spaces, line breaks, or indentation. All SQL statements can be written on one or ten lines, as long as the statement properly ends with a semicolon. The SQL code style of this curriculum mimics what many tutorials, guides, and teams use.

### !end-callout

### !callout-info

## SQL Keywords Are Not Case-Sensitive

SQL keywords are not required to be in ALL CAPS. For example, it's valid SQL syntax to use `INSERT`, `INTO`, `VALUES`, `insert`, `into`, and `values`. Most people prefer to follow the style of capitalizing SQL keywords.

### !end-callout

### Examples on Inserting Records

Read through these example SQL statements. For each example, read the code and answer:

1. What is the name of the table?
1. For each column-value pair, what is the column and what is the value?
1. Which pieces of syntax are unfamiliar?

1.

```sql
INSERT INTO authors (author_name)
VALUES ('Octavia E. Butler');
```

2.

```sql
INSERT INTO drivers (vin, is_available)
VALUES ('11112222333344445', false);
```

3.

```sql
INSERT INTO media (category, title, creator, publication_year, description_text)
VALUES (
    'album',
    'Blue Breaker',
    'Dr. Sarai Langosh',
    '1949',
    'Lorem ipsum dolor sit amet'
);
```

### Getting Default Value for Generated ID

What happens when we need to create a record and the table has an `id` column? For example, look at the `???` in the following code:

```sql
INSERT INTO authors (author_name, author_id)
VALUES ('Octavia E. Butler', ???);
```

What do we put as the value of `author_id`?

We have a few options:

1. Exclude the id column from the column list (much like the examples above)
1. Use the SQL keyword `DEFAULT`, which will pick the next appropriate value

For example, these statements will accomplish the same thing:

```sql
INSERT INTO authors (author_name, author_id)
VALUES ('Octavia E. Butler', DEFAULT);

INSERT INTO authors (author_name)
VALUES ('Octavia E. Butler');
```

## When `INSERT` Fails

Sometimes, our `INSERT` statement will fail, and we are _unsuccessful_ at adding a new record.

When our `INSERT` statement fails, we should observe:

- No new records are added to the table
- An error message with details prints out

Imagine an `authors` table, where the `author_id` column has the constraint `GENERATED ALWAYS`. This constraint doesn't allow us to specify a value for `author_id`.

When we run this statement:

```sql
INSERT INTO authors (author_id, author_name)
VALUES (777777, NULL);
```

We should observe this output:

```
ERROR:  cannot insert into column "author_id"
DETAIL:  Column "author_id" is an identity column defined as GENERATED ALWAYS.
HINT:  Use OVERRIDING SYSTEM VALUE to override.
```

This output means:

1. The error is caused by attempting to insert into column `author_id`, but we cannot
2. A detailed explanation is that the `author_id` is an identity column defined as `GENERATED ALWAYS`
3. Postgres gives a suggestion. If you truly want to override this constraint, you can research and use `OVERRIDING SYSTEM VALUE`.

To move past this, we should debug the logic and syntax of our `INSERT` statement, and retry it. A failed `INSERT` in this context shouldn't have any other consequences to concerned about.

### !callout-secondary

## What if We Inserted the Wrong Values?

What happens if we successfully inserted a record, but it has the wrong data?! There is no "undo," we should remedy this by updating the record, or deleting and adding a new record. This syntax is covered in other lessons, but follow your curiosity!

### !end-callout

## Check for Understanding: `INSERT`

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: pXryrf
* title: Adding and Retrieving Records
##### !question

Arrange the following syntax.

##### !end-question
##### !answer

1. `INSERT`
1. `INTO`
1. `hotel_guest`
1. `(id, is_checked_in)`
1. `VALUES`
1. `(777, true)`
1. `;`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: sM7OWh
* title: NameOfLesson
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
