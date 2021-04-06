# Activity: Intro to SQL

## Goal

Our goal is to:

- Check that the Postgres interactive terminal is working for everyone
- Practice using the Postgres interactive terminal together
- Practice writing SQL statements

## Activity Instructions

Arrange into pairs or small groups if possible. The pair or small group members will help each other be accountable as they move forward.

Use your notes, collaborate with your group members, and look things up on the Internet.

Part 1 is a guided set of directions. Everyone should follow along with each other and help each other. Part 1 is accomplished when everyone in the group has finished all the steps.

Limit Part 1 to 20 minutes. If there is an individual issue that prevents a group member from completing Part 1, the group should move to Part 2, and the individual should follow along with someone else. However, if the majority of a group haven't finished Part 1 due to setup or other computer issues, continue on Part 1 together, help each other, and be sure to ask for help.

Part 2 is a set of information and a set of questions. The goal is to recreate that information within a database, and answer the questions by writing SQL statements. Keep your answers in your own notes.

### Preparation

- Ensure that Postgres has been installed

### !callout-success

## Think Outside the Box

If you find a way to accomplish something using syntax that wasn't described in the curriculum, it's still valid if it works!

### !end-callout

## Part 1

Open the Postgres interactive terminal with `$ psql -U postgres`.

View the list of Postgres databases on this machine using `\l`. Ensure that there isn't an existing database named `ride-share_development`. If there is, ask for help from an instructor or use your best judgment.

Create a database named `ride-share_development` with a SQL statement.

- [ ] Confirm that this database now exists with `\l`.

- [ ] Connect to this database with `\c ride-share_development`.

- [ ] View the list of tables in this database with `\dt`.

- [ ] Create a table with the following traits:
- The table is named `passengers`
- This table has the following columns:

  - `id`, with a data type of `INT`. It is this table's primary key, and it should always be generated as identity.
  - `passenger_name`, with a data type of `TEXT`, and a constraint `NOT NULL`
  - `phone_num`, with a data type of `TEXT`

- [ ] Confirm that your (empty) table looks correct so far. Run `SELECT * FROM passenger;` and check that you get output similar to this:

```
 id | passenger_name | phone_num
----+----------------+-----------
(0 rows)
```

- [ ] Add a new valid record to the `passengers` table. Use whatever data brings you joy!

### !callout-info

## Tips: Use Your Resources! Drive Your Debugging!

If your table columns have a mistake, feel free to either drop the table and recreate it, or research the syntax for renaming tables or adding, removing, or modifying columns.

### !end-callout

- [ ] Confirm that your table now has 1 record. Run `SELECT * FROM passenger;` and check that you see your new record.

- [ ] Attempt to add an _invalid_ record to the `passengers` table. Do this by either _excluding_ a value for `passenger_name`, or by giving the value `NULL`. Check that you get output similar to this:

```
ERROR:  null value in column "passenger_name" violates not-null constraint
DETAIL:  Failing row contains (2, null, X XXX XXX XXXX).
```

- [ ] Confirm that your table still has 1 record with a `SELECT` statement.

- [ ] Update the record. Use the record's `id` value to find this record. Update the record's `passenger_name` value to: "Once my group has finished this step, we're done with Part 1!".

- [ ] Confirm that your record has been updated. 🙂

## Part 2

Your goal is to recreate a table of data in Postgres. You will need to make assumptions. Feel free to experiment!

Follow these steps:

- Take 1 minute to read through the table below.
- With your group, make a plan.
  - How many columns are there?
  - What are their names?
  - What are their data types?
- With your group, recall the steps you need to take, from creating the database to inserting records.
- There is a CSV file provided. With your group, briefly discuss how this CSV file may help.

<!-- Intentional double space on next line to break them -->

**Database**: `media_ranker`  
**Table**: `media`

| Category | Title               | Creator          | Publication Year | Description                            |
| -------- | ------------------- | ---------------- | ---------------- | -------------------------------------- |
| book     | Red Java            | Jewel Koss       | 1971             | Nisi ducimus reprehenderit molestiae.  |
| book     | Postmodern Been     | Glen Senger      | 1929             | Dolore repellendus doloribus maiores.  |
| movie    | American Select     | Xuan Pouros      | 1997             | Corporis id voluptatem fuga.           |
| movie    | Wake-up Utopia      | Buena Shanahan   | 1930             | Fuga corrupti ducimus animi.           |
| movie    | Summer Bean         | Carolina Pfeffer | 1997             | Nesciunt consequatur reiciendis sequi. |
| album    | American Cake       | Asley Durgan     | 1954             | Vero voluptates voluptatibus qui.      |
| movie    | Chocolate Forrester | Dorthey Cormier  | 1957             | Velit earum quo voluptates.            |
| album    | Spilt Cowboy        | Shaun Nikolaus   | 1965             | Esse quia et dolor.                    |
| movie    | Goodbye Forrester   | Sherwood Toy PhD | 1999             | Ipsam velit mollitia quo.              |
| book     | Blacktop Equinox    | Man Von          | 2017             | Rerum est labore accusamus.            |

<!-- TODO: Add absolute link for this -->

For your convenience, [here is the data for this table as a CSV file](../assets/intro-to-sql_activity-intro-to-sql_media.csv).

**Pro-Tip**: Draft your `INSERT` statements in a separate file. Utilize teamwork!

### !callout-secondary

## How Could We Loop?

It's likely that you just inserted ten records into a table one by one... and it's likely that you thought, "Ugh! I wish I could loop through this!" In order to loop through this data, we would need two additional skills:

1. Reading through CSV files
1. Writing loops in SQL

It's likely that, for this activity, inserting ten records one by one is more efficient, but follow your curiosity!

### !end-callout

Now, come up with SQL statements that can answer the following questions:

- How many albums are there?
- What are the titles and creators of all media published before 1970?
- What is the ID of the record with the title "Spilt Cowboy"?

## How to Review

- In Part 1, what was the trickiest step? Why?
- When we insert a new record, can we ever change the order of the columns and values listed in our `INSERT` statement? Why, when, and/or how?
- There are many solutions to the questions in Part 2. What are some examples your group came up with?
