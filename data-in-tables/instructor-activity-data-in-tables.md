# Instructor: Activity: Data in Tables

The goal is to get students to establish motives for using data in tables by thinking of realistic features they'd build

This should help train a brain to go "What do I want to build? If I want to build that, what kind of data and table do I need?"

## Notes for Review

### "Why wouldn’t Craigslist just store this data in a list of dictionaries?"

A good conclusion to offer to the class would be something like "We will come to realize there are several reasons for this but the main one we'll focus on right now is the need for persistence, for the data to live on when our program is finished running."

It may also be worth clarifying that a database table is different from a list of dictionaries in that each dictionary might look totally different. In a database table, there's an enforcement that each item looks the same, so it would be more like a list of instances of the same class (eg. instances of the Listing class).

### In Part 2, did the columns for a post in "services" differ from the columns for a post in "for sale"? In what ways? Can a couple groups share what they got for part 2.3?

It may be worth noting that the ability to filter by things like "Accepts cryptocurrency" implies that there is a column for each listing indicating whether cryptocurrency is accepted. The general point here is that there's data being stored about each listing beyond what we can see visible on the webpage.