# Grouping

## Goals

- Explain how `SELECT` statements can divide rows into groups by using the `GROUP BY` clause
- Write `SELECT` statements using `Group BY` clauses and aggregate functions to calculate aggregate values on groups of rows

## Introduction

We can write queries to discover the maximum and minimum values for the entire query, but this can be quite limiting. Consider if we are building an online store and want to know how many products each vendor is setting? What if we want to find the most expensive product each vendor sells?

In these queries we want to group up a set of rows by a specific criterea and then run an aggregate query like `COUNT`, `MAX` or `MIN` on each group.

## GROUP BY To Get Distinct Entries

When we add a `GROUP BY` clause to a query, it causes the structure of the results to change. Let's consider a small database consisting of the following table:

![Alumni Table](../assets/more-selecting-in-sql_grouping_alumni-table.svg)  
_Fig. A small database storing information about Ada alums in an `alumni` table_

Our database probably has multiple records in this table that have the same value for `cohort`. Certainly there are at least tens of individuals in any particular cohort. So if were to select all the records from the `alumni` table, we should see many records with distinct names, but the same `cohort`. A query to retrieve all the records from this table could be as follows:

```sql
SELECT *
FROM alumni;
```

With this query, all records in the table would be returned, each with all of its fields: `id`, `first_name`, `last_name`, `state`, `birthdate`, `cohort`, and `employer`.

If we wanted to group the results by cohort, we might try the following query:

```sql
SELECT *
FROM alumni
GROUP BY cohort;
```

But we will receive an error resembling the following:

```
ERROR:  column "alumni.id" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: select *
               ^
```

This is the first difference between a grouped result, and a regular result: only fields appearing in the `GROUP BY` clause may appear in the list of `SELECT` columns.

If we modify the query slightly:

```sql
SELECT cohort
FROM alumni
GROUP BY cohort;
```

We will no longer encounter an error. Instead, we could receive a result like the following:

```
 cohort
-----------
 Cohort 10
 Cohort 15
 Cohort 12
 Cohort 8
 Cohort 9
 Cohort 11
 Cohort 13
 Cohort 14
(8 rows)
```

It seems the data only goes back to C8. The rest of the data is probably in a different location. More importantly to the current discussion, notice that the result is made up of a unique list of the values found in the `cohort` field.

If we `GROUP BY` some column in the data, and list that column in our `SELECT` results, we will receive a unique list of the values found in that column. We can use `GROUP BY` to get distinct entries from our data.

## GROUP BY With Aggregate Functions

We saw in the previous example that listing a column (or the `*` wildcard) as part of the `SELECT` columns results in an error when they are not a part of the `GROUP BY` columns. Let's think about why this occurs.

SQL queries return tables of results. What kind of table could be the result of grouping? When we group by a particular column, all the records that share a particular value for that column are grouped together. Let's consider a subset of hypothetical data way back from cohort 8.

| first_name | cohort   |
| ---------- | -------- |
| Felicia    | Cohort 8 |
| Lorena     | Cohort 8 |
| Vera       | Cohort 8 |
| Agnes      | Cohort 8 |
| Courtney   | Cohort 8 |

_Fig. Sample data subset from the `alumni` table._

When we grouped by the cohort, we saw that this resulted in a unique list of column data. If we tried to include `first_name` in that result, how could a result table be generated? It would need to resemble the following:

```
 cohort   | first_name
----------+----------------------------------------
 Cohort 8 | Felicia, Lorena, Vera, Agnes, Courtney
(1 rows???)
```

There should be only one row for the cohort value, but many first names would need to be associated with that cohort value. This is not a valid result table structure, where each record lives in its own row.

Since we have included grouped results in the query, the only things we are allowed to include in the result are either the grouped columns themselves, or aggregate information about the grouped columns.

By using an aggregate function, such as `MAX`, `COUNT`, or any others we have discussed, we can get aggregate results for each grouped section of records.

The general syntax for a `SELECT` query using grouping is as follows:

```sql
SELECT
   column_desired_1,
   column_desired_2,
   ...,
   aggregate_function(column_to_aggregate)
FROM
   table_name
GROUP BY
   column_desired_1,
   column_desired_2,
   ...;
```

Notice that each of the entries in the `SELECT` portion are either columns corresponding to the columns listed in the `GROUP BY`, or they are an aggregate function applied to a non-grouped column.

For example, given this `books` table:

| title                         | price | author_id |
| ----------------------------- | ----- | --------- |
| Death of the Webbed Boa       | 10    | 1         |
| Groomsday                     | 5     | 1         |
| Beyond the Truth              | 6     | 2         |
| The Way of the Eight          | 12    | 3         |
| Mask of Exile                 | 11    | 2         |
| 2938 Destiny                  | 2     | 2         |
| Mystery of the Crispy Tourist | 16    | 3         |
| Clue of the Painted Pendant   | 25    | 3         |

_Fig. Example `books` table_

We could write the following query:

```sql
SELECT author_id, MAX(price)
FROM BOOKS
GROUP BY author_id
ORDER BY author_id;
```

This query will find the most expensive price for each author.

```
 author_id | max
-----------+-----
         1 | 10
         2 | 11
         3 | 25
(3 rows)
```

We could also write a query to find the number of alumni at Ada by state.

If our `alumni` table had the same schema as above (reproduced here):

![Alumni Table](../assets/more-selecting-in-sql_grouping_alumni-table.svg)  
_Fig. Ada `alumni` table reproduced from above_

We could find the number of alumni from each state with:

```sql
SELECT state, count(*)
FROM alumni
GROUP BY state;
```

The results might resemble the following:

```
 state      | count
------------+-------
 Texas      | 10
 Oregon     | 4
 Washington | 230
 New York   | 6
 California | 15
(5 rows)
```

<!-- ## Check for Understanding -->

<!-- Question on SELECTING distinct Column entries -->

<!-- SQL Question to SELECT the most recent birthdate by cohort -->
