# Problem Set: More Selecting in SQL

## Directions

Complete all questions below.

## Practice

<!-- Compound question 1 -->
<!-- Compound question 2 -->
<!-- Ordering question 1 -->
<!-- Ordering question 2 -->
<!-- Limit/Offset question 1 -->
<!-- Limit/Offset question 2 -->










<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

<!-- prettier-ignore-start -->
### !challenge

* type: code-snippet
* language: sql
* id: 18206d9a-fde5-403d-a6ca-52686ff6cc9c
* title: More Selecting in SQL
* data_path: /more-selecting-in-sql/sql/create-products-table.sql

##### !question

Consider a table defined by the following SQL command:

```sql
CREATE TABLE flowers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  soil_type VARCHAR(32),
  light_level VARCHAR(32),
  season VARCHAR(32)
);
```

Write a `SELECT` statement that retrieves the names of the flowers that prefer `'acidic'` soil and `'partial shade'`.

##### !end-question

##### !placeholder


```sql
-- write a statement to select...
SELECT name
FROM flowers
WHERE soil_type = 'acidic'
AND light_level = 'partial shade';
```

##### !end-placeholder

##### !tests


```sql
select 1;
```

##### !end-tests

### !end-challenge
<!-- prettier-ignore-end -->

<!-- ======================= END CHALLENGE ======================= -->

