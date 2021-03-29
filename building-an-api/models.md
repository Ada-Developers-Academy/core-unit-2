# Models

## Goal

Our goal for this lesson is:

1. Introduce the vocabulary "model," as it's commonly used in web development, and will be used in Flask
1. Briefly introduce the steps to setting up a model
1. Introduce the vocabulary "database migration" and the pattern of migrating the database

## Vocabulary and Synonyms

| Vocab              | Definition                                                                                                                                            | Synonyms                                   | How to Use in a Sentence                                                                                                                                  |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Model              | A representation of a single concept relevant to the application that contains the state and behavior                                                 | Data model, resource, entity, domain model | "Example models in an e-shopping web app might be `User`, `Product`, `Review`, and `Order`"                                                               |
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

Therefore, when we set up each model, we will need to:

1. Ensure our database and tables are aligned with our model
1. Ensure our Flask code has defined and can use the model

## Models Relate to Databases

Our models are usually pieces of data that should be stored in a database. Their data should be persisted. To set up a model, we will need to:

1. Set up the database for the project
1. Set up the table for the model
1. Use our database migration tools

### Creating the Database

Before we work with models in Flask, we should expect to create a database. We should continue to practice our great database skills!

### Creating the Tables

Similarly, before we work with different tables that hold our model data in Flask, we'll need to define database tables.

### Connecting the DB and Flask

Flask needs a way to connect to our database. We'll do so by providing a path to it.

## Models Relate to Flask

In order for our Flask app to access the model, we will need to:

1. Define the model class in Flask
1. Configure our Flask app to use the model

## Create the Model File and Class

We will create a class for each model. The class will define the state and behavior of our model.

### The `app/models` Directory

SQLAlchemy and Flask patterns may encourage us to define each model as a class in its own file.

This curriculum's recommended file structure recommends creating a `models` folder inside of the `app` folder. Note the location of a hypothetical model, `model`, in `app/models/model.py`

```
.
├── README.md
├── app
│   ├── __init__.py
│   ├── models
│   │   └── model.py
│   └── routes.py
├── app.py
└── requirements.txt
```

### Configuring Models in Flask

Every time we define a new model, we'll need to make a small configuration update to our app.

### Using Defined Models in Flask

SQLAlchemy, our package that connects our models to the database, has powerful functionality. Instead of writing full lines of SQL, we will write Python that uses SQLAlchemy. SQLAlchemy will do most of the SQL for us!

SQLAlchemy has [already defined methods](https://flask-sqlalchemy.palletsprojects.com/en/2.x/queries/) for:

- Inserting new records into a table
- Querying records from a table
- Filtering records from a table
- Ordering records from a table
- Deleting records from a table

And much more!

## Database Migrations

On bigger and bigger projects, we should anticipate the effects of changing our database schemas. We can organize our database schema changes into _database migrations_.

A **datatbase migration** a representation of a change in a database's schema, usually as bit of code or a file of code. After migration files are created, these migration files can be applied to a database.

Because the scale of our projects is increasing, we will also introduce a database migration tool.

[Alembic](https://alembic.sqlalchemy.org/en/latest/) is the database migration tool that pairs nicely with SQLAlchemy. We will follow common database and Alembic practices to manage and maintain our migrations.

### One-time Setup: Initialize Migrations

After the first database, table, and the configurations are set, we must initialize our migrations. We will only need to do this once.

This command should create a new folder in our app, `migrations`.

```
.
├── README.md
├── app
│   ├── __init__.py
│   ├── models
│   │   └── model.py
│   └── routes.py
├── app.py
├── migrations
│   ├── README
│   ├── alembic.ini
│   ├── env.py
│   ├── script.py.mako
│   └── versions
└── requirements.txt
```

### Generate Migrations After Each Model Change

After any change to any models, we will need to generate migration files.

### Apply Migrations After Each Model Change

After any new migration files are generated, we will need to apply those migration files. This is commonly known as "running the migrations."
