# Test Setup

## Introduction

We can continue to use tests and pytest to test our Flask APIs! Reading, writing, and using pytest for a Flask API isn't very different from using pytest outside a Flask API.

One main difference is the test setup. In this lesson, we'll configure our Flask projects to use pytest and a test database.

## Hello Books API

This lesson uses the [Hello Books API](https://github.com/AdaGold/hello-books-api).

<details style="max-width: 700px; margin: auto;">
    <summary>
        Before beginning this lesson, the Hello Books API should have the following.
    </summary>

- A `hello_books_development` database
- A `hello_books_test` database
- A `book` table defined in both databases
- A `Book` model defined

An `.env` file that contains:

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
```

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

### !callout-danger

## Read-through First, Repeat Second

We **highly suggest** reading or watching through this lesson fully, before repeating on your own machine.

### !end-callout

### !callout-danger

## Prioritize Familiarity

It may be better to think about this lesson as a resource to be familiar with, rather than commit all new knowledge to memory at once.

### !end-callout

## Navigating Our New `tests` Folder

Create a `tests` folder, and the following files:

- `tests/__init__.py`
- `tests/conftest.py`
- `tests/test_routes.py`

We can do so with the following commands:

```
(venv) $ mkdir tests
(venv) $ touch tests/__init__.py tests/conftest.py tests/test_routes.py
```

Let's consider what these files will do:

| <div style="min-width:250px;">File</div> | Responsibility of this file                                                                                                                   |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `__init__.py`                            | Establishes our `tests` package, so it can be properly connected with the rest of the app folders and files. We will probably leave it empty. |
| `conftest.py`                            | A conventional Flask file that will hold test configurations and common test helper functions                                                 |
| `test_routes.py`                         | This file will hold the tests for the code in our `app/routes.py` file.                                                                       |

## `conftest.py`

Let's briefly cover the contents of a `tests/conftest.py` file, and then copy the contents of it into our own project.

```python
import pytest
from app import create_app
from app import db


@pytest.fixture
def app():
    app = create_app({"TESTING": True})

    with app.app_context():
        yield app

    with app.app_context():
        db.drop_all()


@pytest.fixture
def client(app):
    return app.test_client()
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                       |
| --------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `import pytest`                                     | We'll be utilizing pytest fixtures to set up our test app                                                                                                                                                   |
| `from app import ... db`                            | We should import `create_app` and `db` in order to configure those when running the tests                                                                                                                   |
| `@pytest.fixture`                                   | We'll create and use a pytest fixture named `app`, which will be used in our `client` fixtured (defined below)                                                                                              |
| `app = create_app( ... )`                           | When we run our tests, this line will run and create an `app` object. It's using the same `create_app` function defined in our `app/__init__.py` file!                                                      |
| `{"TESTING": True}`                                 | Here, we're passing in a dictionary to represent a "test config" object. If we check the current implementation of `create_app()` in `app/__init__.py`, it uses this argument only to check if it's truthy. |
| `with app.app_context():`                           | This syntax designates that the following code should have an _application context_, or in this case, have access to objects such as `db`.                                                                  |
| `yield app`                                         | This is pytest fixture syntax which executes the actual test at this moment. `yield app` finishes executing once the test has actually be run.                                                              |
| `with app....: db.drop_all()`                       | After the test runs, this code specifies that we should clear our test database from any data that was saved inside our test.                                                                               |
| `@pytest.fixture`                                   | We're setting up a second test fixture...                                                                                                                                                                   |
| `def client(app):`                                  | This fixture is named `client`. It will request the existing `app` fixture to run, first.                                                                                                                   |
| `return app.test_client()`                          | The responsibility of this fixture is to make a _test client_, which is an object able to _simulate_ a client making HTTP requests.                                                                         |

### !callout-secondary

## Practical Tip: Reading > Writing

Understanding how to read this code is more valuable than learning how to write it. Realistically, on many projects, test environments are set up. However, it's valuable to read this code in order to:

- Have a better understanding of how the app runs, which will lead to better debugging
- Get familiar with the process of setting it up, in anticipation of future projects

### !end-callout

### The `client` Fixture

The majority of our tests will use the `client` fixture that was defined in `tests/conftest.py`.

While we're looking at `tests/conftest.py`, let's see a few ways we'll use `client`:

| Example Usage                      | Description                                                                         |
| ---------------------------------- | ----------------------------------------------------------------------------------- |
| `client.get("my request path")`    | Sends a `GET` request to `"my request path"`. Returns the HTTP response.            |
| `client.post("my request path")`   | Sends a `POST` request to `"my request path"`. Returns the HTTP response.           |
| `client.put("my request path")`    | Sends a `PUT` request to `"my request path"`. Returns the HTTP response.            |
| `client.delete("my request path")` | Sends a `DELETE` request to `"my request path"`. Returns the HTTP response.         |
| `client.put(... , json={ ... })`   | The keyword argument `json` sends the attached dictionary as the HTTP request body. |

In our tests, we will use `client` to send HTTP requests.

The `json` keyword argument is accepted in each of the previously mentioned methods, which is pretty great!

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 9An5OS
* title: Test Setup
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
