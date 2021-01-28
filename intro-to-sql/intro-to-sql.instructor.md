# Instructor: Intro to SQL Overall

This curriculum teaches like, one syntax for each concept.

Everything else is valid and probably just as efficient/easy/straightforward. **The reason why we teach one syntax is for simplicity on our end**.

Students researching and using other syntaxes is a-ok! Nothing really dangerous about it.

## Naming Conventions

**Biggest change from Rails**: There's no Rails inflector here, so **THERE ARE NO RULES AROUND NAMING CONVENTIONS**!

- Table names can be **singular OR plural**. Most folks actually prefer singular?
- Table and column names can be whatever case, but lower_snake_case is still a good default

There are a lot of opinions about column names. For this curriculum, it really doesn't _matter_, but for the sake of having an opinion:

- Prefer names that are excessively unique-- even if it's chill that table Authors and table Books but have columns named `name` and it's fine, most advice is to distinguish them intentionally as `author_name` and `book_name`
- Prefer high specificity. `start_date` is better than `date`

## Primary Keys

There are 237842389 different ways to designate a primary key

This curriculum will simply teach one: Make a column with the `PRIMARY KEY` constraint on the same line as the column definition
There are 238907423 naming recommendations for a primary key


Besides `id`, the other common pattern is:
1. Make a column named `entity_pk` (the emphasis on the `_pk` bit)
1. designate it as a primary key following one other column

## What's Covered Later

Use this list to anticipate what will come up in the curriculum later

Subjects that are covered in later lessons:

- Adding, deleting, modifying columns in a table
  - For now, just make tables with all the right columns, and drop the table if you need to
- Database seeds
- Joins/relationships/composition
- More practice on `SELECT` and cool `WHERE` stuff
  - ordering
  - limit

## What's Not Covered Later

Everything else will probably **not** be covered, so feel free to be confident about saying **they can research on their own**. Here's an attempt at a concrete list:

- `WHERE` with `IN`, `BETWEEN`, `LIKE`
  - aka selecting within a range/array
  - or selecting with patterns
- `OFFSET`, `EXISTS`, `ALL`, `ANY`
  - aka "start searching by this offset"
  - get if something exists
  - get if all or any of the condition are true
- `JSON` as an accepted data type
