# Models Setup

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=2d8c558c-d8f9-4fd7-9c15-ad11005fdfd5&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goal

Our goal for this lesson is to provide details for _how_ to setup a model in a Flask app.

This lesson uses the [Hello Books API](https://github.com/AdaGold/hello-books-api). You can review the recommended workflow for this and subsequent lessons in the [Intro to Hello Books](../api-1-setup-read/intro-to-hello-books.md) lesson.

## Branches

| Starting Branch | Ending Branch      |
| --------------- | ------------------ |
| `02b-404`       | `03a-models-setup` |

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

- The `GET` `/books` route should be defined
- The `GET` `/books/<book_id>` route should be defined
- Invalid `book`and non-existing `books` should be handled with a helper function `validate_book`

</details>
<br>

## Removing Hardcoded Data

In a previous lesson we used hardcoded data stored in the variable `books` to learn how to write routes to _read_ all books, and _read_ one book. This was great for learning, but we were limited to _GET_ routes, as we could not persist any changes to our data given that it was hardcoded.

In this lesson, we will learn how to connect our Flask app to a database. This will allow us to not only write routes to _read_ our data, but also _create_, _update_, and _delete_ it!

Before we go any further, let's comment or remove our hardcoded `books` data and our two routes from the `app`.

<details>
    <summary>Expand to see the code to remove or comment.</summary>

```python
# book.py

# class Book:
#     def __init__(self, id, title, description):
#         self.id = id
#         self.title = title
#         self.description = description

# books = [
#     Book(1, "Fictional Book", "A fantasy novel set in an imaginary world."),
#     Book(2, "Wheel of Time", "A fantasy novel set in an imaginary world."),
#     Book(3, "Fictional Book Title", "A fantasy novel set in an imaginary world.")
# ]
```

</details>

We should also comment or remove our code for the `GET /books` and `GET /books/<book_id>` routes. We will refactor these to use our database in the forthcoming **Read All Books** and **Read One Book** lesson.

<details>
    <summary>Expand to see the code to remove or comment.</summary>

```python
# book_routes.py

from flask import Blueprint, abort, make_response
# from app.models.book import books

books_bp = Blueprint("books_bp", __name__, url_prefix="/books")

# @books_bp.get("")
# def get_all_books():
#     books_response = []
#     for book in books:
#         books_response.append(
#             {
#                 "id": book.id,
#                 "title": book.title,
#                 "description": book.description
#             }
#         )
#     return books_response

# @books_bp.get("/<book_id>")
# def get_one_book(book_id):
#     book = validate_book(book_id)

#     return {
#         "id": book.id,
#         "title": book.title,
#         "description": book.description,
#     }

# def validate_book(book_id):
#     try:
#         book_id = int(book_id)
#     except:
#         response = {"message": f"book {book_id} invalid"}
#         abort(make_response(response , 400))

#     for book in books:
#         if book.id == book_id:
#             return book

#     response = {"message": f"book {book_id} not found"}
#     abort(make_response(response, 404))
```

</details>

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

There are a couple steps to creating the database connection. We will:
1. initialize objects to represent our database, and migration tools
2. register these objects with our application and tell Flask where to find our new database in `create_app`

### Set Up the Database and Migrations

To set up our connection with SQLAlchemy, we need to create an instance of `SQLAlchemy` and give it information on how we want to create our database backed models. We do this by passing the SQLAlchemy constructor a class name to use when generating our model classes.

That might sound like a lot of work, but SQLAlchemy provides a class named `DeclarativeBase` which provides all of the operations our database backed models will need. We will make our own `Base` model class that is a subclass of `DeclarativeBase`. 

While we will not dive further into customizing our `Base` class in this series, creating our own `Base` class means that we could further tailor the behavior of our model classes, adding operations that we want available to all models. 

Following the pattern of creating a file for every model, we can create a file for `Base` in our `models` folder:

```bash
$ touch app/models/base.py
```

Let's take a look at the code for our `Base` class before copying it over to our new file:

```py
from sqlalchemy.orm import DeclarativeBase

class Base(DeclarativeBase):
    pass
```

Our code here is short, with our only actions being to 
1. import the parent class `DeclarativeBase`, and
2. create an empty subclass `Base` that we can give to our SQLAlchemy constructor.

With our `Base` model in hand, we can create a new file in the `app` folder `db.py` which will manage creating our database and migration objects:

```bash
$ touch app/db.py
```

Let's look over the contents for `db.py` before copying it to our local file:

```py
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from .models.base import Base

db = SQLAlchemy(model_class=Base)
migrate = Migrate()
```

Then we can update our `db.py` to contain the same code.

The file above does a few things:

1. First we import `SQLAlchemy`, `Migrate`, and our newly created `Base` class
2. Next, we create an instance of SQLAlchemy that we will call `db` and pass it our `Base` class as the constructor argument. We will use the `db` object when we need to interact with the database to perform operations like creating or updating records.
3. Last, we make an instance of Migrate. We will not directly interact with this object much, but this object will be used by the application to update our database tables when we make changes to our model class's attributes. 

At this point, our project structure should look similar to this:

```
.
├── app
│   ├── models
│   │   ├── __init__.py
│   │   ├── base.py
│   │   └── book.py
│   ├── routes
│   │   ├── __init__.py
│   │   └── book_routes.py
│   ├── __init__.py
│   └── db.py
├── README.md
└── requirements.txt
```

### Configure the Database in `app/__init__.py`

To finish configuring the database, we will make 2 changes to `create_app`:
- Supply a _connection string_ to tell Flask where to find our new database
- import the `db` and `migrate` objects we created and use their `init_app` methods to register them with our `app`

When we need to tell Flask where to find a database, we do this by providing a _connection string_ that identifies where it is, and how to connect to it.

The required format of a connection string can vary depending on the library being used to communicate with the database. The packages we are using (SQLAlchemy and psycopg2) structure their connection strings to look like a URL. Consider the example connection string shown here.

```
postgresql+psycopg2://postgres:postgres@localhost:5432/REPLACE_THIS_LAST_PART_WITH_DB_NAME
```

This tells Flask to connect to our database using the `psycopg2` package we installed from our `requirements.txt`. It connects using the `postgres` protocol using the `postgres` user on the local machine (`localhost`) running at port `5432`.

The text `REPLACE_THIS_LAST_PART_WITH_DB_NAME` should be replaced with our database's name, `hello_books_development`.

Let's examine the following code, which configures the database to use SQLAlchemy appropriately for our app.

```python
from flask import Flask
from .db import db, migrate
from .routes.book_routes import books_bp

def create_app():
    app = Flask(__name__)

    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development'

    db.init_app(app)
    migrate.init_app(app, db)

    # Register Blueprints here
    app.register_blueprint(books_bp)

    return app
```

Then, we can edit our `app/__init__.py` file so it looks identical.

On a high-level, this code does the following:

1. Imports the `db` and `migrate` objects we created previously
2. Configures the `app` to include two new SQLAlchemy settings
   1. We set `app.config['SQLALCHEMY_TRACK_MODIFICATIONS']` to `False` to hide a warning about a feature in SQLAlchemy that we won't be using.
   2. We set `app.config['SQLALCHEMY_DATABASE_URI']` to the connection string for our database, `hello_books_development`
3. Connects `db` and `migrate` to our Flask `app`, using the package's recommended syntax. The `app.config` values must be set before this step, since SQLAlchemy is going to look for those keys during this step.

## Defining the Model

With our database connection made, we can move over to the existing `book.py` file and begin our updates to create a database backed `Book` model!

### Our Models Are Classes That Inherit From `db.Model`

SQLAlchemy provides a pattern for creating a class for our model that will:

1. Connect the model seamlessly with our SQL database, mapping attributes to table columns
2. Give our Flask code the ability to work with `Book` instances, taking advantage of OOP
3. Enable us to access instances of `Book`, where each instance corresponds to a row in our database

```python
from sqlalchemy.orm import Mapped, mapped_column
from ..db import db

class Book(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    title: Mapped[str]
    description: Mapped[str]
```

### !callout-info

## Be Aware of Changes to SQLAlchemy When Looking at Older Examples

SQLAlchemy has changed over the years, both in syntax and in meaning. The current syntax borrows from Python's type hinting system to make the column declarations more concise, as well as to make it easier for tools to check our code for errors. Additionally, some behaviors that used to be the default must now be set explicitly.

<br />

Recall that SQL permits us to define columns that allow NULL values. In the past, SQLAlchemy would default to allowing NULL values for all columns unless otherwise marked. In the current version, columns using `Mapped` types as above, that are not explicitly marked `Optional`, are considered non-nullable; they are required attributes when creating a new instance of a model.

<br />

As an example, to mark a text column as nullable, we would need to add `Optional` to the type hint, written as `Mapped[Optional[str]]`.

### !end-callout

We still have a `Book` class, and there are still references to names like `id`, `title`, and `description`, though they no longer appear as part of a constructor. In fact, we no longer see an explicit constructor at all! SQLAlchemy will provide one for us through inheritance. Inheritance from what? Take a moment to consider what this syntax indicates `class Book(db.Model):`

<details>

<summary>Take a moment to consider what this syntax indicates: <code>class Book(db.Model):</code>, and then click here.</summary>

The class `Book` inherits from `db.Model` from `SQLAlchemy`. Because we passed our `Base` model class to the SQLAlchemy constructor, when we refer to `db.Model`, under the hood it is using the `Base` class we created, which itself gets its behaviors from the SQLAlchemy `DeclarativeBase` class.

</details>

| <div style="min-width:250px;"> Piece of Code </div> | Notes|
| --------------------------------------------------- | ---- |
| `from sqlalchemy.orm import Mapped, mapped_column` | This file needs access to SQLAlchemy's tools for defining table columns in a model |
| `from ..db import db` | This file needs access to the SQLAlchemy `db` |
| `class Book(...)` | We define a new class, and name it after our model (usually singular). By default, SQLAlchemy will use the lowercase version of this class name as the name of the table it will create. |
| `db.Model` | Our model inherits from `db.Model`. This type is provided by the Flask SQLAlchemy extension, which we used to create our `db` instance. Through inheritance, it leads back to our `Base` model class, and the SQLAlchemy `DeclarativeBase` class. In some situations, we may need to consult the the SQLAlchemy documentation for more details about `DeclarativeBase`. |
| `id: Mapped[int] = mapped_column(...)` | Instances of `Book` will have an attribute `id`, which will map to a database column of type int. Notice that this attribute goes outside of any instance method and doesn't reference `self`. This is part of the pattern that models deriving from `db.Model` will follow, even though it's a little different from a typical Python class. |
| `primary_key=True, autoincrement=True` | Keyword arguments that allow SQLAlchemy to understand how to fill in the values for new `Book` instances. Notice how they resemble SQL constraints that can be applied to a column. |
| `title: Mapped[str]` | Creates a required `title` attribute, which will map to a string column, `title` |
| `description: Mapped[str]` | Creates a required `description` attribute, which will map to a string column, `description` |

Congratulations! We've defined our first Flask model!

### !callout-info

## SQLAlchemy Has More Options to Configure

There are plenty of more options for configuring our model. We can define more columns of more types, and even create plenty of great helper functions! Follow your curiosity!

### !end-callout

### !callout-secondary

## Specifying the Table Name

In model definitions, if we don't like the default name that SQLAlchemy picks we can specify a different name for the table, using the `__tablename__` property. There is more to research here!

### !end-callout

### Ensuring the `Book` Model is Visible to `Alembic` 

Now that we've defined the `Book` model, we need to make sure our `app` sees it. The most explicit way to ensure the `Book` model is visible is to import the module where it's defined in our project's `__init__.py` file.

![An image of two people dressed as Spiderman pointing at each other. The person on the left is labeled 'app.py', and the person on the right is labeled 'book.py'](../assets/api-3-database-models-read/spiderman_app_book.png)
_Fig. app.py and book.py see each other_

A Python file can "see" the files that are directly imported in it, and it has access to the imports of imports. That means for `__init__.py` to see the `Book` class, we either need:
- `__init__.py` to import the `Book` class directly  
- another import in `__init__.py` to include `Book` as an import

We know that `__init__.py` imports `book_routes.py` so that `create_app` can register the books blueprint. Thinking about the changes we've made in this lesson, `book_routes.py` used to import a variable from `book.py`, but at this point in time the import is commented out. 

This means that we have two choices for making `Book` visible in `__init__.py`:
- uncomment and update the import in `book_routes.py` to import the `Book` class 
- explicitly import `Book` at the top of `__init__.py` 

We will not be using `Book` in `book_routes.py` just yet, so we will prefer to import the `book.py` file at the top of `__init__.py`. 

Feel free to follow your curiosity and try out either flow for imports. Different development teams may have differing opinions on how they want to handle imports, so you may see either pattern in the future–the most important thing is to be consistent across a project. 

Our updated imports in `__init__.py` should look like this:

```python
from flask import Flask
from .db import db, migrate
from .models import book # Newly added import
from .routes.book_routes import books_bp

def create_app():
    ...
```

You may notice that we imported the whole `book.py` file into `__init__.py` with 

```py
from .models import book
```

The `book.py` file only contains our `Book` class, so we aren't bringing anything extra in by importing the entire file. If the file had other contents and we wanted to only make the `Book` class visible, we could import just the class definition with:

```py
from .models.book import Book
```

## Database Migrations

Our model is set up! The remaining actions left are to use our Flask tools to generate the migrations, then apply those migrations to update our database.

Our database development workflow will be as follows:

1. Set up the database on the Flask end once
1. Generate migration files
1. Apply the migration files

### One-Time `init` Setup

Once we have created our database and configured the connection string, we can do this one-time setup command:

```bash
(venv) $ flask db init
```

Example Output:

```bash
(venv) $ flask db init
  Creating directory '/Users/user_name/Documents/hello-books-api/migrations' ...  done
  Creating directory '/Users/user_name/Documents/hello-books-api/migrations/versions' ...  done
  Generating /Users/user_name/Documents/hello-books-api/migrations/script.py.mako ...  done
  Generating /Users/user_name/Documents/hello-books-api/migrations/env.py ...  done
  Generating /Users/user_name/Documents/curriculum_changes/hello-books-api/migrations/README ...  done
  Generating /Users/user_name/Documents/curriculum_changes/hello-books-api/migrations/alembic.ini ...  done
  Please edit configuration/connection/logging settings in
  '/Users/user_name/Documents/hello-books-api/migrations/alembic.ini' before proceeding.
```

The final message in the output `"Please edit configuration..."` is just a recommendation. We will not be discussing logging data about our API as part of this series, so we do not need to take any action with the listed file. Once we see this message we are ready to keep moving forward!

### Generate Migrations After Each Model Change

We can generate database migrations with the following command. This command should be run any time we alter the attributes that our model classes store in the database.

```bash
(venv) $ flask db migrate -m "adds Book model"
```

Example Successful Output:

```bash
(venv) $ flask db migrate -m "adds Book model"
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.autogenerate.compare] Detected added table 'book'
  Generating /Users/user_name/Documents/hello-books-api/migrations/versions/bf0d3269e52e_adds_book_model.py ...  done
```

Notice that just like when we make `git` commits, here too we can record a message summarizing the changes we have made. When running this command ourselves, we should replace the `"adds Book model"` with a description relevant to our recent changes.

When the migrate command is successful, we should see something similar to the last 2 lines:
```bash
INFO  [alembic.autogenerate.compare] Detected added table 'book'
  Generating /Users/user_name/Documents/hello-books-api/migrations/versions/bf0d3269e52e_adds_book_model.py ...  done
```
where an `INFO` line calls out the detected change, followed by a final line describing where the new migration file is being created.

If we haven't made any changes to our models that require the database to be modified, or if some other issue is preventing the migration tool from seeing changes, we will often see an `INFO` message at the end of the output stating  `"No changes in schema detected"`:

Example Error Output:

```bash
(venv) $ flask db migrate -m "adds Book model"
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.ddl.postgresql] Detected sequence named 'book_id_seq' as owned by integer column 'book(id)', assuming SERIAL and omitting
INFO  [alembic.env] No changes in schema detected.
```
If no change is detected, we should reflect on whether any recent model changes would require the database to be updated. For instance, if we add a helper method to a model class, only our code is affected, it doesn't change the data stored in the database. In that case, generating a migration isn't necessary, and if we try to do so, no changes will be detected. 

However, if we added a new attribute to our model, that _does_ need to update the database. We need to generate a migration to tell the database to create a new column for the new attribute. If generating a migration in that case detects no changes, we'll need to do more research to determine the issue.
	
### !callout-info

## Database Migration Issues 

Migrations can be a bit finicky to keep in sync, especially when multiple people are working on a project. We need to be careful about coordinating who is creating migrations and ensuring they are shared with the team to keep everyone's development database in sync. 

<br/>

We won't have the opportunity to invest much time in troubleshooting migrations during this series, but a common resolution can be to clear out the database and generate a fresh set of migrations. More details on how to do this are described in the "Resolving Schema Conflicts" reading a bit later on.

### !end-callout
### Migrations Are Just Python Code

A neat side-effect about generating migrations is that we get to appreciate the migration files themselves. The generated migrations are placed in the `versions` folder of the `migrations` directory that was created with the `flask db init` command!


```
.
├── app
│   ├── models
│   │   ├── __init__.py
│   │   ├── base.py
│   │   └── book.py
│   ├── routes
│   │   ├── __init__.py
│   │   └── book_routes.py
│   ├── __init__.py
│   └── db.py
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

Example Successful Output:

```bash
(venv) $ flask db upgrade
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade  -> bf0d3269e52e, adds Book model
```

As with creating a migration, we want to look at the last line to see if an upgrade is successful. We know an upgrade succeeded when we get an `INFO` message with `"Running upgrade"` followed by the identifier for the current migration our database is using, then the identifier for the migration we are applying. In the output above, we are applying our very first migration to the database so we only see an identifier on the right side.

If no new migrations are found and applied, we would see just the first two `INFO` lines printed, which indicates that no action took place.

This command should be run after every time we've generated new migrations and want to apply them. At this introductory level, there is no reason for us to generate migrations without immediately applying them so we should always run `flask db migrate` and `flask db upgrade` back-to-back in that order.

### Confirm the Migration

We should now be able to connect to our database with `psql` and confirm that the `book` table has been created. Connect to Postgres with:

```
psql -U postgres
```

Once in the Postgres interactive terminal we should: 

1. Run `\c hello_books_development` to connect to the database.
2. List the tables in the database with `\dt` which should show us `book`, and another table called `alembic_version` which tracks our migrations.
3. Display the columns of the `book` table by running `\d book`, which will show `id`, `title`, and `description`.

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

<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: 304e964c-dcdc-463f-8dcb-3b8843857ecd
* title: Models Setup
##### !question

Arrange the commands below in the correct order to set up a database, create a migration, then apply it.

##### !end-question
##### !answer

1. `psql -U postgres`
2. `CREATE DATABASE hello_books_development;`
3. `flask db init`
4. `flask db migrate -m "Migration Description"`
5. `flask db upgrade`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: 459535b6-8a7f-4487-a79e-7ade8fa47884
* title: Models Setup
##### !question

Select all of the options below which could help us troubleshoot if we have an issue connecting to our database

##### !end-question
##### !options

* Run the app and try to make a request to a route
* Check that the database exists locally using `psql`
* Check that the database connection string doesn’t have typos
* Check that `app.config['SQLALCHEMY_TRACK_MODIFICATIONS']` is set to False
* Check that we are setting `app.config['SQLALCHEMY_DATABASE_URI']` in `__init__.py`

##### !end-options
##### !answer

* Check that the database exists locally using `psql`
* Check that the database connection string doesn’t have typos
* Check that we are setting `app.config['SQLALCHEMY_DATABASE_URI']` in `__init__.py`

##### !end-answer
##### !explanation

* Run the app and try to make a request to a route - If the database connection can't be found, often the app will not compile so we cannot use this option.
* Check that the database exists locally using `psql` - We should check if the database exists and create one if it is not present.
* Check that the database connection string doesn’t have typos - If we misspell any part of the connection string, we will not be able to connect to the database.
* Check that app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] is set to False - This setting doesn't affect our ability to reach the database
* Check that we are setting app.config['SQLALCHEMY_DATABASE_URI'] in `__init__.py` - We need to give this dictionary key the value of our database connection string for Flask to know where the database is.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->
