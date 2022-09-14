# Test Setup

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=c47ab167-1113-4ff7-b688-ae880120780f&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goals

Our goals for this lesson are to:
- Build on our pytest knowledge to test our Flask APIs
- Configure our `hello-books-api` to use pytest and a test database 

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`06a-test-database` |`06b-test-setup`|

<details>
   <summary>Expand to see the new test related features <code>Hello Books API</code> should have before this lesson</summary>

* A `hello_books_test` database
* A `.env` file that contains:

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
```

</details>
<br>

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

Let's take a look at what these files will do:

| <div style="min-width:250px;">File</div> | Responsibility of this file                                                                                                                   |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `__init__.py`                            | Establishes our `tests` package, so it can be properly connected with the rest of the app folders and files. We will leave it empty, as we typically do. |
| `conftest.py`                            | A standard pytest file that holds test configurations and common test helper functions. Essentially, this file is run before any other test files. This allows fixtures registered here to be available to any other test file.                                                  |
| `test_routes.py`                         | This file will hold the tests for the code in our `app/routes.py` file.                                                                       |

## `conftest.py`

Let's briefly cover the contents of a `tests/conftest.py` file, and then copy the contents of it into our own project.

```python
import pytest
from app import create_app
from app import db
from flask.signals import request_finished


@pytest.fixture
def app():
    app = create_app({"TESTING": True})

    @request_finished.connect_via(app)
    def expire_session(sender, response, **extra):
        db.session.remove()

    with app.app_context():
        db.create_all()
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
|`from flask.signals import request_finished`|We use the `@request_finished` decorator to create a new database session after a request as described below. | 
| `@pytest.fixture`                                   | We'll create and use a pytest fixture named `app`, which will be used in our `client` fixture (defined later)                                                                                              |
| `app = create_app( ... )`                           | When we run our tests, this line will run and create an `app` object. It's using the same `create_app` function defined in our `app/__init__.py` file!                                                      |
| `{"TESTING": True}`                                 | Here, we're passing in a dictionary to represent a "test config" object. The current implementation of `create_app()` in `app/__init__.py` uses this argument only to check if it's truthy (which this is!). |
|`@request_finished.connect_via(app)`| This decorator indicates that the function defined below, `expire_session`, will be invoked after any request is completed |
|`db.session.remove()`| After a request is made in our test, this line creates a new database session so that we can test that changes were persisted in the database. This is particularly relevant for testing the update method. Without this line, when we test that an update was made to a record following a `put` request, the test will only look at the in-memory copy of the updated record. By adding `db.session.remove()`, we make sure the test checks that the update was persisted in the database.
| `with app.app_context():`                           | This syntax designates that the following code should have an _application context_. This lets various functionality in Flask determine what the current running app is. This is particularly important when accessing the database associated with the app.                                                                   |
| `db.create_all()` | At the start of each test, this code recreates the tables needed for our models. |
| `yield app`                                         | This fixture suspends here, returning the app for use in tests or other fixtures. The lines after this `yield` statement will run after the test using the app has been completed.                                                              |
| `with app....: db.drop_all()`                       | After the test runs, this code specifies that we should drop all of the tables, deleting any data that was created during the test.                                                                               |
| `@pytest.fixture`                                   | Set up a second test fixture                                                                                                                                                                   |
| `def client(app):`                                  | This fixture is named `client`. It will request the existing `app` fixture to run, first.                                                                                                                   |
| `return app.test_client()`                          | The responsibility of this fixture is to make a _test client_, which is an object able to _simulate_ a client making HTTP requests.                                                                         |

### !callout-secondary

## Practical Tip: Reading > Writing

Understanding how to read this code is more valuable than learning how to write it. On many projects, we set up test environments by referring back to code from a previous project. But we should strive to be able to read this code in order to:

- Have a better understanding of how the app runs, which will lead to better debugging
- Get familiar with the process of setting it up, in anticipation of future projects

### !end-callout

### The `client` Fixture

The majority of our tests will use the `client` fixture that was defined in `tests/conftest.py`.

While we're considering `tests/conftest.py`, let's look at a few ways we'll use `client`:

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
