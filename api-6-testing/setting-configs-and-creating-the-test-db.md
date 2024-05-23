# Setting Configurations & Creating the Test Database

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=57fb6d03-b718-4f99-9d37-ad1d0158d396&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goals

Our goals for this lesson are to:

- Refactor our `create_app` function to read from a `.env` file and accept configuration settings
- Create the test database for `hello-books-api`

We will complete the following steps:

1. Create a `.env` file
2. Prevent our `.env` from being committed by using a `.gitignore` file
3. Create environment variables in our `.env` file:
   - URL for a development database
   - URL for a test database
4. Create a test database with the matching name
5. Refactor our `create_app` method to:
   1. Check for a configuration dictionary
   2. Read the correct database location from `.env`
6. Manually test that our development environment still works

These actions will allow us to set up testing for our API, which in turn will help us create higher quality software.

## Branches

| Starting Branch    | Ending Branch       |
| ------------------ | ------------------- |
| `05a-query-params` | `06a-test-database` |

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined
- `POST` `/books` route defined
- `GET` `/books` route defined
- `GET` `/books/<book_id>` route defined
- `PUT` `/books/<book_id>` route defined
- `DELETE` `/books/<book_id>` route defined
- Invalid <code>book_id</code> and non-existing `book`s handled with `validate_book` helper function

</details>
<br>

## Create Our `.env` File

It is a common practice to name our environment files `.env` and place them in the root directory. Later in this series we will be using a tool that requires this exact set up, so we should create the `.env` file in our project root either in our code editor, or by running

```bash
$ touch .env
```

in the project root directory.

## Make Git Ignore Our `.env` File

Git is great at tracking our files. But there are some files we don't want Git to track!

We are going to be putting potentially sensitive information into our `.env` file, so we need to tell Git to lay off!

We use a `.gitignore` file to tell Git what to ignore.

### `.gitignore`

The `.gitignore` file contains a list of files and folders that Git will _automatically never track_.

Every file and folder listed in `.gitignore` will remain _untracked_ by Git. This helps our workflow, as it gives us the confidence that we'll never accidentally commit a file listed in `.gitignore` to our Git history.

### Adding `.env` to `.gitignore`

To make Git ignore our `.env` file, we open `.gitignore` in our text editor and add `.env` to the file on its own line.

In the case that we already have contents in our `.gitignore` file, we can confirm whether `.env` is listed by searching the file. `.env` only needs to be listed once.

## Populate the Environment Variables

`.env` files are made of lines of the form:

```bash
VARIABLE_NAME=variable value
```

| <div style="min-width:175px;"> Piece of Code </div> | Notes |
| --------------------------------------------------- | ----- |
| `VARIABLE_NAME`                                     | Name of the environment variable to set. Replace `VARIABLE_NAME` with a good name for our environment variable. It's conventional to name environment variables with CAPITAL_CASING, just like constant variables. |
| `=`                                                 | The environment variable name is separated from its value with `=`. We usually _don't_ surround it with spaces. |
| `variable value`                                    | The value for our environment variable. Surrounding quotes are optional in general, but may be required if we need our value to begin with spaces, since spaces immediately following the `=` are ignored. |

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

Now that we've set up environment variables and the test database, let's give our app the ability to handle different kinds of configurations.

Let's look at a revised version of the `app/__init__.py` file which includes the changes needed to handle running our app in another mode, such as testing. We'll examine the differences following the code.

```python
from flask import Flask
from .db import db, migrate
from .models import book
from .routes.book_routes import books_bp
import os

def create_app(config=None):
    app = Flask(__name__)

    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('SQLALCHEMY_DATABASE_URI')

    if config:
        # Merge `config` into the app's configuration
        # to override the app's default settings
        app.config.update(config)

    db.init_app(app)
    migrate.init_app(app, db)

    # Register Blueprints here
    app.register_blueprint(books_bp)

    return app
```

| <div style="min-width:310px;"> Piece of Code </div> | Notes |
| --------------------------------------------------- | ----- |
| `import os`                                         | This built-in module provides a way to read environment variables. |
| `def create_app( ... ):`                            | Add a new keyword parameter to `create_app` that we can use to customize its behavior. |
| `config=None`                                       | We have called the new parameter `config` which should receive a dictionary of configuration settings. It has a default value of `None`, making the parameter optional. |
| `os.environ.get( ... )`                             | This syntax gets an environment variable by the name passed in to the `get(...)` method. |
| `"SQLALCHEMY_DATABASE_URI"`                         | This is the exact name of the **development** database environment variable we defined in `.env`. By default, `app.config['SQLALCHEMY_DATABASE_URI']` will be set to the value we gave this variable in the `.env` file. |
| `if config:`                                        | Check the keyword argument `config`. When we call `create_app()`, if `config` is truthy (is not `None` or empty), that means we want to merge the passed configuration `config` with our default settings in `app.config`. We do this to overwrite defaults-like the database connection string-to set up our app for different environments. |
| `app.config.update(...)`                            | Use the contents of the dictionary passed to `update(...)` to add or overwrite key/value pairs in the app settings dictionary `app.config` |

Something to note is that we are _not_ explicitly setting up our test environment in the `create_app` function. We never even reference our test database connection string! 

What we _are_ doing is making our `create_app` function more flexible, so that we can hand it a configuration for any environment. As a best practice, we want to keep our testing code out of our production code as much as possible, and this is one way to help accomplish that goal. In the following lessons we will create specific files for our test configuration then will see how to call `create_app` and pass it a configuration dictionary with the settings we need for testing.

### !callout-secondary

## Practical Tip: Reading > Writing

Understanding how to read this code is more valuable than learning how to write it. On many projects, we set up test environments by referring back to code from a previous project. But we should strive to be able to read this code in order to:

- Have a better understanding of how the app runs, which will lead to better debugging
- Get familiar with the process of setting it up, in anticipation of future projects

### !end-callout

## Verify We Didn't Break It: Manually Test Development

We'll confirm that our test environment works after we set up tests in a following lesson!

For now, let's verify that we didn't break our development environment. These changes should not have affected our development environment, so we want to ensure all of our routes still operate as-expected.

Let's run our app in development mode with `(venv) $ flask run --debug`, and make some requests in Postman. We can manually test all of our functionality to ensure we haven't introduced any _regressions_, broken scenarios which used to work.

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: e2feff93-0b6d-48a8-a397-c824e450045e
* title: Setting Configurations & Creating the Test Database
##### !question

Select all of the options below which are true about `.env` files:

##### !end-question
##### !options

a| They provide a centralized place to manage and organize various parameters that our project needs. 
b| They allow us to remove sensitive data from being hard coded into our project.
c| They handle changing environments for our project automatically.
d| They allow us to change variables locally without changing our source code.

##### !end-options
##### !answer

a|
b|
d|

##### !end-answer
##### !explanation

1. True 
2. True
3. False: We still need to create mechanisms that allow us to tell our project which details to use from the `.env` file, such as we did in `create_app`.
4. True

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: ba5235ca-41df-4f1f-880d-47bb8b80c030
* title: Setting Configurations & Creating the Test Database
##### !question

Select all of the statements below which are true about why we want to use a `.gitignore` file to prevent us from tracking certain files or file types:

##### !end-question
##### !options

a| Protect secrets like API keys in configuration files from being leaked.
b| Prevent pushing up local settings that don’t apply to other users.
c| Prevent automatically generated files from tools or the computer’s filesystem that do not belong to a project from being committed.
d| Keep a project’s git repository easier to navigate since only relevant project files can be committed. 

##### !end-options
##### !answer

a|
b|
c|
d|

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->