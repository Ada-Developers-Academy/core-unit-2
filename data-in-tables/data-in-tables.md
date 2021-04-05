# Data in Tables

## Learning Goals

- Explain how tables hold data in rows and columns

## Introduction

Let's take our brains away from programming for this lesson, and only consider data in our daily life. Take one minute to imagine a spreadsheet you could use to track a budget for a vacation.

How could you use a spreadsheet to keep track of:

- How much money is in your budget?
- How much money is spent?
- What did you spend the money on?
- When did you spend the money?

In your imagination, also imagine:

- How would you label the data?
- Are there are pieces of information you'd like to keep track of in this spreadsheet? What are they?

Broadly, tables can be configured into an infinite number of shapes, and an infinite number of ways to use them.

In this lesson, we will focus on configuring tables so that each _row_ represents one _record_.

By focusing on this kind of table, we will be set up for recognizing patterns commonly found in software.

## Vocabulary and Synonyms

| Vocab     | Definition                                                        | Synonyms                     | How to Use in a Sentence                                                                                                                                                                                                              |
| --------- | ----------------------------------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Record    | A single set of related data                                      | row, data item, item         | "In the table of student contact information, there is a record for each student," "We should find the record for the student Medha to get all of Medha's information."                                                               |
| Attribute | A property of a record. A record can have one or more properties. | column, data field, field    | "In the students table, every student has a name and birthday, so they have the attributes "name" and "birthdate"," "For Medha's record, the "name" attribute has the value "Medha", and the "birthdate" has the value "01/01/1980"." |
| Reading   | Getting the value of something                                    | getting, querying, selecting | "We need to read through the students table to get Medha's record," "We need to read through Medha's record to get Medha's birthdate."                                                                                                |

## Tables Hold and Describe Data

Tables are made of rows and columns.

It's useful to begin a table with a section that labels the columns. We call this section the _header_, or the _header row_.

After the header comes the rows. Each row is a **record** that represents _one_ entity recorded in this table.

Columns, on the other hand, represent **attributes**. Each column holds the value of one _attribute_ of one _record_.

Consider this example table and how to describe this table using the words _record_ and _attribute_.

### New Hobbies to Try

| Description                    | Minimum Number of Hours | Resources Needed                                     | Will My Friend Milly Join Me? |
| ------------------------------ | ----------------------- | ---------------------------------------------------- | ----------------------------- |
| Juggling                       | 2                       | Juggling Props                                       | Yes                           |
| Take beginner's ceramics class | 5                       | Class fee                                            | Yes                           |
| Finish my reading backlog      | 20                      | All of the books I haven't finished but said I would | No                            |
| Solve Rubik's Cube             | 2                       | Rubik's Cube                                         | Yes                           |
| Fly a kite                     | 3                       | Good weather, two kites, transportation              | Yes                           |
| Write a song                   | Unknown                 | Computer                                             | No                            |

In this example table of new hobbies to try:

- Each _record_ is one hobby
- Each record has the following _attributes_:
  - Description
  - Minimum Number of Hours
  - Resources Needed
  - Will My Friend Milly Join Me?
- The _attributes_ are labeled in the header

## Using Tables Like a Computer Scientist

As programmers, we are particularly interested with interacting with tables by:

- Creating records
- Reading records
- Updating records
- Deleting records

### Reading Records From a Table

Consider in slow motion what it means to read a record from a table. 🦥

When we need to pull information from one record, we need to ask the following clarifying questions:

- Which record(s) are we trying to read?
- How do we know that it's the correct record(s)?
- What information do we need from this record(s)?
- What happens if we don't find any matching record?

### Example: Milly's Resources

Imagine that our friend Milly is ready to try a select few new hobbies with us.

What resources does Milly need? How do we find out what resources Milly needs?

Consider the following table. Then, consider all of the steps we need to take in order to get our answer.

| Description                    | Minimum Number of Hours | Resources Needed                                     | Will My Friend Milly Join Me? |
| ------------------------------ | ----------------------- | ---------------------------------------------------- | ----------------------------- |
| Juggling                       | 2                       | Juggling props                                       | Yes                           |
| Take beginner's ceramics class | 5                       | Class fee                                            | Yes                           |
| Finish my reading backlog      | 20                      | All of the books I haven't finished but said I would | No                            |
| Solve Rubik's Cube             | 2                       | Rubik's cube                                         | Yes                           |
| Fly a kite                     | 3                       | Good weather, two kites, transportation              | Yes                           |
| Write a song                   | Unknown                 | Computer                                             | No                            |

In very discrete steps, we can imagine getting Milly's resource with this process:

1. Get all of the hobbies where "Yes" is the value for the attribute "Will My Friend Milly Join Me?"
1. Only gather the values in the attribute "Resources Needed"
1. Only list the resources needed:
   - Juggling props
   - Class fee
   - Rubik's cube
   - Good weather, two kites, transportation

### !callout-info

## Rows Are Easy to Add, Columns Are Hard to Change

Updating records is a common action we do. What does it mean to update or modify the table itself? What would it mean to add a row, add a column, delete a row, or delete a column? Consider for a brief moment the following observations:

- Adding and deleting rows is equivalent to adding and deleting records
- Adding and deleting columns is painful
    - When we add a column, we'll need to go through each row and fill it in with some value.
    - Deleting a column also means going through and modifying every record.
    - Modifying the data for hundreds or thousands of rows (or more!) is _a lot_ of work!


### !end-callout

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: PvvBpf
* title: Data in Tables
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
