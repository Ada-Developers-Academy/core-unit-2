# Activity: Data in Tables

## Goal

Our goal is to practice imagining how tables of data are useful in software. We will reach this goal through small group exploration and discussion. Coming up with small, imperfect ideas collaboratively and quickly will expose our brains to lots of different possible tables. Be sure to **spend no more than 15 minutes in each section.**

## Activity Instructions

Split into small groups. Follow the prompts below, recording your answers in your own notes. **Spend no more than 15 minutes in each section.**

If you and your group haven't finished a section within 15 minutes, move on to the next section.

## Part 1: Explore craigslist

Explore [craigslist](http://craigslist.com/), a classified advertisements web app. craigslist has sections that allow users to make posts about jobs, housing, items for sale, and services.

Spend ten minutes getting familiar with craigslist with your group. Your group's goal is to get familiar enough with the features that you could describe them from a high-level perspective. Notice what kind of data is required or optional for different features.

In your exploration, be sure to try out the following features.

As a casual shopper on craigslist, I want to...

- [ ] See the list of categories and subcategories on the front page, so I can navigate between different categories
- [ ] See a list of posts relevant to one category, so I can see all of the relevant posts even if I don't know the subcategory
- [ ] See a list of posts relevant to one subcategory, so I can see all of the relevant posts that are specific to my needs
- [ ] Navigate between different pages of post listings, so I don't have to see all posts at the same time, but can easily browse through only 120 posts at a time
- [ ] Use the filters for "Bedrooms min-max" and "Bathrooms min-max" in the "apts / housing" category, so I can see only posts that match my criteria
- [ ] Use the events calendar, so I can browse for any events that are happening on a specific day
- [ ] Use the search feature, so I can look for my specific interests without browsing categories
- [ ] See a dropdown list of suggested search terms while I type, so I can see relevant search terms that are popular on craigslist and save time

## Part 2: Consider Tables, Columns, and Rows

Even though we are not developers for craigslist, let's use craigslist to imagine how tables hold data.

### !callout-danger

## Simplify!

For all of these prompts, we _**encourage**_ you to simplify your ideas and make assumptions, instead of going for 100% detailed accuracy. This is a limited activity, and our learning goals will be met without striving for perfection. 🙂

### !end-callout

1. Together as a group, pull up *one post* inside of the "Services" category and "Computer" subcategory. You will use this post as an example.

Imagine a table that holds data about posts, and this post is one record inside that table.

Make a list of the columns that this table might have. Also, for each column, decide if it holds a number, text, boolean, image, or a date or time.

2. Together as a group, pull up *one post* inside of the "For Sale" category and "Computer" subcategory. You will use this post as an example.

Imagine a table that holds data about posts, and this post is one record inside that table.

Make a list of the columns that this table might have. Also, for each column, decide if it holds a number, text, boolean, image, or a date or time.

## Part 3: Predict Data Needs

Each of the following prompts describes some kind of data that we could grab from craigslist. As a group, come up with _one_ realistic feature for craigslist that would use that specific kind of data. This feature can be imaginary, or already exist. Then, describe it in 1-2 sentences.

Here is an example prompt and several example responses:

**Get the names of all subcategories under one category**

- List/display all subcategories under one category on the front page
- Include the subcategories while searching for posts under one category
- When making a new post, display a dropdown that includes all subcategories for that category to choose from

### Prompts

1. Get 120 posts ordered by creation date, with the newest posts first
1. Get data from one user with a specific ID
1. Get the location of one post
1. Get the number of how many people have "favorited" a post
1. Get the "next" post, which is a post of the same subcategory and filters, but is less relevant than the current post
1. Get a list of all posts that have been flagged for removal (for breaking the terms of agreement)

## Part 4: Consider A Solar System App

Remember when we designed the API endpoints for an astronaut app? Let's now imagine what kind of data those planets and moons would have for the astronauts to browse through. Be as accurate or as creative as you like! Sure, the area of the planet or moon would be a great piece of information, but what about weather? Maybe we can create an alien species and keep track of its population!

At the end of this section, share your ideas briefly with your group.

### Prompts

Come up with...

1. One table of planet data
    - What would the table be named?
    - What would each record represent?
    - What data fields are needed in this table? Why?
1. One table of moon data
    - What would the table be named?
    - What would each record represent?
    - What data fields are needed in this table? Why?
1. A search feature that uses this table
1. A feature that creates a new record in this table
1. A feature that would update a record by planting a flag in this table

## How to Review

1. In Part 2, did the columns for a post in "services" differ from the columns for a post in "for sale"? In what ways?
1. In Part 3, what was your favorite feature that you came up with?
1. Considering the entire activity, which happened more frequently: getting all of the records from a table, or getting a specific set of records from a table?
