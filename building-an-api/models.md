# Models

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=d1fcd890-3fb6-404d-b28f-ad110031a865&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goal

Our goal for this lesson is:

1. Introduce the vocabulary "model," as it's commonly used in web development, and will be used in Flask
1. Briefly introduce the steps to setting up a model
1. Introduce the vocabulary "database migration" and the pattern of migrating the database

## Vocabulary and Synonyms

| Vocab              | Definition                                                                                                                                            | Synonyms                                   | How to Use in a Sentence                                                                                                                                  |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Model              | A representation of a single concept relevant to the application. The model defines the state and behavior for that concept.                          | Data model, resource, entity, domain model | "Example models in an e-shopping web app might be `User`, `Product`, `Review`, and `Order`"                                                               |
| Database Migration | When working with relational databases, a representation of a change in a database's schema. Migrations must be created and then applied to databases | Schema migration, migration                | "We want the `Product` table to add a new integer column, `stock`. We need to generate a migration to represent that change, and then run the migrations" |

## Models

In software, a **model** is a representation of a single concept relevant to the application. This representation includes state and behavior.

For example, if we were building an app that represents a ride share service, we might have the models:

- `Driver`
- `Passenger`
- `Trip`

If "models" sounds similar to _resource_, _entity_, or _class_, you're onto something! All four of these terms can mean similar ideas, where the only notable differences are context.

## Models in Flask

We will define models in our Flask application code. We will use the package `SQLAlchemy` and follow their patterns to define and use models. Models in our Flask code will create a direct connection between the data modeled in our database, and the OOP Python code we can use in our back-end API.


## Models Are a Link Between a Database and Code

Our models are usually pieces of data that should be stored in a database. Their data should be persisted. To set up a model, we will need to:

1. Set up the database for the project
1. Configure our app to connect to the database
1. Define our model in Python code
1. Ensure that Flask and SQLAlchemy are able to see our model code
1. Use tools to convert the model into instructions for creating or updating tables
1. Apply the instructions to our database to create or update the tables

### Creating the Database

Before we work with models in Flask, we should expect to create a database. We should continue to practice our great database skills!


### Connecting the Database and Flask

Flask needs a way to connect to our database. We'll do so by providing a path to it.


### Create the Model File and Class

We will create a class for each model. The class will define the state and behavior of our model.

#### The `app/models` Directory

SQLAlchemy and Flask patterns encourage us to define each model as a class in its own file.

This curriculum's recommended file structure creates a `models` folder inside of the `app` folder. Note the location of a hypothetical model, `Model`, in `app/models/model.py`, as well as the typical `__init__.py` file to mark the folder as a package.

```
.
├── app
│   ├── models
│   │   ├── __init__.py
│   │   └── model.py
│   ├── __init__.py
│   └── routes.py
├── README.md
└── requirements.txt
```

### Make Our Models Visible to the Flask Migration Helper

Creating the model file alone is not enough for Flask to generate instructions for modifying the database. We need to ensure the helper is able to find our models.

### Generate Instructions for Modifying Our Database

Flask and SQLAlchemy, our package connecting our models to the database, provide many useful model-related features. One such feature is that it can examine our models defined in Python, and produce a list of instructions for how to modify the database to be able to store the state of those models. This can include both creating new tables, and altering existing tables.

### Apply the Instructions to Modifying Our Database

Once the instructions have been generated, we use Flask and SQLAlchemy to apply those instructions to our database.

Generating and applying these instructions in separate steps allows for teams to work together. One member might add a new model, and generate instructions for a new table to be created. They will commit that model and the instructions to the team repo. The other members can retrieve those instructions and apply the same change to their local working databases.

## Using Defined Models in Flask

We don't need to write the code for storing, retrieving, or updating our models. SQLAlchemy lets us define our models as normal Python classes. Instead of writing full lines of SQL ourselves, we will write Python classes following patterns defined by SQLAlchemy, and SQLAlchemy will do most of the SQL heavy lifting for us!

SQLAlchemy has [already defined methods](https://flask-sqlalchemy.palletsprojects.com/en/2.x/queries/) for:

- Inserting new records into a table
- Querying records from a table
- Filtering records from a table
- Ordering records from a table
- Deleting records from a table

And much more!

### !callout-info

## SQLAlchemy Is an Object-Relational Mapper (ORM)

There are many ways to connect Python to a database. Some of them require us to write specific SQL queries ourselves. SQLAlchemy instead provides a connection from our Python classes (objects) to tables in a database (relations). In other words, it maps from object to relations. It's an Object-Relational Mapper!

<br />

In general, an Object-Relational Mapper is a tool that allows us to interact with tables without needing to write SQL directly.

### !end-callout

## Database Migrations

On bigger and bigger projects, we should anticipate the need to change our database schemas. Over time we will need to add new models to our projects, or we might need to modify existing models. Changes to our models require changes to our database schema. To provide the ability to track our database schema changes, we can organize our changes into _database migrations_.

A **database migration** is a representation of a change in a database's schema, usually as bit of code or a file of code. After migration files are created, these migration files can be applied to a database.

Migrations are usually applied using a database migration tool.

[Alembic](https://alembic.sqlalchemy.org/en/latest/) is the database migration tool that we will be using. It pairs nicely with SQLAlchemy. We will follow common database and Alembic practices to manage and maintain our migrations.

### One-time Setup: Initialize Migrations

After our database is created and we have configured our application to use it, we must initialize our migrations. We will only need to do this once.

### Generate Migrations After Each Model Change

After any change to any models, we will need to generate migration files.

### Apply Migrations After Each Model Change

After any new migration files are generated, we will need to apply those migration files. This is commonly known as "running the migrations."
