# dotenv and the Test Database

## Goals

This lesson should serve as a walkthrough for how to refactor our code using dot-env and create a test database in our Hello Books API.

These actions will allow us to practice testing, which in turn creates more high-quality software.

## Hello Books API

This lesson uses the Hello Books API.

<details style="max-width: 700px; margin: auto;">
    <summary>
        Before beginning this lesson, the Hello Books API should have the following.
    </summary>

- A `hello_books_development` database
- A `book` table defined in both databases
- A `Book` model defined

Endpoints defined for these RESTful routes. They handle missing books:

- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`

</details>

## Format

This lesson will go through the following steps:

1. Ensure that `python-dotenv` is installed
1. Create a `.env` file
1. Ensure that `.env` is listed in the `.gitignore` file
1. Name our values:
   - URL for a development database
   - URL for a test database
1. Create a test database with the matching name
1. Refactor our `create_app` method to:
   1. Check for a configuration flag
   1. Reads the correct database location from `.env`
1. Manually test that our development environment still works

## Manage More Dependencies

The `python-dotenv` package (often referred to as "dotenv") is a popular, well-used tool for managing environment variables.

We should ensure that `python-dotenv` is installed by either:

1. Checking our `requirements.txt` and checking if `python-dotenv` is already listed
1. Installing it with `(venv) $ pip install python-dotenv`

## The `.env` File Should Be Ignored

The `python-dotenv` package wants us to:

1. Create a file in the project root named `.env` exactly
1. List this file (`.env`) in the `.gitignore` file

### `.gitignore`

The `.gitignore` file is a file that Git, our version-control system, uses as a list of files and folders to _automatically never track_.

Every file and folder listed in a `.gitignore` will be _untracked_ by Git. This helps our workflow, as it gives us the confidence that we'll never accidentally commit it to Git history.

### Adding `.env` to `.gitignore`

We can list `.env` as another file to ignore.

In the case that we already have a full `.gitignore` file, we can confirm that `.env` is listed by searching the file. `.env` only needs to be listed once.

## Populate the Environment Variables

`.env` files are formatted in the following way:

- Each line is a different environment variable
- Environment variables are named, separated by a `=`, and then given a value (with no spaces or quotes)
  - It's conventional to name environment variables with CAPITAL_CASING, just like constant variables

Beyond those guidelines, we are free to choose the best variable names and values for our project.

For our Hello Books API, we want to designate a path to a development database and a testing database with the variables named `SQLALCHEMY_DATABASE_URI` and `SQLALCHEMY_TEST_DATABASE_URI`.

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
```

Now, let's make the test database that we just named!

## Create the Test Database

Just like how we set up the development database, we want to set up our test database in `psql`.

```SQL
CREATE DATABASE hello_books_test;
```

Let's also create a `book` table in this database.

```SQL
\c hello_books_test
CREATE TABLE book (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(200),
  description TEXT
);
```

## `create_app` Now Handles Test Mode

Now that we've set up environment variables and the test database, let's change some configurations in our app to use this.

Based on the current state of this Flask app, let's look at a replacement for the `app/__init__.py` file, then go through the differences.

```python
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from dotenv import load_dotenv
import os

db = SQLAlchemy()
migrate = Migrate()
load_dotenv()

def create_app(test_config=None):
    app = Flask(__name__)

    if test_config is None:
        app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
        app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get(
            "SQLALCHEMY_DATABASE_URI")
    else:
        app.config["TESTING"] = True
        app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
        app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get(
            "SQLALCHEMY_TEST_DATABASE_URI")

    db.init_app(app)
    migrate.init_app(app, db)

    from app.models.book import Book
    with app.app_context():
        db.create_all()

    from .routes import books_bp
    app.register_blueprint(books_bp)

    return app
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                                                                              |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `from dotenv import load_dotenv`                    | The `python-dotenv` package specifies to import the package like this                                                                                                                                                                                              |
| `import os`                                         | This built-in package will allow us to read the environment variables set in `.env`                                                                                                                                                                                |
| `load_dotenv()`                                     | The `python-dotenv` package specifies to call this method and load the variables before using them                                                                                                                                                                 |
| `if test_config is None:`                           | Create a conditional based on the keyword argument `test_config`. Whenever we call `create_app()`, from now on, we can optionally pass in a test config dictionary. If `test_config` is `None`, that means we are not trying to run the app in a test environment. |
| `os.environ.get( ... )`                             | This syntax gets an environment variable by the passed-in name                                                                                                                                                                                                     |
| `"SQLALCHEMY_DATABASE_URI"`                         | This is the exact name of the **development** database environment variable we defined in `.env`                                                                                                                                                                   |
| `else:`                                             | If there _is_ a `test_config` passed in, this means we're trying to test the app, which can have special test settings                                                                                                                                             |
| `app.config["TESTING"] = True`                      | Turns testing mode on                                                                                                                                                                                                                                              |
| `os.environ.get( ... )`                             | This syntax gets an environment variable by the passed-in name                                                                                                                                                                                                     |
| `"SQLALCHEMY_TEST_DATABASE_URI"`                    | This is the exact name of the **testing** database environment variable we defined in `.env`                                                                                                                                                                       |

### !callout-secondary

## Practical Tip: Reading > Writing

Understanding how to read this code is more valuable than learning how to write it. Realistically, on many projects, test environments are set up. However, it's valuable to read this code in order to:

- Have a better understanding of how the app runs, which will lead to better debugging
- Get familiar with the process of setting it up, in anticipation of future projects

### !end-callout

## Verify We Didn't Break It: Manually Test Development

We'll test our test environment after we set up our ability to run tests!

However, let's verify that we didn't break our development environment. Our development environment should not have changed at all!

Let's run our app in development mode with `(venv) $ flask run`, and make some requests in Postman. We can manually test all of our functionality to ensure we haven't lost anything.
