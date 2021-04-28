# dotenv and the Test Database

## Goals

This lesson should serve as a walk-through for refactoring our code to use `python-dotenv`, and for creating a test database for our Hello Books API.

These actions will allow us to set up testing for our API, which in turn will help us create software of higher quality.

## Hello Books API

This lesson uses the [Hello Books API](https://github.com/AdaGold/hello-books-api).

<br />

<details style="max-width: 700px; margin: auto;">
    <summary>
        Before beginning this lesson, the Hello Books API should have the following.
    </summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined

Endpoints defined for these RESTful routes. They can gracefully handle missing books:

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
1. Create a _dotenv_ `.env` file
1. Prevent our `.env` from being committed by using a `.gitignore` file
1. Create environment variables in our `.env` file:
   - URL for a development database
   - URL for a test database
1. Create a test database with the matching name
1. Refactor our `create_app` method to:
   1. Check for a configuration flag
   1. Read the correct database location from `.env`
1. Manually test that our development environment still works

## Manage More Dependencies

The `python-dotenv` package (often referred to as simply "dotenv") is a popular, well-used tool for managing environment variables.

We should ensure that `python-dotenv` is installed by either:

1. Checking our `requirements.txt` and confirming `python-dotenv` is already listed, or
1. Installing it with `(venv) $ pip install python-dotenv`
   - In this case we should also update our `requirements.txt` by running `(venv) $ pip freeze > requirements.txt`

## Create Our `.env` File

The `python-dotenv` package expects to find a file named exactly `.env` in the project root directory.

We should create the `.env` file in our project root either in our code editor, or by running

```bash
$ touch .env
```

in the project root directory.

## Make Git Ignore Our `.env` File

Git is great at tracking our files. But there are some files we don't want Git to track!

We are going to be putting potentially sensitive information into our `.env` file, so we need to tell Git to lay off!

We use a `.gitignore` file to tell Git what to ignore.

### `.gitignore`

The `.gitignore` file is a file that Git uses as a list of files and folders to _automatically never track_.

Every file and folder listed in `.gitignore` will remain _untracked_ by Git. This helps our workflow, as it gives us the confidence that we'll never accidentally commit it to Git history.

### Adding `.env` to `.gitignore`

To make Git ignore our `.env` file, we open `.gitignore` in our text editor and add `.env` to the file on its own line.

In the case that we already have contents in our `.gitignore` file, we can confirm whether `.env` is listed by searching the file. `.env` only needs to be listed once.

## Populate the Environment Variables

`.env` files are made of lines of the form:

```bash
VARIABLE_NAME=variable value
```

| <div style="min-width:175px;"> Piece of Code </div> | Notes                                                                                                                                                                                                              |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `VARIABLE_NAME`                                     | Name of the environment variable to set. Replace `VARIABLE_NAME` with a good name for our environment variable. It's conventional to name environment variables with CAPITAL_CASING, just like constant variables. |
| `=`                                                 | The environment variable name is separated from its value with `=`. We usually _don't_ surround it with spaces.                                                                                                    |
| `variable value`                                    | The value for our environment variable. Surrounding quotes are optional in general, but may be required if we need our value to begin with spaces, since spaces immediately following the `=` are ignored.         |

Beyond those guidelines, we are free to choose the best variable names and values for our project.

For our Hello Books API, we want to designate a path to a development database and a testing database with the variables named `SQLALCHEMY_DATABASE_URI` and `SQLALCHEMY_TEST_DATABASE_URI`.

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
```

Now, let's actually make the test database that we just referred to in our `.env` file!

## Create the Test Database

Just like how we set up the development database, we want to set up our test database in `psql`. Let's start the CLI with `psql -U postgres` and run the following:

```SQL
CREATE DATABASE hello_books_test;
```

That's it! We can exit back to the command shell with `\q`.

## Modify `create_app` to Handle Test Mode

Now that we've set up environment variables and the test database, let's change some configurations in our app to make use of them.

Let's look at a revised version of the `app/__init__.py` file that includes the changes needed to handle test mode. We'll examine the differences following the code.

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

    if not test_config:
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

    from .routes import books_bp
    app.register_blueprint(books_bp)

    return app
```

| <div style="min-width:310px;"> Piece of Code </div> | Notes                                                                                                                                                                                  |
| --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `from dotenv import load_dotenv`                    | The `python-dotenv` package specifies to import the package like this                                                                                                                  |
| `import os`                                         | This built-in module provides a way to read environment variables                                                                                                                      |
| `load_dotenv()`                                     | The `python-dotenv` package specifies to call this method, which loads the values from our `.env` file so that the `os` module is able to see them.                                    |
| `def create_app( ... ):`                            | Add a new keyword parameter to `create_app` that we can use to customize its behavior                                                                                                  |
| `test_config=None`                                  | We have called the new parameter `test_config` which should receive a dictionary of configuration settings. It has a default value of `None`, making the parameter optional.           |
| `if not test_config:`                               | Check the keyword argument `test_config`. When we call `create_app()`, if `test_config` is falsy (`None` or empty), that means we are not trying to run the app in a test environment. |
| `os.environ.get( ... )`                             | This syntax gets an environment variable by the passed-in name                                                                                                                         |
| `"SQLALCHEMY_DATABASE_URI"`                         | This is the exact name of the **development** database environment variable we defined in `.env`                                                                                       |
| `else:`                                             | If there _is_ a `test_config` passed in, this means we're trying to test the app, which can have special test settings                                                                 |
| `app.config["TESTING"] = True`                      | Turns testing mode on                                                                                                                                                                  |
| `os.environ.get( ... )`                             | This syntax gets an environment variable by the passed-in name                                                                                                                         |
| `"SQLALCHEMY_TEST_DATABASE_URI"`                    | This is the exact name of the **testing** database environment variable we defined in `.env`                                                                                           |

### !callout-secondary

## Practical Tip: Reading > Writing

Understanding how to read this code is more valuable than learning how to write it. On many projects, we set up test environments by referring back to code from a previous project. But we should strive to be able to read this code in order to:

- Have a better understanding of how the app runs, which will lead to better debugging
- Get familiar with the process of setting it up, in anticipation of future projects

### !end-callout

## Verify We Didn't Break It: Manually Test Development

We'll test our test environment after we set up tests in the next lessons!

For now, let's verify that we didn't break our development environment. These changes should not have affected our development environment at all!

Let's run our app in development mode with `(venv) $ flask run`, and make some requests in Postman. We can manually test all of our functionality to ensure we haven't introduced any _regressions_, broken scenarios which used to work.
