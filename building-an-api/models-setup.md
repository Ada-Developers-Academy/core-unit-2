# Models Setup

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=2d8c558c-d8f9-4fd7-9c15-ad11005fdfd5&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goal

Our goal for this lesson is to provide details for _how_ to setup a model in a Flask app.

## Format

This lesson is a walk-through and syntax explanation for how to build several features inside a Flask API. We **highly recommend** reading or watching through this first fully, before repeating on your own machine.

This lesson has a large amount of new information. It may be better to think about this lesson as a resource to be familiar with, rather than committing all the new knowledge to memory at once.

### !callout-danger

## Read-through First, Repeat Second

We **highly suggest** reading or watching through this lesson fully, before repeating on your own machine.

### !end-callout

### !callout-danger

## Prioritize Familiarity

It may be better to think about this lesson as a resource to be familiar with, rather than committing all the new knowledge to memory at once.

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

## Removing Hardcoded Data

In a previous lesson we used hardcoded data stored in the variable `BOOKS` to learn how to write routes to *read* all books, and *read* one book. This was great for learning, but we were limited to *GET* routes, as we could not persist any changes to our data given that it was hardcoded. 

In this lesson, we will learn how to connect our Flask app to a database. This will allow us to not only write routes to *read* our data, but also *create*, *update*, and *delete* it!

Before we go any further, let's remove our hardcoded `BOOKS` data from the `app`. 

This is the code to remove:

```python
# app.py
class Book:
    def __init__(self, id, title, description):
        self.id = id
        self.title = title
        self.description = description

BOOKS = [
    Book(),
    Book(),
    Book()
    ]
```

## Creating the Database

Before we work with models in Flask, we need to create a database for our project.

Flask doesn't define any particular naming rules, but let's give our database a similar name to our project. We'll add in "development" as a descriptor: `hello_books_development`

We can startup the Postgres interactive terminal as the user named `postgres` with the following command:

```
psql -U postgres
```

and then create our database by running:

```SQL
CREATE DATABASE hello_books_development;
```

We should get a `CREATE DATABASE` confirmation message from Postgres to indicate the database has been created. We can run `\l` to list the databases, which should also show us our new database. Then we can quit the Postgres terminal with `\q`.

## Connecting the Database and Flask

We need to tell Flask where to find our new database. We do this by supplying a _connection string_ that identifies where it is, and how to connect to it.

A connection string resembles the following:

```
postgresql+psycopg2://postgres:postgres@localhost:5432/REPLACE_THIS_LAST_PART_WITH_DB_NAME
```

This tells Flask to connect to our database using the `psycopg2` package we installed from our `requirements.txt`. It connects using the `postgres` protocol using the `postgres` user on the local machine running at port `5432`.

The text `REPLACE_THIS_LAST_PART_WITH_DB_NAME` should be replaced with our database's name, `hello_books_development`.

### Configure the Database in `app/__init__.py`

We can examine this code, which configures the database to use SQLAlchemy appropriately for our app.

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

Then, we can edit our `app/__init__.py` file so it looks identical.

On a high-level, this code does the following:

1. Imports and sets up the packages SQLAlchemy and Migrate (a companion package to SQLAlchemy)
1. Sets up `db` and `migrate`, which are conventional variables that give us access to database operations
1. Configures the `app` to include two new SQLAlchemy settings
   1. We set `app.config['SQLALCHEMY_TRACK_MODIFICATIONS']` to `False` to hide a warning about a feature in SQLAlchemy that we won't be using.
   1. We set `app.config['SQLALCHEMY_DATABASE_URI']` to the connection string for our database, `hello_books_development`
1. Connects `db` and `migrate` to our Flask `app`, using the package's recommended syntax

## Defining the Model

Following the pattern of creating a file for every model, we can create a file for `Book`:

```bash
$ touch app/models/book.py
```

Our current project structure likely looks similar to this:

```
.
├── app
│   ├── models
│   │   ├── __init__.py
│   │   └── book.py
│   ├── __init__.py
│   └── routes.py
├── README.md
└── requirements.txt
```

### Models Are Classes That Inherit From `db.Model`

Now, inside of `app/models/book.py`, we can define the `Book` model. SQLAlchemy provides a pattern for creating a class for our model that will:

1. Connect the model seamlessly with our SQL database, mapping attributes to table columns
1. Give our Flask code the ability to work with `Book` instances, taking advantage of OOP
1. Enable us to access instances of `Book`, where each instance corresponds to a row in our database

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
| `class Book(...)`                                   | We define a new class, and name it after our model (usually singular). By default, SQLAlchemy will use the lowercase version of this class name as the name of the table it will create.                                                   |
| `db.Model`                                          | Our model will inherit from `db.Model`, so if we need to look up documentation, we can start with SQLAlchemy's `Model` class |
| `id = db.Column(...)`                               | Instances of `Book` will have an attribute `id`, which will map to a database column. Notice that this attribute goes outside of any instance method and doesn't reference `self`. This is part of the pattern that models deriving from `db.Model` will follow, even though it's a little different from a typical Python class.                                      |
| `db.Integer`                                        | A column data-type that SQL Alchemy defines. The `id` column stores integers.                                          |
| `primary_key=True, autoincrement=True`              | Keyword arguments that allow SQLAlchemy to understand how to fill in the values for new `Book` instances. Notice how they resemble constraints that can be supplied to a column.                |
| `title = db.Column(db.String)`                      | Creates a `title` attribute, which will map to a string column, `title`                                                   |
| `description = db.Column(db.String)`                | Creates a `description` attribute, which will map to a string column, `description`                                       |

Congratulations! We've defined our first Flask model!

### !callout-info

## SQLAlchemy Has More Options to Configure

There are plenty of more options for configuring our model. We can define more columns of more types, and even create plenty of great helper functions! Follow your curiosity!

### !end-callout

### !callout-secondary

## Specifying the Table Name

In model definitions, if we don't like the default name that SQLAlchemy picks we can specify a different name for the table, using the `__tablename__` property. There is more to research here!

### !end-callout

### Making the `Book` Model Visible to the `app` in `__init__.py`

Now that we've defined `Book`, we need to make sure our `app` sees it. To do so, we need to import `Book` during the `app` startup.

In `__init__.py`, we'll modify the `create_app()` function.

Notice the new `import` code after `db` and `migrate` are initialized, but before the `return app` statement. This code ensures that the `Book` model will be available to the `app` when we update our database in a moment.

```python
def create_app(test_config=None):
    # app = Flask(__name__)
    # ... app is configured with SQLAlchemy settings
    # ... db and migrate are initialized with app

    from app.models.book import Book

    return app
```

If we ever design any more models, we'll need to import the new model here too, mimicking the pattern of `from app.models.book import Book`.

### !callout-warning

## Sometimes Imports Don't Go at the Top

Generally we prefer to put `import` statements at the top of our files. However, doing so here would result in an error called a _circular import error_. There are a number of ways to avoid this error, but by far the most straight-forward way is to place this `import` inside a function so that it doesn't run until the function gets called.

<br />

Sometimes we need to bend what we consider to be a best practice to address an immediate situation.

### !end-callout

## Database Migrations

Our model is set up! The remaining actions left are to use our Flask tools to generate the migrations that we'll be able to use to update our database.

Our database development workflow will be as follows:

1. Set up the database on the Flask end once
1. Generate migration files
1. Apply the migration files

### One-Time `init` Setup

Once we have created our database and configured the connection string, we can do this one-time setup command:

```bash
(venv) $ flask db init
```

### Generate Migrations After Each Model Change

We can generate database migrations with the following command. This command should be run every time there's a change to a file in the `models` folder.

```bash
(venv) $ flask db migrate -m "adds Book model"
```

Notice that just like when we make `git` commits, here too we can record a message summarizing the changes we have made. When running this command ourselves, we should replace the `"adds Book model"` with a description relevant to our recent changes.

A neat side-effect about generating migrations is that we get to appreciate the migration files. The generated migrations are placed in a new folder now, the `migrations` folder!

```
.
├── app
│   ├── models
│   │   ├── __init__.py
│   │   └── book.py
│   ├── __init__.py
│   └── routes.py
├── migrations
│   ├── alembic.ini
│   ├── env.py
│   ├── README
│   ├── script.py.mako
│   └── versions
├── README.md
└── requirements.txt
```

At the introductory level of Flask, it's unlikely that we will touch many of the files in the `migrations` folder.

### Apply Migrations After Each Model Change

We need to run this separate command to actually run and apply the generated migrations:

```bash
(venv) $ flask db upgrade
```

This command should be run after every time we've generated new migrations and want to apply them. At this introductory level, there is no reason for us to generate migrations without immediately applying them so we should always run `flask db migrate` and `flask db upgrade` back-to-back in that order.

### Confirm the Migration

We should now be able to connect to our database with `psql` and confirm that the `book` table has been created. Connect to Postgres with:

```
psql -U postgres
```

Once in the Postgres interactive terminal we can run `\c hello_books_development` to connect to the database. We can list the tables in the database with `\dt` which should show us `book`, and another table called `alembic_version` which tracks our migrations. We can display the columns of the `book` table by running `\d book`, which will show `id`, `title`, and `description`.

Congratulations! We've created our first Flask model table!

### !callout-warning

## Singular Table Names vs. Plural Table Names

Different situations call for different conventions. Notice that SQLAlchemy used the name `book` for the table. Previously, we have suggested using plural table names, like `books`.

<br />

Traditional database practice often uses plural names for tables, since conceptually a table holds many records. A `books` table would hold many book records. However, class names usually use singular names, since they are a description for a single instance of our type. So we make a `Book` class rather than a `Books` class. For simplicity, SQLAlchemy uses this class name for the table name.

<br />

We could tell SQLAlchemy that we would rather use a table name of `books`. There is only a small amount of additional code we would need to write. But then our class and table names wouldn't match, which could lead to confusion. As a result, we will recommend that we use `book`, and other singular table names with Flask. We should be ready to adapt our practices to the context in which we are operating. Even though database tables are often plural, sometimes they will be singular!

### !end-callout

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
