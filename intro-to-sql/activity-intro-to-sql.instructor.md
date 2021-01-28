# Instructor: Activity: Intro to SQL

This REAL goal of this activity is to check that everyone's tools are working.

# Part 2

CSV: I provided a CSV file for them because otherwise it'd suck to type all of it out.

For your benefit, here are the steps you can use to copy and paste for Part 2. Students may have different column names and data types.

```sql
CREATE DATABASE media_ranker;
\c media_ranker;
CREATE TABLE media (
    media_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    category VARCHAR(20),
    title TEXT,
    creator TEXT,
    publication_year VARCHAR(8),
    description_text TEXT
);

INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('book','Red Java','Jewel Koss','1971','Nisi ducimus reprehenderit molestiae.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('book','Postmodern Been','Glen Senger','1929','Dolore repellendus doloribus maiores.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('movie','American Select','Xuan Pouros','1997','Corporis id voluptatem fuga.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('movie','Wake-up Utopia','Buena Shanahan','1930','Fuga corrupti ducimus animi.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('movie','Summer Bean','Carolina Pfeffer','1997','Nesciunt consequatur reiciendis sequi.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('album','American Cake','Asley Durgan','1954','Vero voluptates voluptatibus qui.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('movie','Chocolate Forrester','Dorthey Cormier','1957','Velit earum quo voluptates.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('album','Spilt Cowboy','Shaun Nikolaus','1965','Esse quia et dolor.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('movie','Goodbye Forrester','Sherwood Toy PhD','1999','Ipsam velit mollitia quo.');
INSERT INTO media (category, title, creator, publication_year, description_text) VALUES ('book','Blacktop Equinox','Man Von','2017','Rerum est labore accusamus.');

```

Answers

```sql
-- How many albums are there? 
-- Using COUNT is valid too
SELECT * FROM media WHERE CATEGORY = 'album';

-- What are the titles and creators of all media published before 1970?
SELECT title, creator FROM media WHERE publication_year < '1970';

-- What is the ID of the record with the title "Spilt Cowboy"?
SELECT media_id FROM media WHERE title = 'Spilt Cowboy';
```