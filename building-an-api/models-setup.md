# Models Setup

## Goal

Our goal for this lesson is to provide details for _how_ to setup a model in a Flask app.

## Format

This lesson is a walk-through and syntax explanation for how to build several features inside a Flask API. We **highly recommend** reading or watching through this first fully, before repeating on your own machine.

This lesson has a large amount of new information. It may be better to think about this lesson as a resource to be familiar with, rather than commit all new knowledge to memory at once.

### !callout-danger

## Read-through First, Repeat Second

We **highly suggest** reading or watching through this lesson fully, before repeating on your own machine.

### !end-callout

### !callout-danger

## Prioritize Familiarity

It may be better to think about this lesson as a resource to be familiar with, rather than commit all new knowledge to memory at once.

### !end-callout

## Hello Books API

### Before This Lesson

This lesson uses the [Hello Books API](https://github.com/AdaGold/hello-books-api). Before beginning this lesson, we should have covered:

- Cloning the repo onto our machine
- Creating and activating a virtual environment
- Installing dependencies
- Running the Flask server
- Creating basic endpoints
- Testing those endpoints in Postman

## Creating the Database

Before we work with models in Flask, we need to create a database for our project.

There are no naming rules, but let's give our database a similar name to our project. We'll add in "development" as a descriptor: `hello_books_development`

```SQL
CREATE DATABASE hello_books_development;
```

### Creating the Tables

Similarly, we need to define the tables that will hold the data of our models.

We can name our tables whatever we'd like. However, Flask and SQLAlchemy will automatically look for tables whose names match the model. For example, for our `Book` model, SQLAlchemy will automatically look for the table named `book`. (Table names are not case-sensitive.)

```SQL
\c hello_books_development;
CREATE TABLE book (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(200),
  description TEXT
);
```

### !callout-warning

## Singular Table Names vs. Plural Table Names

Different situations call for different conventions. In this situation, we suggest naming the table with a singular name, `book`. In other situations, we may have suggested using a plural table name, `books`. If we want to specify that the table name is `books`, there is additional code we need to write (detailed below). However, otherwise, this guide will recommend that we use `book`, and other singular table names with Flask.

### !end-callout

## Connecting the DB and Flask

The following is one of many formats to help locate our database. We choose this format because it will benefit some future setup instructions we have later.

```
postgresql+psycopg2://postgres:postgres@localhost:5432/REPLACE_THIS_LAST_PART_WITH_DB_NAME
```

The text `REPLACE_THIS_LAST_PART_WITH_DB_NAME` should be replaced with our database's name, `hello_books_development`.

### Configure the DB in `app/__init__.py`

Read through this code that configures the DB to use SQLAlchemy appropriately for our app.

```python
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()


def create_app(test_config=None):
    app = Flask(__name__)

    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development'

    db.init_app(app)
    migrate.init_app(app, db)

    return app
```

Then, align your `app/__init__.py` file so it looks identical.

On a high-level, this code does the following:

1. Imports and sets up the packages SQLAlchemy and Migrate (a companion package to SQLAlchemy)
1. Sets up `db` and `migrate`, which are conventional variables that give us access to database operations
1. Configures the `app` to include two new SQLAlchemy settings
   1. We set `app.config['SQLALCHEMY_DATABASE_URI']` to the pathway to our database, `hello_books_development`
1. Connects `db` and `migrate` to our Flask `app`, using the package's recommended syntax

## Defining the Model

Following the pattern of creating a file for every model, we can execute these commands:

```bash
$ mkdir app/models
$ touch app/models/book.py
```

Our current project structure likely looks similar to this:

```
.
├── README.md
├── app
│   ├── __init__.py
│   ├── models
│   │   └── book.py
│   └── routes.py
└── requirements.txt
```

### Models are Classes that Inherit `db.Model`

Now, inside of `app/models/book.py`, we can define the `Book` model. SQLAlchemy provides a pattern for creating a class for our model that will:

1. Connect the model seamlessly with our SQL database, mapping attribute to table column
1. Give our Flask code the ability to work with `Book` instances, taking advantage of OOP

```python
from app import db


class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String)
    description = db.Column(db.String)
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                   |
| --------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `from app import db`                                | This file needs access to the SQLAlchemy `db`                                                                           |
| `class Book(...)`                                   | We define a new class, and name it after our model (usually singular)                                                   |
| `db.Model`                                          | Our model will inherit `db.Model`, so if we need to look up documentation, we can start with SQLAlchemy's `Model` class |
| `id = db.Column(...)`                               | Instances of `Book` will have an attribute `id`, which maps to a database column                                        |
| `db.Integer`                                        | A column data-type that SQL Alchemy defines. The `id` column accepts integers.                                          |
| `primary_key=True, autoincrement=True`              | Keyword arguments that allow SQLAlchemy to understand how to fill in the values for new `Book` instances                |
| `title = db.Column(db.String)`                      | Creates a `title` attribute, which maps to the string column, `title`                                                   |
| `description = db.Column(db.String)`                | Creates a `description` attribute, which maps to the string column, `description`                                       |

Congratulations on defining your first Flask model!

### !callout-info

## SQLAlchemy Has More Options to Configure

There are plenty of more options for configuring our model. We can define more columns of more types, and even create plenty of great helper functions! Follow your curiosity!

### !end-callout

### !callout-secondary

## Specifying the Table Name

In this model definition, we can specify the name of the table, using the `__tablename__` property. There is more to research here!

### !end-callout

### Configuring the `Book` Model in `__init__.py`

Now that we've defined `Book`, we need to make sure our `app` sees it. During the configuration step, we need to import `Book` and connect it to our SQLAlchemy `db`.

In `__init__.py`, we'll modify the `create_app()` function.

There is new code after `db` and `migrate` are initialized, but before the `return app` statement. This code essentially connects the Flask `app` and the SQLAlchemy `db` to see each other.

```python
def create_app(test_config=None):
    # app = Flask(__name__)
    # ... app is configured with SQLAlchemy settings
    # ... db and migrate are initialized with app

    from app.models.book import Book
    with app.app_context():
        db.create_all()

    return app
```

If we ever design any more models, we'll need to import the new model here too, mimicking the pattern of `from app.models.book import Book`.

## Database Migrations

Everything is set up! The remaining actions left are to use our Flask tools to generate migrations.

Our database development workflow will be as follows:

1. Set up the db on the Flask end once
1. Generate migration files
1. Apply the migration files

### One-Time `init` Setup

After the first time that a database and at least one table are setup, we can do this one-time setup command:

```bash
(venv) $ flask db init
```

### Generate Migrations After Each Model Change

We can generate database migrations with the following command. This command should be run every time there's a change to a file in the `models` folder.

```bash
(venv) $ flask db migrate
```

A neat side-effect about generating migrations is that we get to appreciate the migration files. The generated migrations are placed in a new folder now, the `migrations` folder!

```
.
├── README.md
├── app
│   ├── __init__.py
│   ├── models
│   │   └── book.py
│   └── routes.py
├── migrations
│   ├── README
│   ├── alembic.ini
│   ├── env.py
│   ├── script.py.mako
│   └── versions
└── requirements.txt
```

At the introductory level of Flask, it's unlikely that we will touch many of the files in the `migrations` folder.

### Apply Migrations AFter Each Model Change

We need to run this separate command to actually run and apply the generated migrations:

```bash
(venv) $ flask db upgrade
```

This command should be run after every time we've generated new migrations and want to apply them.

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 5MOyCI
* title: Models Setup
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
